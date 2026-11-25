#!/usr/bin/env bash
# Render every shell script template with non-interactive defaults and run ShellCheck on the output.
# The pre-commit ShellCheck hook skips *.tmpl, so this covers the chezmoi scripts.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# Answer every init prompt via env so rendering never blocks; secrets stay disabled.
export CHEZMOI_SETUP_TYPE=development CHEZMOI_USER_TYPE=sudo \
  CHEZMOI_ENCRYPTION=false CHEZMOI_PASS_MANAGER=false

cz=(chezmoi --source="$repo_root" --config="$work/chezmoi.toml"
    --cache="$work/cache" --persistent-state="$work/state.boltdb")

"${cz[@]}" execute-template --init < "$repo_root/home/.chezmoi.toml.tmpl" > "$work/chezmoi.toml"

status=0
while IFS= read -r -d '' tmpl; do
  rendered="$work/$(basename "${tmpl%.tmpl}")"
  if ! "${cz[@]}" execute-template < "$tmpl" > "$rendered"; then
    echo "::error file=$tmpl::template failed to render"
    status=1
    continue
  fi
  # Skip templates that render to nothing (feature disabled)
  [ -s "$rendered" ] || continue
  if ! shellcheck --severity=warning --shell=bash "$rendered"; then
    echo "::error file=$tmpl::ShellCheck failed (rendered output above)"
    status=1
  fi
done < <(find "$repo_root/home" -name '*.sh.tmpl' -print0)

exit "$status"
