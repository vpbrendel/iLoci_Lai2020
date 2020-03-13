#!/bin/bash
set -u

batches = (fungi invertebrate plant protozoa vertebrate_mammalian vertebrate_other)
for batch in ${batches[@]}
do
    species_list=($(cat ${batch}.txt))
    fidibus-ilocus-summary.py --outfmt=tsv ${species_list[@]} > ${batch}-ilocus-summaries.tsv
    fidibus-pilocus-summary.py --outfmt=tsv ${species_list[@]} > ${batch}-pilocus-summaries.tsv
    fidibus-milocus-summary.py --outfmt=tsv ${species_list[@]} > ${batch}-milocus-summaries.tsv
    fidibus-compact.py --centroid=2.25  --length=1000000 --iqnt=0.95 --gqnt=0.05 ${species_list[@]} > ${batch}_fungi.tsv
done
python compute_averages.py
