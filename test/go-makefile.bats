#!/usr/bin/env bats

export TMP="${BATS_TEST_DIRNAME}/tmp/go-makefile"
export TMP_PROJECTDIR="${TMP}/example"

# remove 2>&1 to view docker build output
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

  cat <<EOT > main_test.go
package main
import "testing"
func TestTrue(t *testing.T) {
    if false != false {
      t.Error("false is not false")
    }
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
package example_package
import "fmt"
func main() {
    fmt.Println("hello world from example_package")
}
EOT

  cat <<EOT > main_test.go
package example_package
import (
  "testing"
  "github.com/golang/example/stringutil"
)
func TestTrue(t *testing.T) {
    if true != true {
      t.Error("true is not true")
    }
}

func TestReverse(t *testing.T) {
    if stringutil.Reverse("hello") != "olleh" {
      t.Error("hello cannot be reversed")
    }
}
EOT

  cd $TMP_PROJECTDIR
  make
}

@test "check version" {
  cd $TMP_PROJECTDIR
  run "build/example_1.0.0_$(uname | tr 'A-Z' 'a-z')_amd64/example"
  [ "$output" = "hello world 1.0.0" ]
}

@test "make test gets test packages" {
  cd $TMP_PROJECTDIR
  make test
}

@test "check SHA256SUMS" {
  cd $TMP_PROJECTDIR

  sha256sums=$(<"${TMP_PROJECTDIR}/build/SHA256SUMS")

  echo $sha256sums

  # two spaces between checksum and filename
  expected_sha256sums="95b68bfb48ff3bc02392ae4fb3084549fdb529fd74c586b6d3ed98f517321c53  example_1.0.0_darwin_amd64.tar.bz2
298b83d9332e7d60aa3b71ca6ac7714954af443a361b1e76068ee3574fb70421  example_1.0.0_linux_amd64.tar.bz2"

  [ "$sha256sums" = "$expected_sha256sums" ]
}

teardown() {
  if [ -n "$output" ]; then
    echo "not ok: $output"
  fi
}
