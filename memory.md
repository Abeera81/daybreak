# memory.md — Daybreak brain (read first, update last)

## What this is
Daybreak: a headless Hermes agent that, every weekday at 7:00am, researches my
topics, writes a 150-word brief, narrates it as audio (Edge TTS), and delivers
text + voice to Discord. The thesis: "The best agent is the one you never open."

## Stack ($0)
- Agent: Hermes Agent (MIT)
- Model: Google AI Studio gemini-2.5-flash (free tier, >=64K context)
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
- [x] Repo PUSHED to GitHub (public, MIT): github.com/Abeera81/daybreak
- [x] Blog repo URL placeholder filled (real URL)
- [ ] Cover image 1000x420 (USER) -> fill cover_image in BLOG_POST.md L6
- [ ] 60-90s video with voiceover (USER) -> fill YOUR_VIDEO_ID L19, screenshot L34
- [ ] Publish dev.to post (USER) — tags: hermesagentchallenge, devchallenge, agents, showdev

## TOMORROW (May 31) — resume here
1. Check Gemini quota is reset: `hermes -z "Web-search 'latest Python release' and reply one sentence." --yolo`
   - real sentence = reset OK; HTTP 429/RESOURCE_EXHAUSTED = wait (resets ~midnight Pacific / ~noon PKT).
2. Live run for demo: `hermes -z "Run the daily-brief skill now and deliver text + audio to discord:#general." --yolo` -> check Discord #general.
3. Record 60-90s video, screenshot the Discord brief, make 1000x420 cover.
4. Paste cover URL + YouTube link into BLOG_POST.md (L6, L19, L34), commit, publish on dev.to.

## Known issue / decision
- Google free tier per-model cap is TINY (gemini-2.5-flash ~20 req/short window; flash-lite higher but too weak to chain tools; gemini-3.5-flash only 5). One agentic brief = ~10-15 calls, so heavy same-day TESTING exhausts it; the real once-a-day 7am brief fits fine. Build is proven working.
- If testing today is blocked again: wait for reset, OR add a 2nd free Gemini key (Hermes uses a credential pool), OR NVIDIA NIM / Groq(custom OpenAI endpoint).
- config model lives at ~/.hermes/config.yaml `model.default` (currently gemini-2.5-flash).
- Gateway must stay running for the 7am cron (WSL must be awake) — honest note in post.

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
