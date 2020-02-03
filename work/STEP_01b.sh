#!/bin/bash
#

# We retain only the output files from STEP_01a that are necessary for
# our subsequent analyses:
#
for species in  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
do
  fidibus \
	--workdir=data \
	--keep .gdna.fa .gff3 .all.prot.fa \
	--refr=$species \
	cleanup
done
\rm data/*/*.fna.gz data/*/*.gff.gz data/*/*.faa.gz

# Let's also put the error warnings into a subdirectory for safekeeping:
#
mkdir logfiles
\mv err* logfiles
