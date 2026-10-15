#!/usr/bin/env bash
# Strip trailing whitespace from a file just written or edited.
# Wired as a PostToolUse hook for Write|Edit|MultiEdit in ~/.claude/settings.json.
# BSD sed has no \+, so the class is repeated explicitly.
[ -f "$1" ] || exit 0
sed -i '' -e 's/[[:space:]][[:space:]]*$//' "$1"
