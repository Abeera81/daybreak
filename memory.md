# memory.md — Daybreak brain (read first, update last)

## What this is
Daybreak: a headless Hermes agent that, every weekday at 7:00am, researches my
topics, writes a 150-word brief, narrates it as audio (Edge TTS), and delivers
text + voice to Telegram. The thesis: "The best agent is the one you never open."

## Stack ($0)
- Agent: Hermes Agent (MIT)
- Model: OpenRouter free model, >=64K context
- Schedule: Hermes natural-language cron (gateway)
- Search: DuckDuckGo skill (no key)
- Audio: Edge TTS (free, Hermes default)
- Delivery: Discord bot (free; Telegram is region-blocked for me)
- Host: WSL on Windows for dev; always-on box for the live 7am run

## Status snapshot
- [x] Repo scaffolded + agent-build workflow (memory.md, AGENTS.md, commits)
- [x] WSL + Ubuntu 26.04 + Hermes Agent v0.15.1 installed
- [x] daily-brief skill installed (~/.hermes/skills/daily-brief)
- [x] Discord gateway LIVE (daybreak#8659), delivers to #general
- [x] Model: Google AI Studio gemini-2.5-flash (free tier) — after OpenRouter free daily cap (429)
- [x] FULL brief delivered end-to-end: search -> write -> edge-tts MP3 -> Discord (text + audio)
- [x] 7am weekday cron created (daybreak-morning, 0 7 * * 1-5, -> discord:#general)
- [x] Self-improvement diff captured (Style rules 2 -> 8) in docs/skill-improvement.diff
- [ ] Push repo to GitHub (USER)
- [ ] Cover image 1000x420 (USER)
- [ ] 60-90s video with voiceover (USER)
- [ ] Publish dev.to post (USER)

## Known issue / decision
- OpenRouter ":free" models share a ~50 req/day account-wide cap. Testing exhausted it.
- Fix applied: switched to Google AI Studio gemini-2.5-flash (free tier, 1M ctx).
- Gateway must stay running for the 7am cron (WSL must be awake) — note in post.

## Key decisions
- Headless on purpose: no UI, no dashboard (the angle, not a gap).
- Telegram only (no Slack/Discord/email sprawl). -> SWITCHED to Discord (Telegram banned in region).
- Free Edge TTS only (no ElevenLabs).
- Windows host -> use WSL so the Linux installer works verbatim.

## Open questions / TODO
- Confirm exact free OpenRouter model id (>=64K ctx).
- Decide live host so the 7am cron fires while laptop sleeps.
- Wire GitHub notifications (optional).

## File map
- skills/daily-brief/SKILL.md  -> the agent's editable brain
- setup.sh                     -> one-command Linux/WSL install
- setup.ps1                    -> Windows -> WSL bootstrap
- .env.example                 -> secrets template
- README.md                    -> project + setup docs
- AGENTS.md                    -> coding-agent workflow rules
- BLOG_POST.md                 -> dev.to submission draft
- docs/DEMO.md                 -> proof/artifact shot-list + checklists

## Human-only steps remaining (cannot be automated)
- Install WSL: admin PowerShell `wsl --install`, then reboot.
- Free OpenRouter key (openrouter.ai) -> `hermes model`.
- Telegram bot token (@BotFather) + numeric id (@userinfobot) -> ~/.hermes/.env.
