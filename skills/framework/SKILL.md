---
name: framework
description: Use when changing SPM, libxml2 Modules, vendored Kanna, deployment targets, CocoaPods, or CI xcodebuild setup.
---

# Framework – Contentstack Utils Swift

## When to use

- Editing `Package.swift`, `Modules/`, or `Sources/Kanna/`.
- Changing iOS/macOS/tvOS/watchOS deployment targets or conditional libxml linking.
- Updating `ContentstackUtils.podspec` or CI Xcode destination/scheme assumptions.

## Instructions

### Swift Package Manager

- **Product:** `ContentstackUtils`; **targets:** `ContentstackUtils`, `ContentstackUtilsTests`, system **`libxml2`** → **`Modules/`**.
- **Platforms:** Apple vs Linux: conditional `libxml2` dependency and `pkg-config` as in `Package.swift`—preserve behavior when refactoring.

### Vendored Kanna

- **`Sources/Kanna/`** is excluded from SwiftLint; treat updates as intentional vendoring work (licensing, diffs, cross-platform build).

### CocoaPods

- **`ContentstackUtils.podspec`:** `source_files` `Sources/**/*.{swift}`, header search and `-lxml2` for libxml—keep in sync with SPM layout.

### CI

- GitHub Actions uses **xcodebuild** with `ContentstackUtils-Package`; validate low-level changes with both `swift test` and Xcode builds when touching parsing or linking.

## References

- Project rule: `.cursor/rules/swift-style.mdc`
- Workflow: `.cursor/rules/dev-workflow.md`
