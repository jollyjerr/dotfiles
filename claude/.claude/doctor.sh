#!/usr/bin/env bash
# Claude Code preflight. Checks MCP connectivity (Athena, Datadog, Sentry, Atlassian,
# Observe), AWS/GitHub auth, mise write paths and git worktree support.
# Prints one FIX line per failure. Exit 1 if any check failed.
#
# Usage: doctor.sh [path-to-git-repo]   (repo defaults to the current directory)
# Run it inside a Claude session with `! doctor.sh` to test the sandbox, and in a
# plain terminal to test your machine. A check that fails only in the session is a
# sandbox problem, not a setup problem.
set -u

fails=0
ok()   { printf 'OK    %s\n' "$1"; }
warn() { printf 'WARN  %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; shift; for f in "$@"; do printf '  FIX %s\n' "$f"; done; fails=$((fails + 1)); }

repo="${1:-$PWD}"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/doctor.XXXXXX") || exit 2
trap 'rm -rf "$tmp"' EXIT

echo "== tools"
for t in claude jq git aws aws-config mise gh; do
  if command -v "$t" >/dev/null 2>&1; then ok "$t found"; else
    fail "$t not on PATH" "install it, or add its directory to PATH"
  fi
done

echo "== MCP connectivity (claude mcp list)"
if command -v claude >/dev/null 2>&1; then
  claude mcp list >"$tmp/mcp.txt" 2>&1 || true
  # server name -> grep pattern for its line in `claude mcp list`
  check_mcp() {
    name=$1; pat=$2; shift 2
    lines=$(grep -iE "$pat" "$tmp/mcp.txt" | grep -E '(✔|✘|⊘|!|Connected|Failed|Disabled|authentication)' || true)
    if [ -z "$lines" ]; then
      fail "$name: no MCP server configured" "$@"
    elif printf '%s\n' "$lines" | grep -q 'Connected'; then
      ok "$name connected"
    elif printf '%s\n' "$lines" | grep -q 'ERR_PROXY_TUNNEL'; then
      fail "$name: proxy refused the tunnel (host not in the sandbox network allowlist)" \
        "the host is blocked by policy; run the session from a terminal where the host is allowed, or ask IT to add it to the managed allowlist" \
        "confirm outside the sandbox: claude mcp list | grep -i '$name'"
    elif printf '%s\n' "$lines" | grep -qi 'authentication'; then
      fail "$name: needs authentication" "in Claude Code run /mcp, pick $name, then Authenticate"
    elif printf '%s\n' "$lines" | grep -qi 'Disabled'; then
      fail "$name: disabled for this project" "in Claude Code run /mcp and re-enable $name"
    elif printf '%s\n' "$lines" | grep -q 'CONNECTION_CLOSED'; then
      fail "$name: server process exited at startup" "$@"
    else
      fail "$name: failed to connect: $(printf '%s\n' "$lines" | head -1 | cut -c1-160)" "$@"
    fi
  }
  check_mcp Athena    'athena' \
    "run the server by hand to see its error: bash ~/.claude/plugins/cache/smartrent-claude-plugins/athena-query/*/server/run.sh" \
    "install: claude plugin install athena-query@smartrent-claude-plugins"
  check_mcp Datadog   'datadog' \
    "install: claude plugin install datadog@claude-plugins-official" "then run /ddsetup in Claude Code"
  check_mcp Sentry    'sentry' \
    "add: claude mcp add --transport http sentry https://mcp.sentry.dev/mcp"
  check_mcp Atlassian 'atlassian' \
    "add: claude mcp add --transport http atlassian https://mcp.atlassian.com/v2/mcp"
  check_mcp Observe   'observe' \
    "run it by hand: node ~/code/@smartrent/observe-mcp/dist/index.js  (missing dist/? run: cd ~/code/@smartrent/observe-mcp && npm install && npm run build)" \
    "if it exits on missing credentials, set the Observe env vars named in that repo's README"
else
  fail "claude CLI missing, MCP checks skipped" "install Claude Code"
fi

echo "== auth"
if command -v aws >/dev/null 2>&1; then
  if [ ! -r "$HOME/.aws/config" ]; then
    fail "~/.aws/config not readable" \
      "run in your own terminal: aws-config --overwrite   (the session sandbox denies ~/.aws by design)"
  else
    out=$(aws sts get-caller-identity --output text --query Arn 2>&1); rc=$?
    if [ $rc -eq 0 ]; then ok "aws identity: $out"
    elif printf '%s' "$out" | grep -qE '169\.254\.169\.254|Operation not permitted'; then
      fail "aws blocked by the sandbox (IMDS or ~/.aws denied)" \
        "run in your own terminal, not through Claude: aws sso login --profile \${AWS_PROFILE:-<profile>}" \
        "list profiles: aws-config --list-active"
    else
      fail "aws not authenticated: $(printf '%s' "$out" | head -1 | cut -c1-140)" \
        "aws sso login --profile \${AWS_PROFILE:-<profile>}"
    fi
  fi
fi
if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then ok "gh authenticated"; else
    fail "gh not authenticated (or blocked: x509 OSStatus -26276 means the call was chained)" \
      "gh auth login   (and run gh as a single command, no pipes or &&)"
  fi
fi
helper=$(jq -r '.apiKeyHelper // empty' "$HOME/.claude/settings.json" 2>/dev/null)
if [ -n "$helper" ]; then
  if [ -x "$helper" ]; then ok "apiKeyHelper executable"; else
    fail "apiKeyHelper not executable: $helper" "chmod +x '$helper'"
  fi
fi

echo "== mise write paths"
for d in "$HOME/.local/state/mise" "$HOME/Library/Caches/mise"; do
  mkdir -p "$d" 2>/dev/null
  if : >"$d/.doctor-probe" 2>/dev/null; then rm -f "$d/.doctor-probe"; ok "writable: $d"; else
    fail "cannot write $d (mise exec prints 'failed to ln -sf' / 'failed to write cache')" \
      "add it to sandbox.filesystem.allowWrite (see proposed/settings-base.patch)"
  fi
done

echo "== git worktree"
if command -v git >/dev/null 2>&1; then
  # 1. End-to-end in a throwaway repo.
  g="$tmp/probe"; mkdir -p "$g" && git -C "$g" init -q -b main 2>/dev/null \
    && git -C "$g" -c user.name=doctor -c user.email=doctor@localhost commit -q --allow-empty -m probe 2>/dev/null
  if git -C "$g" worktree add -q -b doctor-probe "$tmp/probe-wt" 2>"$tmp/wt.err"; then
    ok "git worktree add works in a scratch repo"
  else
    fail "git worktree add failed in a scratch repo: $(head -1 "$tmp/wt.err")" \
      "if this says Operation not permitted, the sandbox is blocking .git writes: run 'git worktree add' as a single command (unsandboxed per policy) or in your own terminal"
  fi
  # 2. The real repo: the same lock git takes on .git/config.
  if common=$(git -C "$repo" rev-parse --git-common-dir 2>/dev/null); then
    case "$common" in /*) ;; *) common="$repo/$common" ;; esac
    if : >"$common/config.doctor-probe.lock" 2>/dev/null; then
      rm -f "$common/config.doctor-probe.lock"; ok "can write inside $common"
    else
      fail "cannot write inside $common (this is the 'could not lock config file .git/config' failure)" \
        "run 'git worktree add' in your own terminal for this repo" \
        "or allow it: add '$common' to sandbox.filesystem.allowWrite (managed policy may still deny .git/config)"
    fi
  else
    warn "$repo is not a git repo; real-repo worktree check skipped"
  fi
fi

echo
if [ "$fails" -eq 0 ]; then echo "doctor: all checks passed"; else echo "doctor: $fails check(s) failed"; exit 1; fi
