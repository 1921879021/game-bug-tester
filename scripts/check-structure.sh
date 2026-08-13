#!/usr/bin/env sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

for f in \
  SKILL.md README.md README.zh-CN.md VERSION LICENSE CONTRIBUTING.md SECURITY.md \
  CODE_OF_CONDUCT.md RELEASE_NOTES_v1.0.0.md references/core/bug_catalog.yaml; do
  test -f "$ROOT/$f" || { echo "Missing required file: $f" >&2; exit 1; }
done

[ "$(cat "$ROOT/VERSION")" = "1.0.0" ] || { echo "Unexpected VERSION" >&2; exit 1; }

grep -q '^name: game-bug-tester$' "$ROOT/SKILL.md"
grep -q '^description:' "$ROOT/SKILL.md"

# Portable public frontmatter: only name + description.
FRONT_KEYS=$(awk '
  NR==1 && $0=="---" {inside=1; next}
  inside && $0=="---" {exit}
  inside && $0 ~ /^[A-Za-z0-9_-]+:/ {sub(/:.*/, "", $0); print $0}
' "$ROOT/SKILL.md" | sort)
EXPECTED_KEYS=$(printf '%s\n' description name)
[ "$FRONT_KEYS" = "$EXPECTED_KEYS" ] || {
  echo "Unexpected SKILL.md frontmatter keys:" >&2
  echo "$FRONT_KEYS" >&2
  exit 1
}

if grep -Eqi 'must (install|pip install|npm install)|required dependency: (airtest|poco|alttester)' "$ROOT/SKILL.md"; then
  echo "Potential mandatory dependency language found" >&2
  exit 1
fi

COUNT=$(grep -Ec '^- id: ' "$ROOT/references/core/bug_catalog.yaml" || true)
if [ "$COUNT" -ne 81 ]; then
  echo "Expected 81 bug patterns, found $COUNT" >&2
  exit 1
fi
DUPES=$(grep '^- id: ' "$ROOT/references/core/bug_catalog.yaml" | sed 's/^- id: //' | sort | uniq -d)
if [ -n "$DUPES" ]; then
  echo "Duplicate bug IDs:" >&2
  echo "$DUPES" >&2
  exit 1
fi

PYFILES=$(find "$ROOT" -type f -name '*.py' | wc -l | tr -d ' ')
if [ "$PYFILES" -ne 0 ]; then
  echo "Public zero-dependency release unexpectedly contains Python files" >&2
  exit 1
fi

if grep -RIl '1\.0\.0-public\|game-bug-tester-public' "$ROOT" --exclude-dir=.git --exclude='PUBLIC_RELEASE_CHECK.txt' --exclude='check-structure.sh' --exclude='check-structure.ps1' >/dev/null 2>&1; then
  echo "Stale pre-release naming found" >&2
  grep -RIn '1\.0\.0-public\|game-bug-tester-public' "$ROOT" --exclude-dir=.git --exclude='PUBLIC_RELEASE_CHECK.txt' --exclude='check-structure.sh' --exclude='check-structure.ps1' >&2 || true
  exit 1
fi

echo "Structure OK; version: 1.0.0; bug patterns: $COUNT; mandatory Python files: $PYFILES"
