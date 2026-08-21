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

---

## 3. Debug `core.dart` unable to resolve `network`/`failures` modules

**Date:** 2026-08-21, ~10:25 local (+03:00)
**Session:** Claude Code
**Files changed:** [modules/core/pubspec.yaml](modules/core/pubspec.yaml)

**Prompt (verbatim):**
> there in an error in @modules/core/lib/core.dart it appears it cant see the
> modules failure and networking inspite me calling them in the yamal file

**What the model returned:**
Rather than guessing from the yaml alone, it ran `flutter pub get` directly in
`modules/core` to see the real resolver error. That surfaced a version-solving
conflict: the unused dev dependency `hive_generator ^2.0.1` caps `analyzer
<7.0.0`, while `bloc_test ^9.1.7`'s `test` dependency chain needs `analyzer
>=8.0.0` under this Flutter SDK's pinned `matcher`/`test_api`. Because `pub get`
was failing outright, `network` and `failures` were never written into `core`'s
resolved package config — that was the actual cause of the "can't see the
modules" symptom, not the `path:` declarations themselves (those were correct).
It confirmed `hive`/`hive_generator`/`build_runner` weren't referenced anywhere
in the codebase (no `@HiveType`, no generated `.g.dart` files) before removing
`hive_generator` and `build_runner` from `core`'s `dev_dependencies`, then
re-ran `pub get` in `core`, `network`, `failures`, and the root app, and
`dart analyze lib/core.dart`, to confirm the fix.

**Decision:** Accepted as applied.
**Why:** The diagnosis was backed by the actual pub resolver error, not
speculation, and the removed packages were provably unused (grepped first), so
the fix carried no functional risk. Noted `hive_ce_generator` (the maintained
fork) as the path forward if Hive code-gen is needed later — did not proactively
add it since nothing needs it yet.

---

## 4. Standing instruction: log every prompt going forward

**Date:** 2026-08-21, ~10:28 local (+03:00)
**Session:** Claude Code

**Prompt (verbatim):**
> mark everytask in the ai usage md dont forget in every task
>
> [clarification] every taks i give not everytask anywhere

**What the model returned:**
Confirmed the scope: every prompt the user gives in this project gets an entry
in this file going forward — not a filtered subset picked by the model, and not
background/automatic actions taken without a user prompt behind them.

**Decision:** Accepted as a standing rule for the remainder of this project.
**Why:** The user's instruction, stated directly. Applying it from here on, so
this file stays a complete, honest record rather than a curated highlight reel.
