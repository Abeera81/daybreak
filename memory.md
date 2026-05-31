# memory.md — Daybreak brain (read first, update last)

## What this is
Daybreak: a headless Hermes agent that, every weekday at 7:00am, researches my
topics, writes a 150-word brief, narrates it as audio (Edge TTS), and delivers
text + voice to Discord. The thesis: "The best agent is the one you never open."

## Stack ($0)
- Agent: Hermes Agent (MIT)
- Model: OpenRouter nvidia/nemotron-3-super-120b-a12b:free (free tier, >=64K context)
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
- [x] Model: OpenRouter nvidia/nemotron-3-super-120b-a12b:free (free) — after Gemini per-minute throttle + NVIDIA phone-block
- [x] FULL brief delivered end-to-end: search -> write -> edge-tts MP3 -> Discord (text + audio)
- [x] 7am weekday cron created (daybreak-morning, 0 7 * * 1-5, -> discord:#general)
- [x] Self-improvement diff captured (Style rules 2 -> 8) in docs/skill-improvement.diff
- [x] Repo PUSHED to GitHub (public, MIT): github.com/Abeera81/daybreak
- [x] Blog repo URL placeholder filled (real URL)
- [x] Cover image 1000x420 (USER) -> fill cover_image in BLOG_POST.md L6
- [ ] 60-90s video: Clip 1 (Discord brief + audio) RECORDED; Clip 2 dropped (diff lives in blog instead)
- [ ] Publish dev.to post (USER) — tags: hermesagentchallenge, devchallenge, agents, showdev

## RESUME HERE (Jun 1)
1. Live model working: OpenRouter Nemotron. One clean brief delivered to Discord (text + audio), Clip 1 recorded.
2. Remaining: make 1000x420 cover, finish/export video, fill BLOG_POST.md (L6 cover, L19 video id, L34 screenshot), publish on dev.to.
3. To fire a brief: ensure gateway up (`pgrep -af "hermes gateway run"`), then `hermes -z "Run the daily-brief skill now and deliver text + audio to discord:#general." --yolo`.

## Known issue / decision
- Rate limits decide the free model: one agentic brief = ~10-15 model calls/min. Gemini free ~5/min (choked); NVIDIA NIM phone-blocked in region; OpenRouter free ~50/day + workable per-min = current pick (Nemotron). Real once-a-day 7am brief uses ~12 calls, well under caps.
- OpenRouter `:free` daily cap is account-wide (~50/day); heavy same-day TESTING exhausts it (HTTP 429 free-models-per-day). Made a 2nd free account for a clean demo run.
- config model lives at ~/.hermes/config.yaml `model.default` (currently nvidia/nemotron-3-super-120b-a12b:free, provider openrouter, base_url https://openrouter.ai/api/v1).
- Gateway must stay running for the 7am cron (WSL must be awake) — honest note in post.

## Key decisions
- Headless on purpose: no UI, no dashboard (the angle, not a gap).
- Telegram only (no Slack/Discord/email sprawl). -> SWITCHED to Discord (Telegram banned in region).
- Free Edge TTS only (no ElevenLabs).
- Windows host -> use WSL so the Linux installer works verbatim.

## Open questions / TODO
- Decide live host so the 7am cron fires while laptop sleeps (currently WSL must be awake).
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
- Install WSL: admin PowerShell `wsl --install`, then reboot. [DONE]
- Free model key via `hermes model` (using OpenRouter nvidia/nemotron-3-super-120b-a12b:free). [DONE]
- Discord bot token + numeric user id -> ~/.hermes/.env. [DONE]
- Remaining: record demo video, make cover image, fill BLOG_POST.md placeholders, publish on dev.to.
