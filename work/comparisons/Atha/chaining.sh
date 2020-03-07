#!/bin/bash
set -e 
set -u
set -o pipefail

lastz At11.iloci.fa[multiple] Atha.iloci.fa --ambiguous=iupac --match=1,9 --filter=identity:95 --chain \
		  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		  > entire.tsv
lastz At11.iloci.fa[multiple] Atha.filoci.fa --ambiguous=iupac --match=1,9 --filter=identity:95 --chain \
		  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		  > fi.tsv
lastz At11.iloci.fa[multiple] Atha.ciloci.fa --ambiguous=iupac --match=1,9 --filter=identity:95 --chain \
		  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		  > ci.tsv
lastz At11.iloci.fa[multiple] Atha.niloci.fa --ambiguous=iupac --match=1,9 --filter=identity:95 --chain \
                  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
                  > ni.tsv
lastz At11.iloci.fa[multiple] Atha.iiloci.fa --ambiguous=iupac --match=1,9 --filter=identity:95 --chain \
                  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
                  > ii.tsv
lastz At11.iloci.fa[multiple] Atha.siloci.fa --ambiguous=iupac --match=1,9 --filter=identity:95 --chain \
                  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
                  > si.tsv
