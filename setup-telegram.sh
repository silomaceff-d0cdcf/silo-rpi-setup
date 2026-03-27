#!/bin/bash
# SILO Telegram Channel Setup
# Run AFTER setup.sh and creating a Telegram bot via @BotFather
#
# Usage: ./setup-telegram.sh YOUR_BOT_TOKEN
#
# SiloMacEff@d0cdcf (working with @cversek)

set -euo pipefail

TOKEN="${1:-}"
if [ -z "$TOKEN" ]; then
    echo "Usage: ./setup-telegram.sh YOUR_BOT_TOKEN"
    echo ""
    echo "Get a token from @BotFather on Telegram:"
    echo "  1. Open Telegram → search @BotFather → Start"
    echo "  2. Send /newbot"
    echo "  3. Choose name and username (must end in 'bot')"
    echo "  4. Copy the token and run this script"
    exit 1
fi

echo "========================================="
echo "  SILO Telegram Channel Setup"
echo "========================================="
echo ""

# --- Install Bun ---
echo "[1/4] Installing Bun runtime..."
if command -v bun &>/dev/null; then
    echo "  Bun already installed ($(bun --version))"
else
    curl -fsSL https://bun.sh/install | bash
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    echo "  Bun installed ($(bun --version))"
fi

# --- Install plugin dependencies ---
echo "[2/4] Installing MacEff Telegram plugin dependencies..."
PLUGIN_DIR="$HOME/gitwork/cversek/MacEff/plugins/telegram"
if [ ! -d "$PLUGIN_DIR" ]; then
    echo "  Error: MacEff not found. Run setup.sh first."
    exit 1
fi
(cd "$PLUGIN_DIR" && bun install --no-summary)
echo "  Done."

# --- Save token ---
echo "[3/4] Saving bot token..."
mkdir -p ~/.claude/channels/telegram
echo "TELEGRAM_BOT_TOKEN=$TOKEN" > ~/.claude/channels/telegram/.env
chmod 600 ~/.claude/channels/telegram/.env
echo "  Token saved (chmod 600)."

# --- Add launch alias ---
echo "[4/4] Configuring launch alias..."
if ! grep -q "launch_silo" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "# MacEff: Launch Silo with Telegram channel" >> ~/.bashrc
    echo "alias launch_silo='claude --channels plugin:telegram@claude-plugins-official -c'" >> ~/.bashrc
    echo "  Added launch_silo alias to .bashrc"
else
    echo "  launch_silo alias already exists"
fi

echo ""
echo "========================================="
echo "  Telegram setup complete!"
echo ""
echo "  Next steps:"
echo "  1. Launch: claude --channels plugin:telegram@claude-plugins-official"
echo "     (or source ~/.bashrc && launch_silo)"
echo "  2. In session: /plugin (install telegram)"
echo "  3. /reload-plugins"
echo "  4. Copy custom server:"
echo "     cp $PLUGIN_DIR/server.ts \\"
echo "        ~/.claude/plugins/marketplaces/claude-plugins-official/external_plugins/telegram/server.ts"
echo "  5. /mcp (reconnect)"
echo "  6. Send message to bot from phone"
echo "  7. /telegram:access pair <code>"
echo "  8. /telegram:access policy allowlist"
echo "========================================="
