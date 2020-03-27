#!/bin/bash
#
set -u

branch=$1

species_list=($(cat "$branch"_configured.txt))
mkdir ${branch}_work
for species in ${species_list[@]}
do
        if fidibus --cfgdir=${branch}_configs --workdir=${branch}_work --refr=${species} \
			download prep iloci breakdown stats \
			>& logfiles/${branch}_${species}.log
        then
            echo $species >> ${branch}_parsed.txt
        fi
        find ${branch}_work/${species} -type f -not -name "${species}*.gff3" -and -not -name "${species}*.tsv" -exec rm {} \;
done
