---
name: code-review
description: PR checklist—API stability, docs, errors, compatibility, dependencies/SCA, tests, vendored code; Blocker/Major/Minor.
---

# Code review – Contentstack Utils Swift

## When to use

- Reviewing a PR, self-review before submit, or automated review prompts.

## Instructions

Work through the checklist below. Optionally tag findings: **Blocker**, **Major**, **Minor**.

### API design and stability

- [ ] **Public API:** New or changed `public` / `open` types in `Sources/ContentstackUtils/` are necessary, semver-conscious, and documented (`README.md` / `CHANGELOG.md` when user-visible).
- [ ] **Backward compatibility:** No breaking changes unless explicitly justified (e.g. major version). Prefer additive behavior and default `Option()` paths.
- [ ] **Naming:** Matches existing Utils and RTE terminology (`ContentstackUtils`, `Option`, `Node`, `GQL`, etc.).

### Error handling and robustness

- [ ] **Errors:** New `throws` paths use clear domain types (e.g. `VariantUtilityError`); callers can distinguish invalid input from parsing failures where relevant.
- [ ] **Optionals:** No force-unwraps on public code paths; document preconditions for non-optional parameters.
- [ ] **RTE JSON:** Decoding and HTML traversal stay tolerant of documented stack payload shapes; embedded-item regressions are called out.

### Dependencies and security

- [ ] **Dependencies:** `Package.swift` / `ContentstackUtils.podspec` changes are justified; versions do not introduce known vulnerabilities.
- [ ] **SCA:** Address security findings (e.g. Snyk, org scanners) in the PR or via an agreed follow-up.

### Testing

- [ ] **Coverage:** New or modified behavior in `Sources/ContentstackUtils/` has tests under `Tests/ContentstackUtilsTests/` when feasible.
- [ ] **Quality:** Tests are readable, deterministic, and follow naming/mocks conventions.

### Vendored and native code

- [ ] **Kanna / libxml2 / `Modules/`:** Reviewed for upstream parity, licensing, and Apple vs Linux builds.

### Severity (optional)

| Level | Examples |
|-------|----------|
| **Blocker** | Breaking public API without approval; security issue; no tests for new code where tests are practical |
| **Major** | Inconsistent errors; README examples that do not compile |
| **Minor** | Style; minor docs |

### Detailed review themes (from checklist sections)

- **API:** Breaking `public`/`open` without semver/CHANGELOG/podspec alignment.
- **Errors:** `throws` changes that confuse callers without a version strategy.
- **README:** Examples must match real APIs (`jsonToHtml` overloads, `GQL.jsonToHtml`).
- **Dependencies:** New packages in `Package.swift` / podspec need justification.

## References

- `skills/testing/SKILL.md`
- `skills/contentstack-utils/SKILL.md`
