# Skills – Contentstack Utils Swift

This directory contains **skills**: reusable guidance for AI agents (and developers) on specific tasks. Each skill is a folder with a `SKILL.md` file (YAML frontmatter: `name`, `description`).

## When to use which skill

| Skill | Use when |
|-------|----------|
| **contentstack-utils** | Implementing or changing Utils features: `ContentstackUtils`, `Option` / `Renderable`, RTE/JSON models, GQL helpers, variant APIs, errors, documentation and semver. |
| **testing** | Writing or refactoring tests: XCTest, `swift test`, Xcode scheme, mocks, fixtures, SwiftLint/Slather, offline fixtures. |
| **code-review** | Reviewing a PR or preparing your own: API design, errors, backward compatibility, dependencies/security, test coverage, severity (blocker/major/minor). |
| **framework** | Touching SPM layout, `libxml2` / `Modules/`, vendored Kanna, deployment targets, or `ContentstackUtils.podspec` / CI `xcodebuild` assumptions. |

## How agents should use skills

- **contentstack-utils:** Apply when editing `Sources/ContentstackUtils/` or documenting public behavior. Do not add hard dependencies on the main Contentstack iOS SDK or Apollo unless product requires it and `Package.swift` is updated deliberately.
- **testing:** Apply when creating or modifying files under `Tests/ContentstackUtilsTests/`. Follow existing mocks and fixtures; keep tests credential-free.
- **code-review:** Apply when performing or simulating a PR review. Work through `.cursor/rules/code-review.mdc` and optionally tag findings by severity.
- **framework:** Apply when changing `Package.swift`, `Modules/`, `Sources/Kanna/`, or podspec—keep Apple vs Linux libxml behavior and CI destinations in mind.

Each skill’s `SKILL.md` contains more detailed instructions and references.
