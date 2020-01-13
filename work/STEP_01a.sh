#!/bin/bash
#

# Run the download/prep steps individually per species in the background,
# capturing any warning messages concerning the GFF3 input:
#
for species in  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
do
  fidibus \
	--workdir=data \
	--refr=$species \
	download prep \
	>& err_$species &
done
wait

# The remaining steps are run using the multiprocessing implementation in
# fidibus:
#
fidibus \
	--workdir=data \
	--numprocs=10 \
	--refr=Scer,Cele,Crei,Mtru,Agam,Dmel,Xtro,Drer,Mmus,Hsap \
	iloci breakdown stats \
	>& err_all
