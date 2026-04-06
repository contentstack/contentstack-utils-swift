---
name: testing
description: Use when writing or refactoring tests—XCTest, swift test, Xcode scheme, mocks, fixtures, Slather/SwiftLint.
---

# Testing – Contentstack Utils Swift

## When to use

- Adding or changing tests under `Tests/ContentstackUtilsTests/`.
- Debugging flaky or slow tests; improving fixtures or mocks.

## Instructions

- **Run:** `swift test` from repo root; use Xcode scheme **`ContentstackUtils-Package`** and `ContentstackUtils.xcodeproj` to mirror `.github/workflows/ci.yml`.
- **Layout:** Files such as `*Tests.swift`, `*Test.swift`, or feature files (`GQLJsonToHtml.swift`, `DefaultRenderTests.swift`). Reuse `CustomRenderOptionMock.swift`, `EmbededModelMock.swift`, `TestClient.swift`, `JsonNodes.swift`, `JsonNodesHtmlResults.swift`.
- **Lint:** `.swiftlint.yml` excludes only `Tests/ContentstackUtilsTests/Constants.swift` from SwiftLint.
- **Coverage:** Slather ignores `Tests/*` in reports; still add tests for new production behavior in `Sources/ContentstackUtils/` when practical.
- **Secrets:** Tests stay **offline**—no API keys or `.env` in CI.

## References

- Project rule: `.cursor/rules/testing.mdc`
- Workflow: `.cursor/rules/dev-workflow.md`
