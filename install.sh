#!/usr/bin/env bash
# Deploy the PAI seven-phase ISC loop into a pi (or compatible) agent environment.
# Symlinks the live locations to this repo so the repo is the single source of truth.
# Re-runnable and reversible (originals backed up to *.bak.<ts> on first run).
set -eu

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

link() { # link <target-in-repo> <live-path>
	local src="$1" dst="$2"
	mkdir -p "$(dirname "$dst")"
	if [ -e "$dst" ] && [ ! -L "$dst" ]; then
		mv "$dst" "${dst}.bak.${TS}"
		echo "  backed up $dst -> ${dst}.bak.${TS}"
	fi
	ln -sfn "$src" "$dst"
	echo "  linked $dst -> $src"
}

echo "Deploying PAI ISC loop from $REPO"
link "$REPO/AGENTS.md" "$HOME/AGENTS.md"
link "$REPO/skills/isc-loop" "$HOME/.agents/skills/isc-loop"
link "$REPO/skills/isa" "$HOME/.agents/skills/isa"
echo "Done. Run '/reload' in pi (or restart) to pick up skills + context files."
echo "Per-project pointer template: $REPO/templates/project-AGENTS.md"
