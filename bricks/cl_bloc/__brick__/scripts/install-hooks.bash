#!/usr/bin/env bash
# Install git hooks — creates a symlink from .git/hooks/pre-commit to our script

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
# -s symlink, -f force overwrite if already exists (safe for re-runs)
ln -sf ../../scripts/pre-commit.bash "$GIT_DIR/hooks/pre-commit"
echo "Done! Git hooks installed."