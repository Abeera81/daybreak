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
- Delivery: Telegram bot (free)
- Host: WSL on Windows for dev; always-on box for the live 7am run

## Status snapshot
- [x] Repo scaffolded (SKILL.md, setup.sh, setup.ps1, LICENSE, README, configs)
- [x] Submission deliverables drafted (BLOG_POST.md, docs/DEMO.md)
- [ ] WSL installed (BLOCKED: needs admin + reboot — user action)
- [ ] Hermes installed (WSL)
- [ ] Model connected (OpenRouter free)
- [ ] Telegram gateway live
- [ ] 7am cron added
- [ ] First brief delivered
- [ ] Self-improvement diff captured
- [ ] Video recorded
- [ ] dev.to post published

## Key decisions
- Headless on purpose: no UI, no dashboard (the angle, not a gap).
- Telegram only (no Slack/Discord/email sprawl).
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
