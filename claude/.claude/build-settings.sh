#!/usr/bin/env bash
set -euo pipefail

base="$HOME/.claude/settings.base.json"
out="$HOME/.claude/settings.json"

shopt -s nullglob
overlays=("$HOME"/.claude/settings.d/*.json)

tmp=$(mktemp "$out.XXXXXX")
trap 'rm -f "$tmp"' EXIT
jq -s '
  def merge($a; $b):
    if ($a | type) == "object" and ($b | type) == "object" then
      reduce ($b | keys_unsorted[]) as $k ($a; .[$k] = merge(.[$k]; $b[$k]))
    elif ($a | type) == "array" and ($b | type) == "array" then
      $a + ($b - $a)
    else
      $b
    end;
  reduce .[] as $s ({}; merge(.; $s))
' "$base" ${overlays[@]+"${overlays[@]}"} > "$tmp"
mv "$tmp" "$out"
echo "INFO: wrote $out from $base ${overlays[*]-}"
