#!/bin/bash
set -e
set -u
set -o pipefail

python hsp.py
python entire-hsp.py
