#!/bin/bash
set -e
set -u
set -o pipefail

python count_total.py
python count.py
