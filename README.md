# Daybreak ☀️

**The best agent is the one you never have to open.**

Daybreak is a headless [Hermes Agent](https://github.com/NousResearch/hermes-agent)
that — every weekday at **7:00am** — researches your topics, writes a 150-word
brief, **narrates it as audio**, and sends both to your phone on Telegram.

You never launch anything. And it gets sharper every day: reply to a brief with
feedback, and the agent **rewrites its own skill file** to match your taste.

**Total cost: $0.** Free OpenRouter model · free Edge TTS · free DuckDuckGo
search · free Telegram bot. No credit card anywhere.

---

## What it does

A natural-language cron job fires the `daily-brief` skill, which:

1. searches the web (free DuckDuckGo) for your topics,
2. checks your GitHub notifications (optional),
3. writes a 3-bullet, ~150-word brief (breaking/actionable first),
4. narrates it to an MP3 with **free Edge TTS**,
5. delivers text + audio to Telegram.

There is **no UI** — that's the point. You consume the brief hands-free while the
kettle boils.

## How Hermes is used

| Hermes capability | Role in Daybreak |
|---|---|
| Natural-language **cron** | "every weekday at 7:00am" — no YAML, no crontab |
| **Gateway** delivery | Text + voice straight to Telegram |
| **Web search** (DuckDuckGo) | Free, key-less topic research |
| **Skills** + self-improvement | The agent edits `daily-brief/SKILL.md` from your feedback |
| **Text-to-speech** (Edge TTS) | Free audio narration — a capability almost no entry used |

## Setup

### Linux / macOS / WSL
```bash
git clone https://github.com/YOU/daybreak && cd daybreak
./setup.sh
hermes model          # choose OpenRouter free, >=64K context, paste your key
# put TELEGRAM_BOT_TOKEN + TELEGRAM_ALLOWED_USERS in ~/.hermes/.env (see .env.example)
hermes gateway setup && hermes gateway start
```
Then add the schedule inside Hermes:
```
/cron add "every weekday at 7:00am" "Run my morning brief: use the daily-brief skill."
```

### Windows
Hermes installs in a Linux environment. Install WSL once, then use the helper:
```powershell
wsl --install        # one-time, in an admin PowerShell, then restart
.\setup.ps1          # bootstraps WSL and runs setup.sh
```
Or open WSL directly and run the Linux steps above.

> **Note:** the machine running Hermes must be awake at 7:00am for the cron to
> fire. For the live demo, host it on an always-on box; develop locally in WSL.

## Configuration

Edit your topics in **`skills/daily-brief/SKILL.md`** (step 1), or just reply to a
brief on Telegram (e.g. *"also track Rust releases"*) and let the agent update the
file itself.

Secrets live in `~/.hermes/.env` — see [`.env.example`](.env.example). Never
commit the real `.env`.

## The self-improvement loop

Reply to a brief with feedback like *"too much fluff, lead with CVEs"* and tell
the agent to update the `## Style rules` section of `daily-brief/SKILL.md`. The
`git diff` of that file before/after is the visible proof that the agent learns.

## Repo layout

```
skills/daily-brief/SKILL.md   the agent's editable brain (the interesting file)
setup.sh                      one-command Linux/WSL install
setup.ps1                     Windows -> WSL bootstrap
.env.example                  secrets template
memory.md / AGENTS.md         agent-build workflow + project brain
LICENSE                       MIT
```

## License

[MIT](LICENSE) — fully forkable. Daybreak is an *open* agent you run on your own
infrastructure.
