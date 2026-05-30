#!/usr/bin/env bash
# setup.sh — reproduce Daybreak (Linux / macOS / WSL)
set -e

echo "==> Installing Hermes Agent..."
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

echo "==> Installing the daily-brief skill..."
mkdir -p ~/.hermes/skills/daily-brief
cp skills/daily-brief/SKILL.md ~/.hermes/skills/daily-brief/SKILL.md

echo ""
echo "Next steps:"
echo "  1) hermes model        # choose OpenRouter free, >=64K context, paste your key"
echo "  2) Put your secrets in ~/.hermes/.env (see .env.example):"
echo "       TELEGRAM_BOT_TOKEN=..."
echo "       TELEGRAM_ALLOWED_USERS=<your_numeric_id>"
echo "  3) hermes gateway setup && hermes gateway start"
echo "  4) In Hermes, add the schedule:"
echo "       /cron add \"every weekday at 7:00am\" \"Run my morning brief: use the daily-brief skill.\""
echo ""
echo "Done. DM your bot to test, or run the brief on demand."
