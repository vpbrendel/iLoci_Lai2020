#!/bin/bash
set -e
set -u
set -o pipefail

python fi-hsp.py
python ci-hsp.py
python ni-hsp.py
python si-hsp.py
python ii-hsp.py
python entire-hsp.py
