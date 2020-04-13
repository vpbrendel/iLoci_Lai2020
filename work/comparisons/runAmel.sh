#!/bin/bash
#
set -e
set -u
set -o pipefail

#1) Data set preparation:
#
mkdir Amel
labels=(Amel Amh3)

fidibus --numprocs=2 --refr=Amel,Amh3 download prep iloci breakdown stats

for species in ${labels[@]}
do
    mv species/${species}/${species}.iloci.tsv  Amel/ 
    mv species/${species}/${species}.iloci.fa   Amel/
    mv species/${species}/${species}.iloci.gff3 Amel/
done
#\rm -rf species

cd ./Amel
makeblastdb -in Amel.iloci.fa -dbtype nucl -out AmelILC -parse_seqids
makeblastdb -in Amh3.iloci.fa -dbtype nucl -out Amh3ILC -parse_seqids
python3 ../scripts/split_iloci_by_type.py Amel
python3 ../scripts/split_iloci_by_type.py Amh3
cd ..


#2) Running lastz:
#
cd ./Amel

# Assuming we have at least 5 processors, we run each lastz job in the background:
#
lastz Amh3.iloci.fa[multiple] Amel.filoci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amel.filoci-vs-Amh3.lastz &
lastz Amh3.iloci.fa[multiple] Amel.ciloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amel.ciloci-vs-Amh3.lastz &
lastz Amh3.iloci.fa[multiple] Amel.niloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amel.niloci-vs-Amh3.lastz &
lastz Amh3.iloci.fa[multiple] Amel.iiloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amel.iiloci-vs-Amh3.lastz &
lastz Amh3.iloci.fa[multiple] Amel.siloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amel.siloci-vs-Amh3.lastz &
wait
cd ..


#3) Processing the results:
#
iltypes=(filoci ciloci iiloci niloci siloci)

cd ./Amel
for iltype in ${iltypes[@]}
do
  n=`cat Amel.${iltype}.fa | egrep "^>" | wc -l`
  python3 ../scripts/process_lastz_output.py -n $n -i Amel.${iltype}-vs-Amh3.lastz -v > Amel.${iltype}-vs-Amh3.summary
done
cd ..


###Reciprocal runs. Let's see whether we need them.===

cd ./Amel

# Assuming we have at least 5 processors, we run each lastz job in the background:
#
lastz Amel.iloci.fa[multiple] Amh3.filoci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amh3.filoci-vs-Amel.lastz &
lastz Amel.iloci.fa[multiple] Amh3.ciloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amh3.ciloci-vs-Amel.lastz &
lastz Amel.iloci.fa[multiple] Amh3.niloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amh3.niloci-vs-Amel.lastz &
lastz Amel.iloci.fa[multiple] Amh3.iiloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amh3.iiloci-vs-Amel.lastz &
lastz Amel.iloci.fa[multiple] Amh3.siloci.fa --allocate:traceback=500M \
		--ambiguous=iupac --filter=identity:95 --chain \
		--format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		> Amh3.siloci-vs-Amel.lastz &
wait
cd ..


#Processing the results:
#
iltypes=(filoci ciloci iiloci niloci siloci)

cd Amel
for iltype in ${iltypes[@]}
do
  n=`cat Amh3.${iltype}.fa | egrep "^>" | wc -l`
  python3 ../scripts/process_lastz_output.py -n $n -i Amh3.${iltype}-vs-Amel.lastz -v > Amh3.${iltype}-vs-Amel.summary
done
cd ..
