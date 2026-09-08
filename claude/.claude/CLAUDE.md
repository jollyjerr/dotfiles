# Global Claude Configuration

## Coding Preferences
- Never add logging unless explicitly asked to do so.

## gh CLI
- `gh api --jq` does NOT support `--arg` for passing shell variables into jq. It silently produces no output.
- Always use env vars instead: `REPO="$repo" gh api ... --jq '... env.REPO ...'`

## Testing Style
- Write test titles as `"should ..."` with active verb form (e.g., "should force X to true", "should cancel the debounce").

## Reporting on Unexpected State
- If a file/change I expect to exist is missing (or otherwise not as expected), don't assert a confident explanation ("it must not have persisted", "it was never saved"). Investigate first (`git status`, `git log`, `git diff`) and report what actually happened. If the cause is genuinely unclear after checking, say so plainly instead of guessing.
- This applies generally: prefer "here's what I observe" over inventing a plausible-sounding cause, especially one that could have been a deliberate user action.
