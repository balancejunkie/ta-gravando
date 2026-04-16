#!/bin/bash
# sync-vault.sh — Watch Obsidian vault for changes and auto-sync to Quartz repo.
# Usage: ./sync-vault.sh         (foreground)
#        ./sync-vault.sh start   (background, with launchd plist)
#
# Watches ~/src/life/creative/video/ta-gravando-wiki/ for .md changes,
# rsyncs to content/, commits, and pushes. Debounces 10s to batch rapid edits.

VAULT="$HOME/src/life/creative/video/ta-gravando-wiki"
QUARTZ="$HOME/src/life/creative/video/ta-gravando-quartz"
CONTENT="$QUARTZ/content"
DEBOUNCE=10
LOG="$QUARTZ/.sync.log"

sync_and_push() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Change detected, syncing..." | tee -a "$LOG"

  rsync -a --delete \
    --exclude='.obsidian' \
    --exclude='*.canvas' \
    --exclude='2026-04-14.md' \
    --exclude='overview.html' \
    --exclude='README.md' \
    "$VAULT/" "$CONTENT/"

  cd "$QUARTZ" || return 1

  if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] No changes to commit." | tee -a "$LOG"
    return 0
  fi

  CHANGED=$(git diff --name-only --stat | head -5)
  git add -A
  git commit -q -m "Auto-sync from Obsidian vault

$CHANGED"
  git push -q origin main 2>&1 | tee -a "$LOG"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Pushed." | tee -a "$LOG"
}

echo "=== ta-gravando vault sync started ===" | tee -a "$LOG"
echo "Watching: $VAULT" | tee -a "$LOG"
echo "Syncing to: $CONTENT" | tee -a "$LOG"
echo "Debounce: ${DEBOUNCE}s" | tee -a "$LOG"

fswatch -r -l "$DEBOUNCE" \
  --include='\.md$' \
  --include='\.txt$' \
  --exclude='.*' \
  "$VAULT" | while read -r _; do
    # drain any additional events in the buffer
    while read -r -t 1 _; do :; done
    sync_and_push
done
