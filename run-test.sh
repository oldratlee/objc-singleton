#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")"

rm -rf build

xcodebuild test -scheme objc-singleton
