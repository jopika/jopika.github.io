#!/usr/bin/env bash
set -euo pipefail

# ── Paths ─────────────────────────────────────────────────────────────────────
# Script is expected to be run from the Jekyll root directory.
# BLOG_SRC is the content repo, assumed to be cloned as a sibling directory.
# Change "blog-src" to match your actual repo folder name.
JEKYLL_DIR="$(pwd)"
BLOG_SRC="$(dirname "$JEKYLL_DIR")/blog-src"

# ── Helpers ───────────────────────────────────────────────────────────────────
log() { echo "[$(date '+%H:%M:%S')] $*"; }

# ── Preflight checks ──────────────────────────────────────────────────────────
if ! command -v fswatch &>/dev/null; then
  echo "Error: fswatch not found. Install it with: brew install fswatch"
  exit 1
fi

if ! command -v rsync &>/dev/null; then
  echo "Error: rsync not found. Install it with: brew install rsync"
  exit 1
fi

if [ ! -d "$BLOG_SRC" ]; then
  echo "Error: source repo not found at '$BLOG_SRC'"
  exit 1
fi

# ── Symlink check ─────────────────────────────────────────────────────────────
# If any destination folder is still a symlink pointing into BLOG_SRC, rsync
# writes would modify the source — causing an infinite loop.
for dir in _posts _drafts media; do
  dest="$JEKYLL_DIR/$dir"
  if [ -L "$dest" ]; then
    real=$(readlink "$dest")
    echo "ERROR: $dest is a symlink -> $real"
    echo "This will cause a sync loop. Remove it and let the script manage the folder:"
    echo "  rm \"$dest\""
    exit 1
  fi
done

# ── Sync helper ───────────────────────────────────────────────────────────────
# Excludes macOS metadata noise (Spotlight sidecars, Finder state) from both
# rsync and the change-detection check.
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

# ── Initial sync before starting Jekyll ──────────────────────────────────────
log "Initial rsync..."
do_sync
log "Initial sync done."

# ── Cleanup on exit ───────────────────────────────────────────────────────────
SYNC_MARKER="/tmp/jekyll-sync-marker"
PIDS=()
CLEANED_UP=false
cleanup() {
  if [ "$CLEANED_UP" = true ]; then return; fi
  CLEANED_UP=true
  log "Shutting down..."
  for pid in "${PIDS[@]}"; do
    kill "$pid" 2>/dev/null || true
  done
  rm -f "$SYNC_MARKER"
  wait 2>/dev/null || true
  log "Done."
}
trap cleanup EXIT INT TERM

# ── File watcher ──────────────────────────────────────────────────────────────
watch_and_sync() {
  touch "$SYNC_MARKER"

  log "Watching $BLOG_SRC for changes..."
  while true; do
    fswatch -1 \
      --event Created \
      --event Updated \
      --event Removed \
      --event Renamed \
      --exclude '/\._' \
      --exclude '/\.DS_Store' \
      --exclude '/\.Spotlight' \
      "$BLOG_SRC/_posts" "$BLOG_SRC/_drafts" "$BLOG_SRC/media" > /dev/null

    # Find real content files (not macOS metadata) that changed since last sync.
    changed=$(find "$BLOG_SRC/_posts" "$BLOG_SRC/_drafts" "$BLOG_SRC/media" \
      -type f \
      -not -name '._*' \
      -not -name '.DS_Store' \
      -not -name '*.swp' \
      -not -name '*~' \
      -newer "$SYNC_MARKER" 2>/dev/null)

    if [ -n "$changed" ]; then
      log "Change detected in:"
      echo "$changed" | sed "s|$BLOG_SRC/||" | while read -r f; do log "  $f"; done
      do_sync
      touch "$SYNC_MARKER"
      log "Sync complete."
    else
      log "Phantom event (macOS metadata noise), skipping."
    fi
  done
}

watch_and_sync &
PIDS+=($!)

# ── Jekyll ────────────────────────────────────────────────────────────────────
# Any flags passed to this script are forwarded to jekyll serve (e.g. --drafts).
JEKYLL_FLAGS=("$@")
log "Starting Jekyll${JEKYLL_FLAGS[*]:+ (flags: ${JEKYLL_FLAGS[*]})}..."
bundle exec jekyll serve --livereload "${JEKYLL_FLAGS[@]+"${JEKYLL_FLAGS[@]}"}" &
PIDS+=($!)

# ── Wait ──────────────────────────────────────────────────────────────────────
# Waits for background jobs or until the job is cancelled.
wait
