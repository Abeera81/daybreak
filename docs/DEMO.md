# Demo & Proof Guide

This is your shot-list for the submission artifacts. Capture these once the live
agent is running (see README → Setup).

## 1. The 7am Discord message (screenshot)
- Trigger a brief on demand:
  `hermes -z "Run the daily-brief skill now and deliver text + audio to discord:#general." --yolo`
  (or `hermes cron run daybreak-morning`)
- Screenshot the Discord message showing **text + the audio file**.

## 2. The audio (10s clip for video)
- Play the delivered MP3. Record a short clip for the cover/video.

## 3. The self-improvement diff (your credibility weapon)
This must be **real** — produced from actual feedback, not faked.

```bash
# Before giving feedback, snapshot the skill:
cp ~/.hermes/skills/daily-brief/SKILL.md before.md

# Reply to a brief on Discord, e.g.:
#   "too much marketing fluff, lead with CVEs"
# and tell the agent to update the "## Style rules" section.

# After the agent rewrites it, snapshot again:
cp ~/.hermes/skills/daily-brief/SKILL.md after.md

# Capture the diff and screenshot it:
git diff --no-index before.md after.md
```
- Note the line counts (this build: style rules went **2 -> 8 rules**). See
  `docs/skill-improvement.diff`.

## 4. The 60–90s video (unlisted YouTube, with voiceover)
Suggested beats:
1. The 7am Discord message arriving.
2. Press play on the audio file.
3. Show the skill `git diff` (the agent rewriting its own rules).
4. One line: "The best agent is the one you never open."

### 4a. Silent recording shot plan (record now, narrate later)
Record with Win+G (Xbox Game Bar) → Capture → ●. Have Discord (desktop/web) open.

| Time | What's on screen | What you do |
|------|------------------|-------------|
| 0:00–0:08 | Discord #general (empty), thesis text visible | Sit on the empty channel for a beat |
| 0:08–0:30 | Discord #general | The brief lands by itself — text + an audio file. Let it appear. |
| 0:30–0:45 | The audio file in Discord | Click ▶ play; let the voice run a few seconds |
| 0:45–1:05 | `docs/skill-improvement.diff` (open in VS Code) | Scroll slowly through the 2→8 rules diff |
| 1:05–1:15 | Back to Discord brief (or a title card) | Hold on the result |

Keep total ≤ 90s. Trim dead air in the YouTube editor or any free trimmer.

### 4b. Voiceover script (read this over the silent clip, ~70s)
> Every morning, six news tabs I never read. Daybreak fixes that — it's an
> AI agent I never open.
>
> At 7 a.m., on its own, it searches the web for my topics, writes a 150-word
> brief, and narrates it out loud. Here it is — arriving in Discord by itself:
> the text, and a voice note.
>
> *(let the audio play for ~3 seconds)*
>
> That's free text-to-speech. I just listen while the kettle boils.
>
> And it improves itself. I told it once: "lead with security CVEs." It rewrote
> its own instructions — look: the style rules grew from two to eight. No code
> change. The agent edited its own skill file.
>
> Headless. Self-hosting. Audio. Total cost: zero dollars.
> The best agent is the one you never open.

## 5. The cover image (1000×420)
- Left: chaotic 30+ browser tabs. Right: a clean phone with a ▶ play button +
  "7:00 AM BRIEF". Big text: "THE AGENT YOU NEVER OPEN." Badge: "$0".

---

## Pre-submit checklist (eligibility — any miss = DQ)
- [ ] Tags present: `hermesagentchallenge`, `devchallenge`, `agents`, `showdev`
- [ ] All 4 post sections: What I Built / Demo / Code / How I Used
- [ ] Repo public + MIT LICENSE file (✓ in this repo)
- [ ] One-command setup verified in a clean shell
- [ ] Published before the May 31 deadline (verify timezone)

## Quality checklist
- [ ] Cover image 1000×420 with "$0" / thesis text
- [ ] Video ≤90s, unlisted YouTube, with voiceover
- [ ] At least one comparison/decision table
- [ ] At least one falsifiable number (skill line counts / 150 words)
- [ ] Repo has AGENTS.md + memory.md + Conventional-commit history (✓)
