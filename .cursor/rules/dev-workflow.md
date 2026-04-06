# Development Workflow – Contentstack Utils Swift

Use this as the standard workflow when contributing to Contentstack Utils Swift.

## Branches

- Use feature branches for changes (e.g. `feat/...`, `fix/...`, ticket branches like `DX-5372-cursor`).
- **CI** runs on push to `master` and on pull requests targeting `master` or `next` (see `.github/workflows/ci.yml`).
- **Merges into `master`** may be gated: PRs whose base is `master` are expected to come from the `staging` branch; other head branches may be blocked (see `.github/workflows/check-branch.yml`). Confirm with your team’s release process before opening PRs to `master`.

## Running tests

- **All tests (SPM):** `swift test`
- **Build:** `swift build`
- **CI-style Xcode (iOS Simulator):**  
  `xcodebuild -project "ContentstackUtils.xcodeproj" -scheme "ContentstackUtils-Package" -destination "OS=13.4.1,name=iPhone 11 Pro" test`  
  Adjust `-destination` for your local Xcode/Simulator.

Run tests before opening a PR. Integration-style behavior is covered with **offline** mocks and fixtures—no `.env` or live stack credentials required for the default test suite.

## Lint

- **SwiftLint:** `swiftlint` (config `.swiftlint.yml`)

## Pull requests

- Ensure the build passes: `swift build` and `swift test` (and/or `xcodebuild` if you touch Xcode-specific paths).
- Follow the **code-review** rule (see `.cursor/rules/code-review.mdc`) for the PR checklist.
- Keep changes backward-compatible for public API; call out any breaking changes clearly.
- Describe behavior changes and semver impact; update `CHANGELOG.md` and version metadata (`ContentstackUtils.podspec`, tags) when releasing—per team process.
- Security/policy scans may run in CI (`.github/workflows/sca-scan.yml`, `policy-scan.yml`); fix findings per org policy.

## Optional: TDD

If the team uses TDD, follow RED–GREEN–REFACTOR when adding behavior: write a failing test first, implement to pass, then refactor. The **testing** rule and **skills/testing** skill describe test structure and naming.

## Coverage

- **Slather** is configured in `.slather.yml` (scheme `ContentstackUtils-Package`). Use after tests to inspect coverage of `Sources/ContentstackUtils/`.
