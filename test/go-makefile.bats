#!/usr/bin/env bats

export TMP="${BATS_TEST_DIRNAME}/tmp/go-makefile"
export TMP_PROJECTDIR="${TMP}/example"

docker build -t go-makefile --quiet . >/dev/null 2>&1

@test "before_all" {
  cd "${BATS_TEST_DIRNAME}/.."

  rm -rf $TMP
  mkdir -p $TMP_PROJECTDIR
  pushd $TMP_PROJECTDIR

  cat <<EOT > main.go
package main
import "fmt"
var VERSION string
func main() {
    fmt.Println("hello world "+VERSION)
}
EOT

  cat <<EOT > Makefile
VERSION := 1.0.0
REPOSITORY := github.com/civisanalytics/example
DOCKER_IMAGE := -t go-makefile

include GoMakefile
EOT

  cp "${BATS_TEST_DIRNAME}/../GoMakefile" .

  mkdir -p example_package

  pushd example_package

  cat <<EOT > main.go
package main
import "fmt"
func main() {
    fmt.Println("hello world from example_package")
}
EOT

  cd $TMP_PROJECTDIR
  make
}

@test "check version" {
  cd $TMP_PROJECTDIR
  run "build/example_1.0.0_darwin_amd64/example"
  [ "$output" = "hello world 1.0.0" ]
}

@test "check SHA256SUMS" {
  cd $TMP_PROJECTDIR

  sha256sums=$(<"${TMP_PROJECTDIR}/build/SHA256SUMS")

  # echo $sha256sums

  expected_sha256sums="a950050d9381ffa8edf5db8feff604e6f7f66c9073afe6a1c008e989c2a1ad71  example_1.0.0_darwin_amd64.tar.bz2
f429864d12cb66bace3833145809450e5e7bab7f4f11f9b28956d191b1b575d9  example_1.0.0_linux_amd64.tar.bz2"

  [ "$sha256sums" = "$expected_sha256sums" ]
}
