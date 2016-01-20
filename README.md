# go-makefile

Define a set of standards for versioning, packaging, and releasing Go projects.

This project's objective is to compile a Go project for standard architectures,
version the binaries, package it to a defined format, and push a release to GitHub.

## Installation

 1. Install Docker
 1. Add go-makefile to your project by copying the [GoMakefile](GoMakefile) file to your project root.
    You do not need to copy any other files from the go-makefile repository to use GoMakefile.
 1. Create a Makefile in your repository with the contents (replace github.com/civisanalytics/example
    with your package path):
    ```
VERSION := 1.0.0
REPOSITORY := github.com/civisanalytics/example

include GoMakefile
```

## Usage

### Build the project

`make` or `make build`

### Test and Vet the project

`make test`

### Create a GitHub Release

 1. Set the `GITHUB_TOKEN` environment variable
 1. Run `make release`

#### Release Format

The default OS architectures are darwin/amd64 and linux/amd64.
The binary is compiled with a `main.VERSION` ldflag.

 - https://github.com/civisanalytics/example/releases/tag/v1.0.0
 - Downloads
   - PROJECTNAME_VERSION_darwin_amd64.tar.bz2
     - compressed with bzip2 because it has the best compression ratio of
       [go supported compression algorithms](https://golang.org/pkg/compress/)
     - contains basenamed executables in the root of the archive
   - PROJECTNAME_VERSION_linux_amd64.tar.bz2
     - "
   - SHA256SUMS
     - contains SHA 256 sums of the tar.bz2 files

## Dockerfile

The [civisanalytics/go-makefile](https://hub.docker.com/r/civisanalytics/go-makefile/)
Docker image used by GoMakefile was created by the Dockerfile in this repository.

### Dependencies

 - The Go Programming Language
 - [gox](https://github.com/mitchellh/gox)
 - [hub](https://github.com/github/hub)

## Testing

Uses [bats](https://github.com/sstephenson/bats). Install with `brew install bats`.

Run tests with
```
bats test
```

## go-makefile vs. Other Software

 - [goxc](https://github.com/laher/goxc)
   - go-makefile focuses only on building and GitHub releasing using existing projects
     that specialize in those steps (gox and hub).
   - go-makefile does not require go to be installed (go runs inside of a docker container)
   - The configuration of go-makefile is done with Makefile variables.
 - Custom Shell Scripts
   - While these provide the most flexability, go-makefile provides a way to share a standard
     build and release process between multiple projects while defining a version and allowing
     integration with an existing Makefile workflow.

## Contributing

 1. Fork it ( https://github.com/civisanalytics/go-makefile/fork )
 1. Create your feature branch (`git checkout -b my-new-feature`)
 1. Commit your changes (`git commit -am 'Add some feature'`)
 1. Push to the branch (`git push origin my-new-feature`)
 1. Create a new Pull Request

## License

go-makefile is released under the [BSD 3-Clause License](LICENSE.txt).
