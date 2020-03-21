#!/bin/bash

set -u

batches = (fungi.txt invertebrate.txt plant.txt protozoa.txt vertebrate_mammalian.txt vertebrate_other.txt)
for batch in ${batches[@]}
do
    species_list=($(cat "$batch"))
    for species in ${species_list[@]}
    do
        if singularity exec -e -B `pwd` aegean.simg fidibus -c=. --refr=$species download prep iloci breakdown stats
        then
            echo $species >> final_${batch}
        fi
    done
done
find species -type f -not -name "*.gff3" -and -not -name "*.tsv" -exec rm {} \;
