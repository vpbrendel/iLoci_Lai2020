#!/bin/bash
#

for species in  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
do
  fidibus --workdir=data \
        --numprocs=10 \
        --refr=$species \
        download prep iloci breakdown stats \
	>& err_$species
done

fidibus-ilocus-summary.py  --workdir=data/ --outfmt=tex Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap  >&  ilocus-summary.tex
fidibus-pilocus-summary.py --workdir=data/ --outfmt=tex Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap  >& pilocus-summary.tex
fidibus-milocus-summary.py --workdir=data/ --outfmt=tex Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap  >& milocus-summary.tex
