#!/usr/bin/env bash
set -euo pipefail

# ── Paths ─────────────────────────────────────────────────────────────────────
JEKYLL_DIR="$(pwd)"
BLOG_SRC="$(dirname "$JEKYLL_DIR")/blog-src"

# ── Helpers ───────────────────────────────────────────────────────────────────
log() { echo "[$(date '+%H:%M:%S')] $*"; }

# ── Preflight checks ──────────────────────────────────────────────────────────
if ! command -v fswatch &>/dev/null; then
  echo "Error: fswatch not found. Install it with: brew install fswatch"
  exit 1
fi

if [ ! -d "$BLOG_SRC" ]; then
  echo "Error: source repo not found at '$BLOG_SRC'"
  exit 1
fi

# ── Sync helper ───────────────────────────────────────────────────────────────
RSYNC_EXCLUDES=(
  --exclude='._*'
  --exclude='.DS_Store'
  --exclude='.Spotlight-V100'
  --exclude='*.swp'
  --exclude='*~'
)

do_sync() {
  rsync -av --delete "${RSYNC_EXCLUDES[@]}" "$BLOG_SRC/_posts/"  "$JEKYLL_DIR/_posts/"
  rsync -av --delete "${RSYNC_EXCLUDES[@]}" "$BLOG_SRC/_drafts/" "$JEKYLL_DIR/_drafts/"
  rsync -av --delete "${RSYNC_EXCLUDES[@]}" "$BLOG_SRC/media/"   "$JEKYLL_DIR/media/"
}

# ── Initial sync ──────────────────────────────────────────────────────────────
log "Initial rsync..."
do_sync
log "Initial sync done."

# ── Cleanup on exit ───────────────────────────────────────────────────────────
PIDS=()
cleanup() {
  log "Shutting down..."
  for pid in "${PIDS[@]}"; do kill "$pid" 2>/dev/null || true; done
  wait 2>/dev/null || true
  log "Done."
}
trap cleanup EXIT INT TERM

# ── File watcher ──────────────────────────────────────────────────────────────
watch_and_sync() {
  log "Watching $BLOG_SRC for changes..."
  fswatch \
    --event Created --event Updated --event Removed --event Renamed \
    --exclude '/\._' --exclude '/\.DS_Store' --exclude '/\.Spotlight' \
    "$BLOG_SRC/_posts" "$BLOG_SRC/_drafts" "$BLOG_SRC/media" \
  | while read -r; do
      log "Change detected, syncing..."
      do_sync
      log "Sync complete."
    done
}

watch_and_sync &
PIDS+=($!)

# ── Jekyll ────────────────────────────────────────────────────────────────────
log "Starting Jekyll${*:+ (flags: $*)}..."
bundle exec jekyll serve --livereload "$@" &
PIDS+=($!)

# ── Jekyll ────────────────────────────────────────────────────────────────────
# Prevent the end of the script until the user ends
wait
