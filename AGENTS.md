# AGENTS.md — workflow rules for any coding agent on this repo

1. **Read `memory.md` FIRST** at the start of every task.
2. Edit only the files relevant to the current task.
3. Keep secrets out of source — only in `.env` (never committed). Use `.env.example` for templates.
4. The live agent logic lives in `skills/daily-brief/SKILL.md`, not in Python. Prefer editing the skill over writing code.
5. This project is **headless on purpose** — there is no web UI, so the `frontend-design` skill is intentionally unused.
6. Commit with **Conventional Commits** after each increment (e.g. `feat:`, `chore:`, `docs:`).
7. **Update `memory.md` LAST** — summarize what changed, keep it terse, minimize tokens.
