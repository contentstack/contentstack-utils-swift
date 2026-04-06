---
name: code-review
description: Use when reviewing PRs or before opening a PR—API design, errors, backward compatibility, dependencies, security, and test quality.
---

# Code Review – Contentstack Utils Swift

## When to use

- Reviewing someone else’s PR.
- Self-reviewing before submission.
- Checking that changes meet project standards (API, errors, compatibility, tests, security).

## Instructions

Work through the checklist in `.cursor/rules/code-review.mdc`. Optionally tag items with severity: **Blocker**, **Major**, **Minor**.

### 1. API design and stability

- [ ] **Public API:** New or changed `public` / `open` surface is necessary and documented (`README` / `CHANGELOG` as appropriate).
- [ ] **Backward compatibility:** No breaking changes unless agreed (e.g. major version). Call out deprecations and alternatives.
- [ ] **Naming:** Consistent with existing Utils and RTE terminology (`ContentstackUtils`, `Option`, `Node`, `GQL`).

**Severity:** Breaking public API without approval = Blocker. Missing docs on new public API = Major.

### 2. Error handling and robustness

- [ ] **Errors:** Domain failures use clear types; `throws` is used where callers need to recover or log.
- [ ] **Optionals:** No unintended force-unwraps on public paths.

**Severity:** Wrong or missing error handling in new code = Major.

### 3. Dependencies and security

- [ ] **Dependencies:** `Package.swift` / podspec changes are justified; versions do not introduce known vulnerabilities.
- [ ] **SCA:** Security findings (e.g. Snyk) in scope are addressed or deferred with a ticket.

**Severity:** New critical/high vulnerability = Blocker.

### 4. Testing

- [ ] **Coverage:** New or modified behavior has corresponding tests under `Tests/ContentstackUtilsTests/` when feasible.
- [ ] **Quality:** Tests are readable and deterministic.

**Severity:** No tests for new behavior where tests are practical = Blocker. Flaky tests = Major.

### 5. Optional severity summary

- **Blocker:** Must fix before merge (e.g. breaking API without approval, security issue, missing tests).
- **Major:** Should fix (e.g. inconsistent errors, broken README examples).
- **Minor:** Nice to fix (e.g. style, minor docs).

## References

- Project rule: `.cursor/rules/code-review.mdc`
- Testing skill: `skills/testing/SKILL.md`
