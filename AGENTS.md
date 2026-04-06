# Contentstack Utils Swift – Agent Guide

This document is the main entry point for AI agents working in this repository.

## Project

- **Name:** Contentstack Utils Swift ([contentstack-utils-swift](https://github.com/contentstack/contentstack-utils-swift))
- **Purpose:** Swift library for rendering Contentstack **RTE** (rich text) and related JSON to HTML, with hooks for embedded entries/assets and helpers for **variant** metadata. It does **not** implement Contentstack HTTP clients; apps fetch content with the [Content Delivery / Swift SDK](https://www.contentstack.com/docs/developers/sdks/content-delivery-sdk/swift) or other clients, then pass strings or dictionaries into this package.

## Tech stack

- **Language:** Swift 5 (`Package.swift` `swiftLanguageVersions: [.v5]`, podspec Swift 5.0)
- **Build:** Swift Package Manager; CocoaPods (`ContentstackUtils.podspec`); Xcode `ContentstackUtils.xcodeproj`
- **Testing:** XCTest, target `ContentstackUtilsTests`, path `Tests/ContentstackUtilsTests/`
- **Lint / coverage:** SwiftLint (`.swiftlint.yml`), Slather (`.slather.yml`, scheme `ContentstackUtils-Package`)
- **HTML/XML:** Vendored **Kanna** (`Sources/Kanna/`), **libxml2** via `Modules/` (system on Apple platforms)

## Main entry points

- **`ContentstackUtils`** – `Sources/ContentstackUtils/ContentstackUtils.swift`: `render`, `jsonToHtml`, `getVariantAliases`, nested **`GQL`**, **`VariantUtilityError`**
- **`Option` / `Renderable`** – `Sources/ContentstackUtils/Option.swift`: customize HTML for marks, nodes, embedded items
- **RTE model types** – `Node.swift`, `JSONNode.swift`, `JSONNodes.swift`, `MarkType.swift`, `Metadata.swift`, and related files under `Sources/ContentstackUtils/`
- **Tests** – `Tests/ContentstackUtilsTests/*.swift`
- **Package** – `Package.swift`: product `ContentstackUtils`, targets `ContentstackUtils`, `ContentstackUtilsTests`, system `libxml2`

## Commands

- **Build and test:** `swift build` && `swift test`
- **Lint:** `swiftlint`
- **CI-style Xcode test:**  
  `xcodebuild -project "ContentstackUtils.xcodeproj" -scheme "ContentstackUtils-Package" -destination "OS=13.4.1,name=iPhone 11 Pro" test`

CocoaPods: `pod 'ContentstackUtils', '~> …'` (see `README.md` and `ContentstackUtils.podspec` for the current version).

## Rules and skills

- **`.cursor/rules/`** – Cursor rules for this repo:
  - **README.md** – Index of all rules and how globs apply.
  - **dev-workflow.md** – Development workflow (branches, tests, lint, PRs).
  - **swift-style.mdc** – Applies to `**/*.swift`: SwiftLint, layout, Kanna/libxml2, platforms.
  - **contentstack-utils-sdk.mdc** – Applies to `Sources/ContentstackUtils/**/*.swift`: Utils SDK patterns, `Option`, RTE/GQL, variants.
  - **testing.mdc** – Applies to `Tests/**/*.swift`: XCTest, mocks, fixtures, coverage.
  - **code-review.mdc** – Always applied: PR/review checklist.
- **`skills/`** – Reusable skill docs:
  - Use **contentstack-utils** when implementing or changing public API, RTE rendering, or GQL JSON entry points.
  - Use **testing** when adding or refactoring tests.
  - Use **code-review** when reviewing PRs or before opening one.
  - Use **framework** when changing SPM/libxml2, Kanna vendoring, deployment targets, or CocoaPods packaging.

Refer to `.cursor/rules/README.md` for when each rule applies and to `skills/README.md` for skill details.
