#!/bin/bash
#

#Note: We assume that you have sufficient processors to run all branchds separately
#      in the background.

mkdir logfiles
branches=(fungi invertebrate plant protozoa vertebrate_mammalian vertebrate_other)

for branch in ${branches[@]}
do
    ./run-fidibus-branch.sh ${branch} >& logfiles/log_${branch} &
done
wait
