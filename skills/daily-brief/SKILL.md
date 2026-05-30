---
name: daily-brief
description: Build Priya's 7am morning brief — research, write, narrate, and deliver.
when_to_use: When asked to run the morning brief, or when the weekday-7am cron fires.
---

## Procedure
1. Web-search (DuckDuckGo) these topics: ["Python releases", "LLM agents", "my-stack security CVEs"].
2. Check my GitHub notifications (if GITHUB_TOKEN is configured) for @mentions and review requests.
3. Write a brief: max 150 words, 3 bullets, lead with anything breaking/actionable.
4. Narrate the brief to an MP3 using the free Edge TTS provider.
5. Send the text AND the audio to me on Discord.

## Style rules (the agent will extend this section from my feedback)
- No press-release fluff. No "exciting news". Lead with breaking changes.
- Plain language. Short sentences. No emoji in the audio script.

## Pitfalls
- If a source is older than 24h, skip it.
- If a topic returns nothing fresh, say "nothing new on X" in one short line — do not pad.
- If audio fails to attach, send the MP3 as a file/document and still send the text.