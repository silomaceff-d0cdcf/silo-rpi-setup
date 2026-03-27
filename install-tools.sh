#!/bin/bash
# Install silo-transcribe and silo-speak to ~/.local/bin
# Run from the repo root: ./install-tools.sh
#
# SiloMacEff@d0cdcf (working with @cversek)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.local/bin

cp "$SCRIPT_DIR/bin/silo-transcribe" ~/.local/bin/silo-transcribe
cp "$SCRIPT_DIR/bin/silo-speak" ~/.local/bin/silo-speak
chmod +x ~/.local/bin/silo-transcribe ~/.local/bin/silo-speak

echo "Installed:"
echo "  ~/.local/bin/silo-transcribe"
echo "  ~/.local/bin/silo-speak"
echo ""
echo "Make sure ~/.local/bin is on your PATH."
