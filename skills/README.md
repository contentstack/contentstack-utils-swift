# Skills – Contentstack Utils Swift

**This directory is the source of truth** for conventions (workflow, SDK API, style, tests, review, build). Read **`AGENTS.md`** at the repo root for the index and quick commands; each skill is a folder with **`SKILL.md`** (YAML frontmatter: `name`, `description`).

## When to use which skill

| Skill folder | Use when |
|--------------|----------|
| **dev-workflow** | Branches, CI, `swift build` / `swift test` / `swiftlint`, `xcodebuild`, PRs, Slather, optional TDD |
| **contentstack-utils** | `ContentstackUtils`, `Option` / `Renderable`, RTE/JSON, GQL, variants, errors, semver, docs |
| **swift-style** | SwiftLint, `Sources/` vs Kanna, libxml2/platforms, naming, access control |
| **testing** | XCTest layout, mocks, fixtures, offline tests, `XCTestManifests` |
| **code-review** | PR checklist, Blocker/Major/Minor, API and security gates |
| **framework** | `Package.swift`, `Modules/`, Kanna vendoring, podspec, CI scheme |

## How to use these docs

- **Humans / any AI tool:** Start at **`AGENTS.md`**, then open the relevant **`skills/<name>/SKILL.md`**.
- **Cursor users:** **`.cursor/rules/README.md`** only points to **`AGENTS.md`** so guidance stays universal—no duplicate `.mdc` rule sets.
