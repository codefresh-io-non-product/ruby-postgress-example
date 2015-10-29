#!/bin/bash
set -e

cd /usr/app/dir/

. ~/.nvm/nvm.sh
if grep -q "iojs" package.json; then nvm use iojs; fi
