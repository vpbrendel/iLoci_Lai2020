#!/bin/bash
set -e 
set -u
set -o pipefail

lastz Amh3.iloci.fa[multiple] Amel.iloci.fa --match=1,9 --filter=identity:95 --chain \
		  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		  > entire.tsv
lastz Amh3.iloci.fa[multiple] Amel.filoci.fa --match=1,9 --filter=identity:95 --chain \
		  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		  > fi.tsv
lastz Amh3.iloci.fa[multiple] Amel.ciloci.fa --match=1,9 --filter=identity:95 --chain \
		  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
		  > ci.tsv
lastz Amh3.iloci.fa[multiple] Amel.niloci.fa --match=1,9 --filter=identity:95 --chain \
                  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
                  > ni.tsv
lastz Amh3.iloci.fa[multiple] Amel.iiloci.fa --match=1,9 --filter=identity:95 --chain \
                  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
                  > ii.tsv
lastz Amh3.iloci.fa[multiple] Amel.siloci.fa --match=1,9 --filter=identity:95 --chain \
                  format=general:name1,length1,size1,name2,length2,size2,identity,nmatch \
                  > si.tsv
