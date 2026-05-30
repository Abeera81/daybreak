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
- [x] Repo scaffolded (SKILL.md, setup.sh, setup.ps1, LICENSE, README, configs)
- [x] Submission deliverables drafted (BLOG_POST.md, docs/DEMO.md)
- [x] WSL + Ubuntu 26.04 installed
- [x] Hermes Agent v0.15.1 installed in WSL (~/.hermes)
- [x] daily-brief skill installed into ~/.hermes/skills/ (abeera user)
- [x] Model connected: nvidia/nemotron-3-super-120b-a12b:free via OpenRouter (tested OK)
- [x] Discord gateway LIVE (connected as daybreak#8659), runs via `hermes gateway run`
- [x] Verified deliveries to Discord #general: test msg, web-search summary, TTS audio clip
- [x] All pipeline stages proven working individually (search/write/TTS/deliver)
- [~] Full end-to-end skill run blocked by OpenRouter free daily cap (HTTP 429 free-models-per-day)
- [ ] Switching model to Groq free tier for reliable runs -- USER getting key
- [ ] 7am cron added
- [ ] Self-improvement diff captured
- [ ] Video recorded
- [ ] dev.to post published

## Known issue / decision
- OpenRouter ":free" models share a ~50 req/day account-wide cap. Testing exhausted it.
- Fix: add Groq (free, no card, llama-3.3-70b-versatile = 128K ctx) as the model.
- Resets at 00:00 UTC if reverting to OpenRouter.

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
