# Contentstack Utils Swift – Agent guide

**Universal entry point** for anyone automating or assisting work in this repo—AI agents (Cursor, Copilot, CLI tools), reviewers, and contributors. Conventions and detailed guidance live in **`skills/*/SKILL.md`**, not in editor-specific config, so the same instructions apply whether or not you use Cursor.

## What this repo is

- **Name:** [contentstack-utils-swift](https://github.com/contentstack/contentstack-utils-swift)
- **Purpose:** Swift library that renders Contentstack **RTE** (rich text) and related JSON to HTML, with hooks for embedded entries/assets and helpers for **variant** metadata.
- **Out of scope:** This package does **not** ship HTTP clients or stack credentials. Apps fetch content with the [Content Delivery / Swift SDK](https://www.contentstack.com/docs/developers/sdks/content-delivery-sdk/swift) (or other clients), then pass strings or dictionaries into ContentstackUtils.

## Tech stack (at a glance)

| Area | Details |
|------|---------|
| Language | Swift 5 (`Package.swift`, podspec) |
| Build | SwiftPM; CocoaPods `ContentstackUtils.podspec`; Xcode `ContentstackUtils.xcodeproj` |
| Tests | XCTest → `Tests/ContentstackUtilsTests/` |
| Lint / coverage | SwiftLint `.swiftlint.yml`; Slather `.slather.yml` (scheme `ContentstackUtils-Package`) |
| HTML/XML | Vendored Kanna `Sources/Kanna/`; libxml2 via `Modules/` |

## Commands (quick reference)

```bash
swift build && swift test
swiftlint
```

CI-style Xcode (see `.github/workflows/ci.yml`):

```bash
xcodebuild -project "ContentstackUtils.xcodeproj" -scheme "ContentstackUtils-Package" -destination "OS=13.4.1,name=iPhone 11 Pro" test
```

CocoaPods: `pod 'ContentstackUtils', '~> …'` — see `README.md` and `ContentstackUtils.podspec` for the current version.

## Where the real documentation lives: skills

Read these **`SKILL.md` files** for full conventions—**this is the source of truth** for implementation and review:

| Skill | Path | What it covers |
|-------|------|----------------|
| **Development workflow** | [`skills/dev-workflow/SKILL.md`](skills/dev-workflow/SKILL.md) | Branches, CI, build/test/lint commands, PR expectations, TDD note, Slather |
| **Contentstack Utils (SDK)** | [`skills/contentstack-utils/SKILL.md`](skills/contentstack-utils/SKILL.md) | Public API: `ContentstackUtils`, `Option` / `Renderable`, RTE/JSON, GQL, variants, errors, semver, no network layer |
| **Swift style & repo layout** | [`skills/swift-style/SKILL.md`](skills/swift-style/SKILL.md) | SwiftLint, `Sources/` layout, Kanna/libxml2, platforms, naming, access control |
| **Testing** | [`skills/testing/SKILL.md`](skills/testing/SKILL.md) | XCTest layout, mocks, fixtures, SwiftLint/Slather, offline tests, `XCTestManifests` |
| **Code review** | [`skills/code-review/SKILL.md`](skills/code-review/SKILL.md) | PR checklist (API, errors, deps/SCA, tests, vendored code), Blocker/Major/Minor |
| **Framework / build** | [`skills/framework/SKILL.md`](skills/framework/SKILL.md) | SPM targets, `Modules/` libxml2, Kanna vendoring, deployment targets, podspec, CI `xcodebuild` |

An index with short “when to use” hints is in [`skills/README.md`](skills/README.md).

## Using Cursor

If you use **Cursor**, [`.cursor/rules/README.md`](.cursor/rules/README.md) only points to **`AGENTS.md`**—same source of truth as everyone else; no separate `.mdc` rule files.
