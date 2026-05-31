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
