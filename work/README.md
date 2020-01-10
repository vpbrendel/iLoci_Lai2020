## Documentation
Instructions necessary to produce the results discussed in the paper, from
download of primary data to computations and tables/figures, are given in a
sequence of STEP_x documents.
With each STEP_x document, there is an associate bash script (\*.sh) or
Jupyter notebook.
Each individual analysis should run with no problem on a laptop or desktop
computer, although reproducing all analyses requires hundreds of gigabytes of
free disk space for temporary storage of raw and intermediate data files.


## Bash scripts
Some long UNIX commands in this documentation are split across multiple lines.
This is done for the sake of readability.
The use of the backslash (`\`) character indicates that the following line is
part of the same command.
For example, the command

```bash
$rws fidibus --workdir=data \
        --numprocs=2        \
        --refr=Scer,Cele    \
        download prep
```

is identical to the command

```bash
$rws fidibus --workdir=data --numprocs=2 --refr=Scer,Cele download prep
```


## Jupyter notebooks
