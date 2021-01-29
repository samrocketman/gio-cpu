#!/bin/sh

# SPDX-License-Identifier: Unlicense OR MIT

set -e

# GLSL => SPIR-V.
glslangValidator -V -o example.spv example.comp
# SPIR-V => object file.
SWIFTSHADER_TRIPLE=x86_64-linux-unknown VK_ICD_FILENAMES=../swiftshader/build.64bit/Linux/vk_swiftshader_icd.json go run ../cmd/compile -layout "0:buffer,1:image" -arch amd64 test.spv
# Build and run driver
CGO_ENABLED=1 go run ../cmd/example
