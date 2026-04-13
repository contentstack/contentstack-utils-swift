---
name: testing
description: XCTest—layout, mocks, fixtures, SwiftLint/Slather, offline tests, Linux manifests.
---

# Testing – Contentstack Utils Swift

## When to use

- Adding or changing tests under `Tests/ContentstackUtilsTests/`.
- Debugging flaky tests; improving fixtures or mocks.

## Runner and tooling

- **XCTest** via **`swift test`** (SPM) and/or Xcode scheme **`ContentstackUtils-Package`** (`ContentstackUtils.xcodeproj`), matching `.github/workflows/ci.yml`.
- **SwiftLint:** `.swiftlint.yml`; **`Tests/ContentstackUtilsTests/Constants.swift`** is excluded—other test files are linted.
- **Slather:** `.slather.yml` ignores `Tests/*` in coverage reports; still add tests for new production code in `Sources/ContentstackUtils/` when practical.

## Test naming and layout

- **Target:** `ContentstackUtilsTests`; path **`Tests/ContentstackUtilsTests/`**.
- **File names:** `*Tests.swift`, `*Test.swift`, or feature-oriented names (`GQLJsonToHtml.swift`, `JsonNodes.swift`, `VariantUtilityTests.swift`).
- **Fixtures and mocks:** Prefer `JsonNodes.swift`, `JsonNodesHtmlResults.swift`, `EmbededModelMock.swift`, `CustomRenderOptionMock.swift`, `TestClient.swift`, etc., before adding parallel helpers.

## Integration vs unit

- No separate integration tree: tests live in **`ContentstackUtilsTests`** with mocks for API-shaped payloads—**no live network** or credentials in CI.

## Linux / discovery

- Maintain **`XCTestManifests.swift`** if your workflow requires explicit Linux test discovery.

## Secrets

- Tests are **offline**; do not commit API keys or real tokens.

## References

- `skills/dev-workflow/SKILL.md`
- `skills/code-review/SKILL.md`
