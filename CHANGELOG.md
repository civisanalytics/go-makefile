# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [1.2.0] - 2021-04-16
### Added
- Pull request template

### Changed
- Upgrade Go to 1.16.3
- Update download location for Go linux binary
- Set GO111MODULE environment variable to auto to enable support for GOPATH mode due to breaking change in Go 1.16

## [1.1.0]
### Changed
Update Go version to 1.10.1

## [1.0.3] - 2016-06-08
### Changed
- Use a plausable mtime when creating the archive to avoid tar warnings

## [1.0.2] - 2016-06-01
### Changed
- Upgrade go to 1.5.4
- Upgrade hub to 2.2.3
- Specify tag for go-makefile Docker image

## [1.0.1] - 2016-02-15
### Fixed
- Ensure `make test` downloads test packages
- Add more tar flags to ensure a consistent checksum

### Added
- Added a [Code of Conduct](CODE_OF_CONDUCT.md)
- Added Travis integration

## [1.0.0] - 2016-01-20
### Added
- Initial Release

[Unreleased]: https://github.com/civisanalytics/go-makefile/compare/v1.0.1...HEAD
[1.0.2]: https://github.com/civisanalytics/go-makefile/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/civisanalytics/go-makefile/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/civisanalytics/go-makefile/commit/5874cf92241d4f5a25a7ccb444fe2e98e136c666
