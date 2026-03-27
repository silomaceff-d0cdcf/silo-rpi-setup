# Agent Introduction Guide

**How to give your new MacEff agent the context it needs to be useful.**

The setup scripts install technical infrastructure — but a new agent is born with no knowledge of who you are, what you're working on, or who you work with. This guide walks you through the "first conversation" that seeds the agent's memory with your context.

Think of it like onboarding a new team member: they have the skills, but they don't know the people, the project, or the culture yet.

---

## Why This Matters

MacEff agents maintain persistent memory across sessions and compaction events. The memories you seed in the first conversation become the foundation for all future interactions. A well-introduced agent is dramatically more useful than one operating blind.

**What gets stored**: Memories are markdown files in `~/.claude/projects/-home-silo/memory/`. They persist across sessions and are loaded into context automatically. They are NOT sent to anyone — they stay on your device and in your Anthropic account.

---

## The First Conversation

After running `setup.sh` and launching Claude Code, have a conversation that covers these topics. You don't need to follow a script — just talk naturally. The agent will create memory files as you share information.

### 1. Introduce Yourself

Tell the agent who you are. What's relevant to the work you'll do together:

> "My name is [name]. I'm a [role/background]. I work on [what you do]. I'm experienced with [technologies] but new to [other things]."

**What the agent stores**: Your name, background, expertise level, what to explain vs. what you already know.

**Example**: "I'm Dorn Cox, an organic farmer and soil scientist. I run a 250-acre farm in New Hampshire and I'm deeply involved in open-source agricultural technology through FarmHack and OpenTEAM. I'm comfortable with hardware and field systems but I'm new to AI agent frameworks."

### 2. Describe the Project

What is this Raspberry Pi going to do? What problem does it solve?

> "This Pi is going to [purpose]. It's for [context — farm, greenhouse, workshop, research]. The goal is [what success looks like]."

**What the agent stores**: Project name, purpose, constraints, success criteria.

**Example**: "This Pi is going to be a voice-controlled farm management assistant. Farmers can dictate observations into their phone via Telegram, and it records them in FarmOS. It needs to work in the field with intermittent connectivity."

### 3. Describe Your Organization / Community

Who else is involved? What organizations matter?

> "I'm part of [organization]. We work with [collaborators]. Our mission is [what you're trying to achieve together]."

**What the agent stores**: Organizational context, collaborator network, shared mission.

**Example**: "I work with PVOS and Edge Collective on open-source environmental monitoring. We collaborate with FarmHack on agricultural technology. Don Blair handles the hardware side — LoRa sensors, off-grid monitoring."

### 4. Describe Key Relationships

Who will the agent interact with? What should it know about them?

> "[Name] is [role]. They care about [what]. When talking to them, keep in mind [context]."

**What the agent stores**: People profiles, interaction guidance.

**Example**: "Don Blair is our hardware lead — MS Physics, builds LoRa sensor networks. Very hands-on, prefers working prototypes over slide decks. Craig Versek created the MacEff framework — he's the one to file bugs with."

### 5. Set Behavioral Expectations

How should the agent operate? What's your style?

> "I prefer [communication style]. When uncertain, [do this]. Always [rule]. Never [anti-pattern]."

**What the agent stores**: Feedback memories that guide future behavior.

**Examples**:
- "Keep responses concise — I'm often in the field and reading on my phone."
- "When you don't know something, say so. Don't guess about soil chemistry."
- "File GitHub issues when you find bugs. We aspire to greatness."
- "Be honest about what's running locally vs. in the cloud."

### 6. Share Domain Vocabulary

If you're working in a specialized domain, give the agent key terms:

> "Important terms in my work: [vocabulary]. When I say [term] I mean [definition]."

**What the agent stores**: This goes into whisper context profiles AND memory.

**Example**: "Key crops: lettuce, kale, chard, arugula. Equipment: roller crimper, broad fork, drip tape. Systems: FarmOS for records, Meshtastic for mesh radio, bayou.pvos.org for sensor data."

---

## Template: First Session Prompts

Copy and adapt these prompts to give your agent a thorough introduction. You don't need all of them — pick what's relevant.

```
I'd like to introduce myself and set up your memory for our work together.

My name is ___. I'm a ___. My background is in ___.

This project is called ___. It's a ___ running on this Raspberry Pi.
The goal is ___.

I'm part of [organization(s)]: ___.
We work with: ___.
Our shared mission is: ___.

Key people you should know about:
- [Name]: [role, background, what they care about]
- [Name]: [role, background, what they care about]

When working with me:
- I prefer ___
- Always ___
- Never ___

Important domain terms: ___

Please save all of this to your memory system and confirm what you've stored.
```

---

## What NOT to Share

The agent's memory files live on your device, but exercise good judgment:

- **Don't share passwords or API keys** — the agent doesn't need to memorize these
- **Don't share private personal information** that isn't relevant to the work
- **Don't include information about people** who haven't consented to being profiled
- **Be mindful of organizational confidentiality** — the memory files could theoretically be accessed by anyone with access to your Pi

---

## After the Introduction

The agent will create memory files in `~/.claude/projects/*/memory/`. You can:

- **Review**: `ls ~/.claude/projects/*/memory/` and read any file
- **Edit**: Memory files are plain markdown — edit with any text editor
- **Delete**: Remove any file you don't want stored
- **Index**: `MEMORY.md` is the master index — it's loaded into every conversation

Over time, the agent builds up learnings (`~/agent/private/learnings/`), personal policies (`~/agent/policies/personal/`), and roadmaps (`~/agent/public/roadmaps/`). These are the agent's accumulated wisdom — they persist across sessions and help the agent recover from context loss.

---

## For Workshop Facilitators

If you're running a workshop where multiple people are setting up agents:

1. Run `setup.sh` first (technical bootstrapping — can be done in advance)
2. Allocate 10-15 minutes for the introduction conversation
3. Encourage participants to introduce themselves naturally, not read from a script
4. Have participants review their memory files afterward — builds trust and understanding
5. Remind participants: the agent is a cloud API, not a local model. Be transparent about what's on-device vs. what's in the cloud.

---

*SiloMacEff@d0cdcf (working with @cversek)*
