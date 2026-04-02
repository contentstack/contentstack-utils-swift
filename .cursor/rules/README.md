# Cursor rules index

Rules in this folder guide contributors and AI agents toward this repository’s conventions. Cursor applies them by glob match or as always-on rules.

| File | Scope | Purpose |
|------|--------|---------|
| `swift-style.mdc` | `**/*.swift` | Swift language and repo-wide style (SwiftLint, targets, naming). |
| `contentstack-utils-sdk.mdc` | `Sources/ContentstackUtils/**/*.swift` | Public SDK surface: `ContentstackUtils`, `Option`, RTE/JSON models, HTML rendering, variants. |
| `tests.mdc` | `Tests/**/*.swift` | XCTest layout, mocks, fixtures, and coverage exclusions. |
| `code-review.mdc` | Always | PR checklist: API stability, docs, errors, compatibility, dependencies/SCA, tests. |
| `dev-workflow.md` | (documentation) | Branches, build/test commands, lint/format, PR expectations—not a Cursor rule file. |

See also [AGENTS.md](../../AGENTS.md) for project overview and command references.
