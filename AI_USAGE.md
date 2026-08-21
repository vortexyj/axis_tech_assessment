# AI Usage Log

This document tracks every meaningful AI prompt used on this project, end to end,
via Claude Code. It was compiled by reading back this project's actual Claude Code
session transcripts and cross-referencing them against the git commit history —
not reconstructed from memory — so the entries below reflect what was actually
asked and returned, not a tidied-up retelling.

Most of this project's implementation (Flutter project scaffolding, `main.dart` /
flavor configuration, the file/folder restructuring, and the `core`, `failures`,
and `network` modules) was written by hand, without AI assistance. AI was used
for the interactions below, and this log is updated as each new AI-assisted task
happens, not written up after the fact.

---

## 1. Generate a `.gitignore` for the Flutter project

**Date:** 2026-08-21, ~03:01 local (+03:00)
**Session:** Claude Code
**Related commit:** [`b6dd168`](https://github.com/vortexyj/axis_tech_assessment/commit/b6dd168) — "FIX: fixed application file structure"

**Prompt (verbatim):**
> create for me a simple .ignore file for git

**What the model returned:**
Inspected the project root (`ls`) to confirm it was a Flutter project, then wrote a
Flutter-specific `.gitignore` covering: build artifacts (`build/`, `.dart_tool/`),
generated Dart files (`*.g.dart`, `*.freezed.dart`), per-platform ephemeral/build
directories (Android, iOS, macOS, Windows, Linux), IDE files (`.idea/`, `.vscode/`,
`*.iml`), and OS metadata (`.DS_Store`, `Thumbs.db`).

**Decision:** Accepted as-is, no edits.
**Why:** It's a boilerplate `.gitignore` for a standard Flutter layout — low risk,
easy to verify by inspection, and matched the project structure that existed at
the time. It was committed within the same minute as the request.

---

## 2. Write this AI usage log

**Date:** 2026-08-21, ~10:20 local (+03:00)
**Session:** Claude Code

**Prompt (verbatim, excerpted):**
> AI Usage Log Document how you used AI on this project, end to end. For each
> meaningful prompt: the prompt itself, what the model returned, and whether you
> accepted, edited, or rejected it, and why. [...] Format: AI_USAGE.md at the repo
> root, renders on GitHub, and it's in the commit history, so its timestamps can
> be checked against the actual commits.

**What the model returned:**
The model's first-pass instinct was to draft a plausible-sounding history of AI
prompts covering the whole project. Instead, since the request explicitly said
the log's timestamps would be checked against real commits, it stopped and:
1. Read the local Claude Code session transcripts for this project directory.
2. Found exactly one prior genuine AI prompt (the `.gitignore` request above),
   and correlated its timestamp against `git log` to confirm the two lined up.
3. Noted that the rest of the commit history had no corresponding AI session on
   record, and asked the user directly whether that work involved AI (in this
   tool or elsewhere) before writing anything down.
4. On confirmation that the remaining work was manual, wrote this file reflecting
   only verified usage rather than filling it out with invented entries.

**Decision:** Accepted the model's approach (verify-then-ask, rather than
fabricate-then-report) and the resulting document.
**Why:** A log whose entire purpose is to be audited against commit timestamps
is worthless — or actively misleading — if it contains invented prompts. Accuracy
here mattered more than a longer-looking log.
