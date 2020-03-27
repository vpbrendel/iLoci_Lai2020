# Genome summaries for NCBI genomes from specifiec taxanomi branches

## Retrieving the directory hierarchical structure for a branch
We first retrieve the hierarchical directory structure for our desired branch(es) of interest. For example,

```bash
lftp -e "find;quit" ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/invertebrate/ > invertebrate_temp.txt
```

This will include all the main directories, including all genome versions.
Although this information may be useful, we are only seeking one genome annotation per species here, the latest version. 

```bash
grep -E "latest_assembly_versions/\w" invertebrate_temp.txt > invertebrate_latest.txt
```

The invertebrate_latest.txt file is the one on which the [make_cfg.py](https://github.com/timlai4/iLoci_Lai2020/blob/mass/work/mass_retrieval/make_cfg.py) is written to search.
Note that it fulfills the initially stated goal of pulling one (the latest) genome annotation per species.
Then, the script will make one YAML file per species so that when run with fidibus, we will have all YAML files for all species in the branch, as well as a convenient batch script to execute the fidibus tasks simultaneously. 

For simplicity, the user may run [configure_genomes.sh](https://github.com/BrendelGroup/iLoci_Lai2020/blob/master/work/taxa/configure_genomes.sh) to get all the main branches' latest YAML files.

## Analyzing and obtaining summaries
We can now call fidibus on each individual genome per branch. Of course, we expect several to fail and for brevity, we do not consider these
 We save all the genomes that processed successfully to perform our statistical analyses.

For simplicity, the user may run [run-fidibus-all.sh](https://github.com/BrendelGroup/iLoci_Lai2020/blob/master/work/taxa/run-fidibus-all.sh) followed by [get-statistics.sh](https://github.com/BrendelGroup/iLoci_Lai2020/blob/master/work/taxa/get-statistics.sh).
