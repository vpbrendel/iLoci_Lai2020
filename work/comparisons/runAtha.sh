#!/bin/bash
#
set -e
set -u
set -o pipefail

#1) Data set preparation:
#
mkdir Atha
fidibus --refr=Atha download prep iloci breakdown stats
mv species/Atha/Atha.iloci.tsv  Atha/
mv species/Atha/Atha.iloci.fa   Atha/
mv species/Atha/Atha.iloci.gff3 Atha/
mv species/Atha/GCF_000001735.3_TAIR10_genomic.fna.gz Atha/
#\rm -rf species

cd Atha
wget https://www.arabidopsis.org/download_files/Genes/Araport11_genome_release/Araport11_blastsets/Araport11_genes.201606.pep.fasta.gz
wget https://www.arabidopsis.org/download_files/Genes/Araport11_genome_release/Araport11_GFF3_genes_transposons.201606.gff.gz
gunzip *.gz
bash ../scripts/xprepAt11
fidibus --workdir=./ --local --label=At11 --gdna=ATgdna.fa \
	--gff3=ATaraport11.gff3 --prot=Araport11_genes.201606.pep.fasta \
	download prep iloci breakdown stats
mv At11/At11.iloci.tsv  ./
mv At11/At11.iloci.fa   ./
mv At11/At11.iloci.gff3 ./
\rm -rf Araport* At11 ATaraport11.gff3 ATgdna.fa ATtemp* GCF_000001735.3_TAIR10_genomic.fna
python3 ../scripts/split_iloci_by_type.py Atha
python3 ../scripts/split_iloci_by_type.py At11
cd ..


#2) Running lastz:
#
cd ./Atha

# Assuming we have at least 5 processors, we run each lastz job in the background:
#
lastz At11.iloci.fa[multiple] Atha.filoci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Atha.filoci-vs-At11.lastz &
lastz At11.iloci.fa[multiple] Atha.ciloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Atha.ciloci-vs-At11.lastz &
lastz At11.iloci.fa[multiple] Atha.niloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Atha.niloci-vs-At11.lastz &
lastz At11.iloci.fa[multiple] Atha.iiloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Atha.iiloci-vs-At11.lastz &
lastz At11.iloci.fa[multiple] Atha.siloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Atha.siloci-vs-At11.lastz &
wait
cd ..


# Processing the results:
#
iltypes=(filoci ciloci iiloci niloci siloci)

cd ./Atha
for iltype in ${iltypes[@]}
do
  n=`cat Atha.${iltype}.fa | egrep "^>" | wc -l`
  python3 ../scripts/process_lastz_output.py -n $n -i Atha.${iltype}-vs-At11.lastz -v > Atha.${iltype}-vs-At11.summary
done
cd ..


###Reciprocal runs. Let's see whether we need them.===

cd ./Atha

# Assuming we have at least 5 processors, we run each lastz job in the background:
#
lastz Atha.iloci.fa[multiple] At11.filoci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> At11.filoci-vs-Atha.lastz &
lastz Atha.iloci.fa[multiple] At11.ciloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> At11.ciloci-vs-Atha.lastz &
lastz Atha.iloci.fa[multiple] At11.niloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> At11.niloci-vs-Atha.lastz &
lastz Atha.iloci.fa[multiple] At11.iiloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> At11.iiloci-vs-Atha.lastz &
lastz Atha.iloci.fa[multiple] At11.siloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> At11.siloci-vs-Atha.lastz &
wait
cd ..


# Processing the results:
#
iltypes=(filoci ciloci iiloci niloci siloci)

cd ./Atha
for iltype in ${iltypes[@]}
do
  n=`cat At11.${iltype}.fa | egrep "^>" | wc -l`
  python3 ../scripts/process_lastz_output.py -n $n -i At11.${iltype}-vs-Atha.lastz -v > At11.${iltype}-vs-Atha.summary
done
cd ..
