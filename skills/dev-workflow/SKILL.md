---
name: dev-workflow
description: Branches, CI, build/test/lint, PR expectations, coverage—standard workflow for Contentstack Utils Swift.
---

# Development workflow – Contentstack Utils Swift

## When to use

- Setting up locally, opening a PR, or aligning with CI.
- Answering “how do we run tests?” or “which branch targets `master`?”

## Branches

- Use feature branches (e.g. `feat/...`, `fix/...`, ticket branches).
- **CI** runs on push to `master` and on pull requests targeting `master` or `next` (`.github/workflows/ci.yml`).
- **Merges into `master`** may be gated: PRs whose base is `master` are often expected to come from **`staging`**; other heads may fail the check-branch workflow (`.github/workflows/check-branch.yml`). Confirm with your team before opening PRs to `master`.

## Running tests and build

- **SPM:** `swift build`, `swift test`
- **CI-style Xcode (iOS Simulator):**  
  `xcodebuild -project "ContentstackUtils.xcodeproj" -scheme "ContentstackUtils-Package" -destination "OS=13.4.1,name=iPhone 11 Pro" test`  
  Adjust `-destination` for your local Xcode/Simulator.

Run tests before opening a PR. Default tests use **offline** mocks and fixtures—no `.env` or live stack credentials.

## Lint

- **SwiftLint:** `swiftlint` (`.swiftlint.yml`)

## Pull requests

- Build passes: `swift build` and `swift test` (and `xcodebuild` if you touch Xcode-specific paths).
- Follow the **code-review** skill (`skills/code-review/SKILL.md`) before merge.
- Prefer backward-compatible public API; call out breaking changes and semver.
- Describe behavior and update `CHANGELOG.md` / version metadata (`ContentstackUtils.podspec`, tags) when releasing—per team process.
- Security/policy scans may run in CI (e.g. `.github/workflows/sca-scan.yml`, `policy-scan.yml`).

## Optional: TDD

If the team uses TDD: RED → GREEN → REFACTOR. Test structure is in `skills/testing/SKILL.md`.

## Coverage

- **Slather** (`.slather.yml`, scheme `ContentstackUtils-Package`): use after tests to inspect `Sources/ContentstackUtils/` coverage.

## References

- `skills/testing/SKILL.md`
- `skills/code-review/SKILL.md`
