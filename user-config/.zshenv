# Activate mise when running in Cursor
if [[ -n "$CURSOR_AGENT" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi
