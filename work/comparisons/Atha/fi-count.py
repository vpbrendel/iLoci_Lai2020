import pickle
import pandas as pd

species = "At11"
iloci = pd.read_csv(species + '.iloci.tsv',sep='\t')
ii = iloci['LocusClass'] == "iiLocus"
iiloci = iloci[ii]
fi = iloci['LocusClass'] == "fiLocus"
filoci = iloci[fi]
siloci = iloci[iloci['LocusClass'] == "siLocus"]
niloci = iloci[iloci['LocusClass'] == "niLocus"]
ciloci = iloci[iloci['LocusClass'] == "ciLocus"]

ii_ids = set(iiloci['LocusId'])
fi_ids = set(filoci['LocusId'])
si_ids = set(siloci['LocusId'])
ni_ids = set(niloci['LocusId'])
ci_ids = set(ciloci['LocusId'])

with open('Atha_fi-relations','rb') as f:
    rels = pickle.load(f)
si_count = 0
ci_count = 0
ii_count = 0
ni_count = 0
fi_count = 0
ties = 0
for key in rels:
    if len(rels[key]) < 1: 
        continue
    elif len(rels[key]) > 1: 
        ties += 1
    else:
        for match in rels[key]:
            if match in si_ids:
                si_count += 1
            elif match in ci_ids:
                ci_count += 1
            elif match in ii_ids:
                ii_count += 1
            elif match in ni_ids:
                ni_count += 1
            elif match in fi_ids:
                fi_count += 1
            else:
                raise ValueError("Wrong id")
print(si_count)
print(ci_count)
print(ni_count)
print(ii_count)
print(fi_count)
print(ties)
