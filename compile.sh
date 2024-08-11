#! /bin/bash

mkdir -p build

dart compile exe bin/numbrmunchr-api.dart -o build/numbrmunchr-api.exe

echo "complete"