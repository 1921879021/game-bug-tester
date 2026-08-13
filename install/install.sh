#!/usr/bin/env sh
set -eu

HOST="${1:-}"
PROJECT="${2:-.}"
SELF_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

case "$HOST" in
  codex) TARGET="$PROJECT/.agents/skills/game-bug-tester" ;;
  claude|claude-code) TARGET="$PROJECT/.claude/skills/game-bug-tester" ;;
  *) echo "Usage: install.sh codex|claude [project-dir]" >&2; exit 2 ;;
esac

mkdir -p "$(dirname "$TARGET")"
if [ -e "$TARGET" ]; then
  echo "Target exists: $TARGET" >&2
  exit 3
fi
mkdir -p "$TARGET"

# Copy repository contents only. Skip nested VCS/host skill directories so the
# helper is safe even if it is run while PROJECT points at the source checkout.
(
  cd "$SELF_DIR"
  tar --exclude=.git --exclude=.agents --exclude=.claude -cf - .
) | (
  cd "$TARGET"
  tar -xf -
)

echo "Installed Game Bug Tester to $TARGET"
echo "No packages, plugins, SDKs, or QA frameworks were installed."
