#!/bin/bash
set -e
set -u
set -o pipefail

Amels=(Amel Amh3)

fidibus --numprocs=3 --refr=Amel,Amh3,Atha download prep iloci breakdown stats
for name in ${Amels[@]}
do
    mv species/${species}/${species}.iloci.tsv Amel/ 
    mv species/${species}/${species}.iloci.fa Amel/
done
mv species/Atha/Atha.iloci.tsv Atha/
mv species/Atha/Atha.iloci.fa Atha/
mv species/Atha/GCF_000001735.3_TAIR10_genomic.fna Atha/

cd Atha/
wget https://www.arabidopsis.org/download_files/Genes/Araport11_genome_release/Araport11_blastsets/Araport11_genes.201606.pep.fasta.gz
wget https://www.arabidopsis.org/download_files/Genes/Araport11_genome_release/Araport11_GFF3_genes_transposons.201606.gff.gz
gunzip *.gz
bash xprepAt11 && bash xrunAt11 && mv species/At11/At11.iloci.* .
cd ../
bash Amel/chaining.sh && bash Amel/hsp.sh && bash Amel/counts.sh
bash Atha/chaining.sh && bash Atha/hsp.sh && bash Atha/counts.sh


