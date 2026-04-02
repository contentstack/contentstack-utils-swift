---
name: contentstack-utils-api
description: Public API for ContentstackUtils Swift—rendering, Option/Renderable, GQL JSON, variants, errors; no bundled HTTP client.
---

# Contentstack Utils — public API skill

## Scope

This package exposes **HTML/RTE rendering** and **variant alias** helpers. It does **not** ship Stack configuration, API keys, or network clients.

## Core types

- **`ContentstackUtils`** (`Sources/ContentstackUtils/ContentstackUtils.swift`): static methods `render(content:_:)`, `render(contents:_:)`, `jsonToHtml` overloads, `getVariantAliases`, nested **`GQL`** with `jsonToHtml(rte:_:)` for GraphQL-shaped dictionaries.
- **`Option`** (`Option.swift`): open class; override `renderItem`, `renderMark`, `renderNode` for custom HTML. Implements **`Renderable`**.
- **RTE JSON:** `Node`, `JSONNode`, `JSONNodes`, `MarkType`, `StyleType`, `Metadata`, embedded models — keep decoding tolerant and documented when stack payloads evolve.

## Errors

- Use **`ContentstackUtils.VariantUtilityError`** (and similar nested types) for domain failures; prefer `throws` over optional soup for invalid variant input.

## Integration boundary

- README shows **`Contentstack.stack`**, **`fetch`**, and **Apollo** as **examples only**. Do not add hard dependencies on the main Contentstack iOS SDK or Apollo in `Package.swift` unless product explicitly requires it.

## Docs and versioning

- Update **`README.md`** and **`CHANGELOG.md`** for behavior users see. Align **`ContentstackUtils.podspec`** version with releases. Follow semver for `public`/`open` changes.

## Reference

- [Contentstack](https://www.contentstack.com/) — product home; Delivery API docs apply to how apps fetch data before calling this library.
