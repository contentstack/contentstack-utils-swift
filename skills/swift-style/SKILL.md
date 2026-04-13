---
name: swift-style
description: SwiftLint, Sources layout, Kanna/libxml2, platforms, naming, access control for all Swift in this repo.
---

# Swift style and repo layout – Contentstack Utils Swift

## When to use

- Editing any Swift under `Sources/` or `Tests/`.
- Adding files or changing platform/deployment assumptions.

## Tooling

- Run **SwiftLint** with `.swiftlint.yml`. Do not relax rules for new code without team agreement.
- **`Sources/Kanna/`** is excluded from SwiftLint—do not copy patterns into `Sources/ContentstackUtils/` that would fail lint there.

## Package layout

- **Library code:** `Sources/ContentstackUtils/`.
- **Vendored Kanna:** `Sources/Kanna/`—treat as third-party unless you are deliberately upgrading the vendored copy; prefer fixes in `ContentstackUtils` or documented Kanna upgrades.

## Platforms and libxml2

- **Deployment targets:** macOS 10.13+, iOS/tvOS 11+, watchOS 4+ (`Package.swift`). Avoid newer SDK-only APIs without availability checks or a deliberate target bump.
- **libxml2:** Apple platforms use system libxml where applicable; Linux uses the `libxml2` system target and `pkg-config`. Keep `Modules/` and `Package.swift` conditionals in sync when changing platform support.

## Naming and API surface

- Swift conventions: types `UpperCamelCase`, members `lowerCamelCase`.
- Preserve established **public** names even when imperfect (e.g. historical typos) unless doing a **semver-major** cleanup with maintainer agreement.

## Imports and access control

- `import Foundation` as needed; HTML parsing follows existing Kanna usage in this package.
- Mark **`public` / `open`** intentionally; keep implementation `internal` or `private` unless tests use established `@testable` patterns.

## References

- `skills/framework/SKILL.md` (SPM, podspec, CI)
- `skills/testing/SKILL.md` (lint exclusions in tests)
