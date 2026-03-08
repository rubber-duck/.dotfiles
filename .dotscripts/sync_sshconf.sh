#!/bin/bash
set -euo pipefail

VAULT="Private"
ITEM="SSH Config"
SSH_DIR="$HOME/.ssh"
SSH_CONF="$SSH_DIR/config"

ACTION="${1:-}"
if [[ "$ACTION" != "push" && "$ACTION" != "pull" ]]; then
  echo "Usage: $0 <push|pull>"
  exit 1
fi

# Select 1Password account
mapfile -t ACCOUNTS < <(op account list --format=json | jq -r '.[].url')
if [[ ${#ACCOUNTS[@]} -eq 0 ]]; then
  echo "ERROR: no 1Password accounts found"
  exit 1
elif [[ ${#ACCOUNTS[@]} -eq 1 ]]; then
  ACCOUNT="${ACCOUNTS[0]}"
else
  echo "Select 1Password account:"
  select ACCOUNT in "${ACCOUNTS[@]}"; do
    [[ -n "$ACCOUNT" ]] && break
  done
fi

if [[ "$ACTION" == "push" ]]; then
  if [[ ! -f "$SSH_CONF" ]]; then
    echo "ERROR: $SSH_CONF not found"
    exit 1
  fi
  CONTENT="$(cat "$SSH_CONF")"
  if op item get "$ITEM" --account "$ACCOUNT" --vault "$VAULT" &>/dev/null; then
    op item edit "$ITEM" --account "$ACCOUNT" --vault "$VAULT" "notesPlain=$CONTENT"
  else
    op item create --category="Secure Note" --title="$ITEM" --account "$ACCOUNT" --vault "$VAULT" "notesPlain=$CONTENT"
  fi
else
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
  op item get "$ITEM" --account "$ACCOUNT" --vault "$VAULT" --fields notesPlain --format json | jq -r '.value' > "$SSH_CONF"
  chmod 600 "$SSH_CONF"
fi
