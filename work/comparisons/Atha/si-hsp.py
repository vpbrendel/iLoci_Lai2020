import pandas as pd
import pickle
blast = pd.read_csv("si.tsv", sep='\t')
blast[['num1','num2']] = blast['identity'].str.split('/',expand=True)
blast[['num1','num2']] = blast[['num1','num2']].apply(pd.to_numeric)
blast.rename(columns = {'#name1' : 'name1'}, inplace = True)
iloci = list(set(blast.name2))
num_matches = 0
# Warning: this isn't the total number of giLoci. 
# These are giLoci that have some chains, we later filter out based on 95% length
# To get the actual number of giLoci, we need to go back to the giLoci data files

num_conserved = 0
relations = {}
locus_lengths = {}
for locus in iloci: 
    indices = blast.name2 == locus
    ilocus = blast[indices]
    query_length = ilocus.iloc[0]['size2']
    match_loci = list(set(ilocus['name1']))
    chains = {}
    for match in match_loci:
        indices = ilocus.name1 == match
        hsp = ilocus[indices]
        length = hsp['nmatch'].max()
        if length / query_length >= 0.9:
            chains[match] = length
    try:
        targets = [key for m in [max(chains.values())] for key,val in chains.items() if val == m]
        if chains[targets[0]] > ilocus[ilocus.name1 == targets[0]].iloc[0]['size1'] * 0.9:
            num_conserved += 1
        if len(targets) > 1:
            ids = {}
            for target in targets:
                search = ilocus[ilocus.name1 == target]
                if len(search) > 1:
                    max_len = search['nmatch'].max()
                    search = search[search.nmatch == max_len]
                assert len(search) <= 1
                ids[target] = search['num1'].sum() / search['num2'].sum()
                tiebreakers = [key for m in [max(ids.values())] for key,val in ids.items() if val == m]
            relations[locus] = tiebreakers
        else:
            relations[locus] = targets
    except ValueError:
        continue
with open('Atha_si-relations','wb') as f:
    pickle.dump(relations,f)
for locus in relations:
    if len(relations[locus]) > 0:
        num_matches += 1

print(str(num_matches) + ' iLoci had at least one match')
print('Conserved: ' + str(num_conserved))
