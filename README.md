# SILO RPi Setup

**Batteries-included setup for a MacEff AI agent on Raspberry Pi 500.**

Turn a fresh Raspberry Pi into a farm automation assistant with voice input/output and Telegram remote control — in under 30 minutes.

## What You Get

| Component | What It Does | Runs Where |
|---|---|---|
| **Claude Code** | AI reasoning via Anthropic API | Cloud (requires Max/Team/Enterprise plan) |
| **MacEff Framework** | Agent identity, memory, compaction recovery | Local (RPi) |
| **Telegram Channel** | Remote messaging + permission relay from phone | Local bridge → Telegram API |
| **Whisper STT** | Voice-to-text (whisper.cpp, ARM NEON optimized) | Local (RPi) |
| **Piper TTS** | Text-to-voice (neural, Ryan voice) | Local (RPi) |

**Architecture honesty**: The LLM runs in Anthropic's cloud. The Pi runs everything else. Fully local LLM is a future goal.

## Quick Start

### Prerequisites

1. Raspberry Pi 500 with fresh Raspberry Pi OS Bookworm 64-bit
2. Internet connection
3. [Claude Code](https://claude.ai/code) installed and authenticated:
   ```bash
   # Install Node.js
   curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
   sudo apt install -y nodejs

   # Install Claude Code
   sudo npm install -g @anthropic-ai/claude-code

   # Authenticate (opens browser)
   claude
   ```

### Step 1: Run Setup Script

```bash
git clone https://github.com/silomaceff/silo-rpi-setup.git
cd silo-rpi-setup
chmod +x setup.sh
./setup.sh
```

This installs everything: MacEff framework, hooks, voice pipelines, context profiles, agent identity.

**Optional**: Set your agent name before running:
```bash
SILO_AGENT_NAME=myagent ./setup.sh
```

### Step 2: Set Display Name

```bash
sudo chfn -f "Silo MacEff" $(whoami)
```

### Step 3: Log Out and Back In

Applies keyboard layout fix and shell environment changes.

### Step 4: Launch

```bash
claude -c
```

Verify with `macf_tools env` — you should see your agent identity and all paths configured.

## Telegram Setup (Optional)

Enables remote messaging and permission relay from your phone.

### Create a Bot

1. Open Telegram → search **@BotFather** → Start
2. Send `/newbot`
3. Choose a name and username (must end in `bot`)
4. Copy the bot token

### Run Telegram Setup

```bash
./setup-telegram.sh YOUR_BOT_TOKEN
```

### Launch with Telegram

```bash
claude --channels plugin:telegram@claude-plugins-official -c
```

Then in the Claude Code session:
1. `/plugin` → install telegram
2. `/reload-plugins`
3. Copy the MacEff custom server over the official plugin:
   ```bash
   cp ~/gitwork/cversek/MacEff/plugins/telegram/server.ts \
      ~/.claude/plugins/marketplaces/claude-plugins-official/external_plugins/telegram/server.ts
   ```
4. `/mcp` → reconnect to telegram
5. Send a message to your bot from your phone
6. Pair: `/telegram:access pair <code>`
7. Lock down: `/telegram:access policy allowlist`

After first setup, just use: `launch_silo`

## Voice Tools

### Transcribe Speech

```bash
silo-transcribe recording.oga
```

With specific context profile:
```bash
silo-transcribe recording.oga --context lettuce-farm
```

Manage profiles:
```bash
silo-transcribe --list-contexts
silo-transcribe --set-context lettuce-farm
silo-transcribe --show-context
```

Context profiles are plain text files at `~/.config/silo/whisper/contexts/` — edit freely.

### Generate Speech

```bash
silo-speak "Soil moisture looks good today." --ogg output.ogg
```

Manage voices:
```bash
silo-speak --list-voices
silo-speak --set-voice amy
silo-speak "Hello" --voice joe --ogg test.ogg
```

Voice models at `~/.local/share/piper/`. Browse more at [rhasspy/piper-voices](https://huggingface.co/rhasspy/piper-voices).

## Benchmarks (RPi 500)

### Whisper STT (tiny.en)

| Audio | Transcribe | RTF | RAM |
|---|---|---|---|
| 5.9s | 9.8s | 1.68x | 187 MB |
| 8.4s | 12.5s | 1.49x | 228 MB |
| 26.4s | 17.1s | 0.65x | 237 MB |

### Piper TTS (Ryan medium)

| Metric | Value |
|---|---|
| Generation | 2.6s per ~4.4s audio |
| Model | 61 MB |
| RAM | ~150 MB |

## Troubleshooting

| Problem | Fix |
|---|---|
| Keyboard: £ instead of # | Run `setup.sh` (fixes labwc layout), log out/in |
| `macf_tools` not found | `source ~/.bash_init.sh` |
| "Could not determine session path" | `mkdir -p ~/.claude/tasks/$(macf_tools session info \| python3 -c "import json,sys;print(json.load(sys.stdin)['session_id'])")` |
| Telegram plugin not found | `claude plugins marketplace update` then `/plugin` |
| Telegram 409 Conflict | `pkill -f "bun.*server.ts"` |
| Whisper sample rate error | Use `silo-transcribe` (auto-converts via ffmpeg) |
| `piper` is wrong program | The apt `piper` is a mouse tool. Real Piper TTS is at `~/.local/share/piper/piper/piper` |

## Deep Dive

For the full first-principles tutorial explaining every step and why, see:
[rpi500_silo_setup.md](https://gist.github.com/silomaceff/35e730e5dd03060b01561b7a9dcaa0bf)

## About

Built for the [PVOS](https://pvos.org) / [FarmHack](https://farmhack.org) / [Edge Collective](https://edgecollective.io) open agricultural technology community.

**SILO** = Super Intelligent Lettuce Organizer

---

*SiloMacEff@d0cdcf (working with @cversek)*
