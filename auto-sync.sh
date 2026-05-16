#!/usr/bin/env bash
# auto-sync.sh — watch the project directory and auto git add/commit/push
# after a quiet period. Run from the project root: ./auto-sync.sh

set -u

DEBOUNCE_SECONDS=10
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "$0")"

cd "$REPO_DIR" || exit 1

if ! command -v fswatch >/dev/null 2>&1; then
  echo "Error: fswatch not installed. Run: brew install fswatch" >&2
  exit 1
fi

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Error: not a git repository ($REPO_DIR)" >&2
  exit 1
fi

REMOTE_BRANCH="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"
if [ -z "$REMOTE_BRANCH" ]; then
  echo "Error: current branch has no upstream. Set one with: git push -u origin <branch>" >&2
  exit 1
fi

log() { printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*"; }

commit_and_push() {
  if [ -z "$(git status --porcelain)" ]; then
    return 0
  fi

  local file_count changed_files msg
  file_count="$(git status --porcelain | wc -l | tr -d ' ')"
  changed_files="$(git status --porcelain | awk '{print $NF}' | head -5 | tr '\n' ',' | sed 's/,$//')"

  msg="Auto-sync: $file_count file(s) — $changed_files"
  [ "$file_count" -gt 5 ] && msg="$msg, ..."

  log "Staging $file_count file(s)"
  git add -A

  if [ -z "$(git diff --cached --name-only)" ]; then
    return 0
  fi

  log "Committing: $msg"
  if ! git commit -m "$msg" >/dev/null; then
    log "Commit failed"
    return 1
  fi

  log "Pushing to $REMOTE_BRANCH"
  if git push >/dev/null 2>&1; then
    log "Push OK"
  else
    log "Push failed — run 'git push' manually to see the error"
    return 1
  fi
}

cleanup() {
  log "Stopping auto-sync"
  [ -n "${WATCH_PID:-}" ] && kill "$WATCH_PID" 2>/dev/null
  exit 0
}
trap cleanup INT TERM

log "Watching: $REPO_DIR"
log "Debounce: ${DEBOUNCE_SECONDS}s  |  Branch: $REMOTE_BRANCH"
log "Ctrl+C to stop"

# Stream fswatch events into fd 3 so we can use a non-blocking read with timeout.
exec 3< <(fswatch -r \
  --exclude '\.git(/|$)' \
  --exclude "$SCRIPT_NAME" \
  --exclude '\.DS_Store$' \
  "$REPO_DIR")
WATCH_PID=$!

last_event=0
pending=0
while true; do
  if read -r -t 1 _line <&3; then
    last_event=$(date +%s)
    pending=1
  else
    now=$(date +%s)
    if [ "$pending" -eq 1 ] && [ $((now - last_event)) -ge "$DEBOUNCE_SECONDS" ]; then
      pending=0
      commit_and_push || true
    fi
  fi
done
