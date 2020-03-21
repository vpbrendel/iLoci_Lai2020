#!/bin/bash
set -e
set -u
set -o pipefail


branches=(fungi invertebrate plant protozoa vertebrate_mammalian vertebrate_other)

for branch in ${branches[@]}
do
    mkdir ${branch}
    lftp -e "find;quit" ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/${branch}/ | grep -E "latest_assembly_versions/\w" > ${branch}_latest.txt
    python make_cfg.py $branch
done

