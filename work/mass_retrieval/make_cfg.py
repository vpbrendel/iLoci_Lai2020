# -*- coding: utf-8 -*-
"""
Created on Sun Sep 29 22:00:07 2019

@author: Tim
"""

import re
import system

batch = [] # Initiate a batch txt file at the end to facilitate fidibus
if len(sys.argv) < 2:
    print("Enter one branch name")
elif len(sys.argv) > 2: 
    print("Enter only one branch name")
else:
    branch = sys.argv[1]
p = re.compile("\d{3}.\d_") # Accessions of the form GCF_(digits).(digit) for the most part.
# Exceptions: GCF_(digits).(two digits)
p2 = re.compile("\d{3}.\d{2}_")  # Handles this exception
f = open(branch + '_latest.txt', 'r') 
for line in f:
    yaml = {}
    entry = line.strip().split('/')
    name = entry[1].split('_')
    info = entry[-1]
    match = p.search(info)
    if match is None: # Handling the above exception with p2
        match = p2.search(info)
    try:
        fname = name[0][0] + name[1][:3]
    except IndexError:
        fname = name[0][:4]
    if len(fname) == 4:
        yaml['file_name'] = fname
    else:
        continue
    try:
        yaml['species'] = name[0] + ' ' + name[1]
    except IndexError:
        yaml['species'] = name[0]
    yaml['accession'] = info[:match.start()+5]
    yaml['build'] = info[match.start()+6:]
    L = [yaml['file_name'] + ':\n', "    species: " + yaml['species'] + '\n',
         "    source: refseq \n","    branch: " + branch + '\n',
         "    accession: " + yaml['accession'] + '\n',
         "    build: " + yaml['build']]
    batch.append(yaml['file_name'] + '\n')
    with open(branch + '/' + yaml['file_name'] + ".yml",'w') as y:
        y.writelines(L) 
f.close()

# Create the batch text file.
with open(branch + '.txt','w') as b:
    b.writelines(set(batch))
