# iLoci_Lai2020
Procedures and data for the iLoci study described in Lai, Standage and
Brendel (2020)


## Overview

This repository documents application of
[AEGeAn](https://github.com/BrendelGroup/AEGeAn) code to derive, classify, and
analyze genomic interval loci (iLoci) as described in the paper
Lai, Standage, and Brendel (2020).
Please refer to the
[AEGeAn Installation](https://github.com/BrendelGroup/AEGeAn/INSTALL.md)
site for details on how to obtain the relevant software.
The simplest way to get going is to use the AEGeAn
[Singularity](http://singularity.lbl.gov) container, e.g. as follows:

```bash
cd
git clone https://github.com/BrendelGroup/iLoci_Lai2020
cd iLoci_Lai2020
singularity pull --name aegean.simg shub://BrendelGroup/AEGeAn
rws="singularity exec -e -B ~/iLoci_Lai2020 ~/iLoci_Lai2020/aegean.simg"
$rws fidibus -h
```

In the above example, you clone this repository into your Linux home directory,
go into the iLoci_Lai2020 directory that has been created, download the AEGeAn
Singularity container, define the shell variable _rws_ ("run with singularity"),
and check that everything works by showing the "help" lines for the AEGeAn
command _fididbus_.

To reproduce the data discussed in Lai, Standage and Brendel (2020), go to
[./work](./work) and follow the instructions in the [README](./work/README.md)
file.
