#!/bin/bash
#
set -e
set -u
set -o pipefail

#1) Data set preparation:
#
labels=(Att6 Atha)

fidibus --numprocs=2 --refr=Att6,Atha download prep iloci breakdown stats
fidibus --numprocs=2 --refr=Am45,Amel download prep iloci breakdown stats

fidibus-ilocus-summary.py  --workdir=./species --outfmt=tex \
        Att6 Atha Am45 Amel  > ../tables/LSB20GB-SupplTable5-iloci.tex
