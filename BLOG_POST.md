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

So I built Daybreak: a headless Hermes agent that, every weekday at 7:00am, researches my topics, writes a 150-word brief, **narrates it as audio**, and sends both to my Discord. I never launch anything. And it gets sharper every day. Total cost: **$0**.

{% youtube YOUR_VIDEO_ID %}

**Repo:** https://github.com/Abeera81/daybreak *(MIT)* · **Try it:** one command, see below.

---

## What I Built

Daybreak lives entirely inside Hermes' gateway — there is no UI. A natural-language cron job fires a `daily-brief` skill that:
1. searches the web (free DuckDuckGo),
2. checks my GitHub notifications,
3. writes a 3-bullet, 150-word brief (breaking/actionable first),
4. narrates it to an MP3 with **free Edge TTS**,
5. delivers text + audio to Discord.

Here's the 7:00am message (text + a playable voice note): *[screenshot]*

---

## Demo

One command reproduces it (then `hermes model` + a Discord bot token):
```
git clone https://github.com/Abeera81/daybreak && cd daybreak && ./setup.sh
```
Things to try: change the topics in `skills/daily-brief/SKILL.md`, reply "too much fluff" to a brief, and watch the skill rewrite its own style rules.

---

## Code

Repo: https://github.com/Abeera81/daybreak — the interesting file isn't code, it's the **skill**:
`skills/daily-brief/SKILL.md` (the agent's editable brain) and `setup.sh`. *[short skill excerpt]*

---

## How I Used Hermes Agent

**Why a cron job, not a chatbot (and not a Python `schedule` loop).** Hermes' gateway runs a scheduler that ticks every 60 seconds and executes jobs in isolated agent sessions. I created the schedule in plain English — `hermes cron create "0 7 * * 1-5" --skill daily-brief --deliver discord:#general` — no YAML hand-editing, no crontab. The counterfactual: a hand-rolled `cron` + script would have no memory, no skill loop, and no multi-platform delivery. Honest concession: the gateway must stay running (a $5 VPS or a machine that's awake at 7am).

**Why a skill file instead of a prompt.** The brief logic lives in `~/.hermes/skills/daily-brief/SKILL.md`, a Markdown file Hermes loads on demand via progressive disclosure. This matters because the agent **edits it from my feedback**. I gave it one round of feedback ("too much fluff, lead with CVEs and their severity"), and it rewrote its own `## Style rules` from **2 rules to 8**. Here's the actual `git diff` — the learning loop with receipts, not a screenshot of a chat:

```diff
 ## Style rules (the agent will extend this section from my feedback)
 - No press-release fluff. No "exciting news". Lead with breaking changes.
 - Plain language. Short sentences. No emoji in the audio script.
+- Lead with security CVEs and their severity scores.
+- For each CVE, name the affected package and the fixed version.
+- Cut generic advice (e.g., "consult CVE databases").
+- If Python news is a beta, one line max.
+- The single most actionable item should be bullet one.
+- Keep the audio script under 90 seconds.
```

The full diff is in the repo at `docs/skill-improvement.diff`.

**Why Edge TTS.** Hermes ships Edge TTS as a free default — no key, no ElevenLabs bill. I checked: almost no other entry in this challenge used text-to-speech at all. Audio is the difference between a brief I skim and one I actually consume while making coffee. Concession: Edge TTS voices are good, not studio-grade.

**Why I switched models mid-build (an honest bug).** Hermes is model-agnostic, so swapping models is one `hermes model` call — and I ended up doing it a lot. First gotcha: Hermes rejects models under 64K context at startup (it needs working memory for multi-step tool calls). Then the real lesson: **rate limits, not raw capability, decide which free model can run an *agentic* job.** One brief is ~12 chained model calls inside a minute, so the per-minute cap matters more than the daily one. Google's `gemini-2.5-flash` (free) throttled at ~5 requests/minute and choked mid-brief; smaller Gemini variants were either too weak to chain tools or capped at 5 requests/day; NVIDIA NIM was blocked by phone verification in my region. What finally worked: OpenRouter's free **`nvidia/nemotron-3-super-120b-a12b:free`** — enough requests/minute to finish a brief, and ~50/day, which is plenty for an agent that runs once each morning. Total code changed across every one of those swaps: **zero**. That's the whole point of an open, model-agnostic agent.

**License/cost.** MIT, fully forkable, and the entire stack is free — the point of an *open* agent you run on your own infrastructure.

**The build itself was agent-run, and you can see it.** A `memory.md` kept the coding agent's context tight (read first, updated last, every task), and every increment is a Conventional Commit — so the repo's `AGENTS.md` + clean commit history are themselves the "tech implementation & code quality" evidence. (No `frontend-design` skill here on purpose: Daybreak is headless — there's nothing to render.)

---

## What I learned (and what's next)

- Hermes refusing sub-64K models at startup saved me from a subtly broken agent.
- Rate limits, not raw capability, decide which *free* model can run an agentic job — I landed on OpenRouter's free Nemotron after Gemini throttled mid-brief. Zero code changed.
- The skill-diff is more convincing than any demo — proof beats prose.
- Next: a weekend "deep-dive" variant and a mute-via-Discord-reply.

One question for you: **I made Daybreak headless on purpose — no chat, no dashboard. Is there any case where you'd still want a UI on top of a scheduled agent, or is "you never open it" the right default?**

---

*Built for the Hermes Agent Challenge. MIT licensed. The repo, the one-command setup, and the day-1-vs-day-7 skill diff are all in the README.*
