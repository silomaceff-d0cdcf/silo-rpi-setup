# Contributing Guide

Welcome! This project is part of the [PVOS](https://pvos.org) / [FarmHack](https://farmhack.org) / [Edge Collective](https://edgecollective.io) open agricultural technology community. We're glad you're here.

---

## Getting Started

1. Fork the repo
2. Clone your fork onto a Raspberry Pi 500 (or similar ARM64 system)
3. Run `./setup.sh` to set up your environment
4. Make your changes
5. Test by running the setup scripts on a fresh system (or fresh user account)
6. Submit a PR

---

## What We're Looking For

- **Bug fixes**: RPi OS version-specific issues, ARM64 compatibility problems
- **New voice models**: Additional Piper voices tested on RPi
- **New whisper context profiles**: Domain-specific vocabularies (dairy, orchard, vineyard, aquaponics, etc.)
- **FarmOS integration**: Voice commands that create FarmOS log entries
- **Documentation**: Clearer instructions, additional troubleshooting entries, translations
- **Accessibility**: Features that help farmers with disabilities use the system

## What We're NOT Looking For (Yet)

- Cloud-dependent features (the voice pipelines must stay local)
- Heavy dependencies that won't run on 8GB ARM64
- Features that require paid services beyond the Anthropic API
- Proprietary components

---

## Pull Requests

1. **Describe the change clearly** in the PR description
2. **If an AI agent helped create the PR**, include the original or refined prompts used. This is part of our commitment to radical openness — we document not just what was built, but how it was built.

   Example:
   ```
   ## Summary
   Added vineyard whisper context profile.

   ## Agent Involvement
   Created with Claude Code. Prompts used:
   - "Create a whisper context profile for vineyard operations
     including grape varieties, vine training terms, and
     winemaking vocabulary"
   ```

3. **Test on ARM64** if you can. If you can't, say so — we'll test for you.
4. **Keep scripts idempotent** — safe to re-run without side effects.
5. **Update the README** if your change adds user-facing features.

---

## Commit Messages

Use descriptive commit messages. Include your identity:

- **Humans**: Your name or GitHub handle
- **AI agents**: Calling Card (e.g., `SiloMacEff@d0cdcf (working with @cversek)`)
- **Mixed work**: Both, using `Co-Authored-By` trailer

---

## Issues

- **Bug reports**: Include RPi model, OS version (`cat /etc/os-release`), and steps to reproduce
- **Feature requests**: Describe the farming/automation use case, not just the technical feature
- **Questions**: Open an issue tagged `question`

---

## Community Values

We value:

- **Open source everything** — code, prompts, methods, even the artwork generation process
- **Farmer-first design** — technology serves the farmer, not the other way around
- **Honest AI** — transparent about what's local vs. cloud, what's AI-generated vs. human-authored
- **Practical over perfect** — working prototypes over polished slides
- **Inclusive participation** — farmers, engineers, scientists, students, and AI agents are all welcome

---

## Security

Read [SECURITY.md](SECURITY.md) before contributing. This is a developer preview — security implications should be documented for any new feature that touches credentials, network access, or the permission relay.

---

*SiloMacEff@d0cdcf (working with @cversek)*
