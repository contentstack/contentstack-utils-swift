# Changelog

All notable changes to this project will be documented in this file.

## [1.5.0] - 2026-03-31

- **`getVariantMetadataTags`** is the canonical API for `data-csvariants`; **`getDataCsvariantsAttribute`** is deprecated (delegates to it until removed in a major release).

## [1.4.0] - 2026-03-30

### Enhancement

- **Variant utility** — read variant aliases and emit `data-csvariants` JSON (single or many entries).
- **`VariantUtilityError`** on invalid input.

## [1.3.4] - 2025-01-17

### Changed

- Deployment targets updated.
- General enhancements and latest platform support.

## [1.3.3] - 2024-05-17

### Added

- Privacy manifest file.

### Changed

- Updated tests.

## [1.3.2] - 2024-03-28

### Added

- Support for the **fragment** tag in JSON RTE.

## [1.3.1] - 2023-11-20

### Fixed

- Image linking issue.

## [1.3.0] - 2023-05-26

### Added

- Nested asset support.
- Break tag support.

## [1.2.1] - 2022-09-09

### Fixed

- Swift Package warning (exclude warning from package removed).

## [1.2.0] - 2021-08-10

### Added

- JSON RTE to HTML support for the **GQL API**.

## [1.1.2] - 2021-07-16

### Added

- JSON RTE content to HTML parsing support.

## [1.1.1] - 2021-04-09

### Changed

- Deployment target updates.

### Removed

- XC Framework (issue resolved).

## [1.1.0] - 2021-04-06

### Fixed

- Swift Package duplicate naming for ContentstackUtils.

## [1.0.0] - 2021-04-06

### Added

- Embedded items feature support.
- `includeEmbeddedItems` in Entry and Query modules.
- Utils SDK support in the SDK.
