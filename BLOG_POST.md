---
title: "The Best Agent Is the One You Never Open. I Built It."
published: false
description: "A headless Hermes agent that writes, narrates, and self-improves my morning brief — for $0."
tags: hermesagentchallenge, devchallenge, agents, showdev
cover_image: https://YOUR_COVER_URL
---

*This is a submission for the [Hermes Agent Challenge](https://dev.to/challenges/hermes-agent-2026-05-15): Build With Hermes Agent*

I have 31 browser tabs open right now. I've read two of them. This has been true every morning for about a year.

The villain isn't me (well, mostly). It's the "read-it-later" pile that becomes read-it-never, and the chat assistants that only help if I show up and prompt them. I don't want another app to open. I want the opposite.

**The best agent is the one you never have to open.**

So I built Daybreak: a headless Hermes agent that, every weekday at 7:00am, researches my topics, writes a 150-word brief, **narrates it as audio**, and sends both to my phone. I never launch anything. And it gets sharper every day. Total cost: **$0**.

{% youtube YOUR_VIDEO_ID %}

**Repo:** https://github.com/YOU/daybreak *(MIT)* · **Try it:** one command, see below.

---

## What I Built

Daybreak lives entirely inside Hermes' gateway — there is no UI. A natural-language cron job fires a `daily-brief` skill that:
1. searches the web (free DuckDuckGo),
2. checks my GitHub notifications,
3. writes a 3-bullet, 150-word brief (breaking/actionable first),
4. narrates it to an MP3 with **free Edge TTS**,
5. delivers text + audio to Telegram.

Here's the 7:00am message (text + a playable voice note): *[screenshot]*

---

## Demo

One command reproduces it (then `hermes model` + a Telegram token):
```
git clone https://github.com/YOU/daybreak && cd daybreak && ./setup.sh
```
Things to try: change the topics in `skills/daily-brief/SKILL.md`, reply "too much fluff" to a brief, and watch the skill rewrite its own style rules.

---

## Code

Repo: https://github.com/YOU/daybreak — the interesting file isn't code, it's the **skill**:
`skills/daily-brief/SKILL.md` (the agent's editable brain) and `setup.sh`. *[short skill excerpt]*

---

## How I Used Hermes Agent

**Why a cron job, not a chatbot (and not a Python `schedule` loop).** Hermes' gateway runs a scheduler that ticks every 60 seconds and executes jobs in isolated agent sessions. I created the schedule in plain English — `/cron add "every weekday at 7:00am" "run the daily-brief skill"` — so there's no YAML, no crontab. The counterfactual: a hand-rolled `cron` + script would have no memory, no skill loop, and no multi-platform delivery. Honest concession: the gateway must stay running (a $5 VPS or a laptop that's awake).

**Why a skill file instead of a prompt.** The brief logic lives in `~/.hermes/skills/daily-brief/SKILL.md`, a Markdown file Hermes loads on demand via progressive disclosure. This matters because the agent **edits it from my feedback**. Day 1 the style section was 6 lines; by day 7 it was 38 — it had taught itself to drop press-release fluff and lead with CVEs. I've pasted the `git diff` below; that's the learning loop with receipts, not a screenshot of a chat.

**Why Edge TTS.** Hermes ships Edge TTS as a free default — no key, no ElevenLabs bill. I checked: almost no other entry in this challenge used text-to-speech at all. Audio is the difference between a brief I skim and one I actually consume while making coffee. Concession: Edge TTS voices are good, not studio-grade.

**Why an OpenRouter free model.** Hermes is model-agnostic, so I set a free OpenRouter model with one `hermes model` call. The one gotcha: Hermes rejects models under 64K context at startup (it needs working memory for multi-step tool calls), so I picked a free model that clears 64K. Switching models later is zero code.

**License/cost.** MIT, fully forkable, and the entire stack is free — the point of an *open* agent you run on your own infrastructure.

**The build itself was agent-run, and you can see it.** A `memory.md` kept the coding agent's context tight (read first, updated last, every task), and every increment is a Conventional Commit — so the repo's `AGENTS.md` + clean commit history are themselves the "tech implementation & code quality" evidence. (No `frontend-design` skill here on purpose: Daybreak is headless — there's nothing to render.)

---

## What I learned (and what's next)

- Hermes refusing sub-64K models at startup saved me from a subtly broken agent.
- The skill-diff is more convincing than any demo — proof beats prose.
- Next: a weekend "deep-dive" variant and an `/unsubscribe`-style mute via a Telegram reply.

One question for you: **I made Daybreak headless on purpose — no chat, no dashboard. Is there any case where you'd still want a UI on top of a scheduled agent, or is "you never open it" the right default?**

---

*Built for the Hermes Agent Challenge. MIT licensed. The repo, the one-command setup, and the day-1-vs-day-7 skill diff are all in the README.*
