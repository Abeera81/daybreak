#!/usr/bin/env bash
# setup.sh — reproduce Daybreak (Linux / macOS / WSL). Run from the repo root.
set -e

HERMES_DIR="${HOME}/.hermes"
SKILL_DIR="${HERMES_DIR}/skills/daily-brief"

echo "==> [1/4] Installing Hermes Agent (skips if already present)..."
if ! command -v hermes >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
  # shellcheck disable=SC1090
  [ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc" || true
else
  echo "    hermes already installed — skipping."
fi

echo "==> [2/4] Installing the daily-brief skill..."
mkdir -p "${SKILL_DIR}"
cp skills/daily-brief/SKILL.md "${SKILL_DIR}/SKILL.md"
echo "    skill -> ${SKILL_DIR}/SKILL.md"

echo "==> [3/4] Seeding your secrets file (if missing)..."
mkdir -p "${HERMES_DIR}"
if [ ! -f "${HERMES_DIR}/.env" ]; then
  cp .env.example "${HERMES_DIR}/.env"
  echo "    created ${HERMES_DIR}/.env — open it and paste your Discord bot token + user id."
else
  echo "    ${HERMES_DIR}/.env already exists — leaving it untouched."
fi

echo "==> [4/4] Done installing. Finish setup with these 4 steps:"
cat <<'STEPS'

  1) Connect a FREE model (>=64K context, no card):
       hermes model
       # pick Google AI Studio -> gemini-2.5-flash  (or any free >=64K model)

  2) Add your Discord secrets to ~/.hermes/.env (see .env.example):
       DISCORD_BOT_TOKEN=...        # discord.com/developers -> your app -> Bot
       DISCORD_ALLOWED_USERS=...    # your numeric Discord user id

  3) Connect Discord and start the gateway:
       hermes gateway setup         # choose Discord, follow the prompts
       hermes gateway run           # keep this running (delivery + cron live here)

  4) Schedule the weekday 7am brief:
       hermes cron create "0 7 * * 1-5" \
         "Run my morning brief using the daily-brief skill." \
         --name daybreak-morning --skill daily-brief --deliver "discord:#general"

  Test it now without waiting for 7am:
       hermes -z "Run the daily-brief skill now and deliver text + audio to discord:#general." --yolo

  Note: the first Discord/TTS run lazily installs extras (discord.py, edge-tts).
  If that fails on a root-owned venv, run once:
       sudo "$(command -v python3)" -m pip install discord.py edge-tts

STEPS
