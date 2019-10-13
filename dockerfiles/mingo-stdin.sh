#!/bin/bash

cat > tmp/input.lp
./mingo.sh "$@" tmp/input.lp
