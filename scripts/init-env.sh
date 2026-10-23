#!/usr/bin/env sh
# Creates real env files from the .example templates with fresh random secrets.
set -eu
cd "$(dirname "$0")/.."

FILES="backend/.env ai-service/.env postgres/.env judge0/judge0.conf frontend/.env"

# every template must exist
missing=""
for f in $FILES; do
  [ -f "$f.example" ] || missing="$missing $f.example"
done
if [ -n "$missing" ]; then
  echo "Missing template files:" >&2
  for m in $missing; do echo "  - $m" >&2; done
  exit 1
fi

# collect ALL existing targets before deciding anything
existing=""
for f in $FILES; do
  [ -f "$f" ] && existing="$existing $f"
done
if [ -n "$existing" ]; then
  echo "Refusing to overwrite existing files:" >&2
  for f in $existing; do echo "  - $f" >&2; done
  echo "Delete them (or the whole set) and re-run to regenerate." >&2
  exit 1
fi

rand() { openssl rand -hex "$1"; }
PG=$(rand 16); AUTH=$(rand 32); AI=$(rand 16)
REDIS=$(rand 24); J0PG=$(rand 24); SKB=$(rand 64)

for f in $FILES; do
  sed -e "s|__PG_PASSWORD__|$PG|g" \
      -e "s|__AUTH_SECRET__|$AUTH|g" \
      -e "s|__AI_KEY__|$AI|g" \
      -e "s|__REDIS_PASSWORD__|$REDIS|g" \
      -e "s|__J0_PG_PASSWORD__|$J0PG|g" \
      -e "s|__SECRET_KEY_BASE__|$SKB|g" \
      "$f.example" > "$f"
  echo "created $f"
done