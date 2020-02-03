#!/bin/bash
#

# Write summary iLocus information into tab-delimited files in the tables
# directory:
#
mkdir tables
fidibus-ilocus-summary.py  --workdir=data --outfmt=tsv Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap  > tables/ilocus-delta500-summary.tsv
fidibus-pilocus-summary.py --workdir=data --outfmt=tsv Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap  > tables/pilocus-delta500-summary.tsv
fidibus-milocus-summary.py --workdir=data --outfmt=tsv Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap  > tables/milocus-delta500-summary.tsv
