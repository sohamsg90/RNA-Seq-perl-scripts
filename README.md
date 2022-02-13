# RNA-Seq-perl-scripts

## Software requirements
This file will provide detailed instruction on setting up an automated RNA-seq pipeline.
Following tools are required for this analysis. These must be installed and in path.

1. Quality control - fastQC
2. Alignment of reads - STAR
3. Differential expression analysis - DeSEQ2

## Generate automation script
1. Download compressed readFiles from designated website/server.
2. Construct a text file with list of samples/folder. This file will serve as the input for generation of an automation script.
3. Run the following command:
```
perl star_salmon_bash_generator.pl folder_list.txt

```
This will generate an automation script `RNA_seq_STAR_SALMON_soham.sh`

## Execution

```
sh RNA_seq_STAR_SALMON_soham.sh

```
This will perform quality control (QC) using fastQC, followed by reads alignment. Genome index has to be generated using STAR command as instructed in manual.

## Differential gene expression

All gene counts file generated as a result of running STAR, has to be concatenated based on each replicate of each sample. 

# Pre-processing
Contruct a 3-column table with Folder-name, sample-name and group (replicates) information:

| Folder-name       | sample-name | group        |
|-------------------|-------------|--------------|
| STAR_AlignmentWN1 | WN1         | WT_untreated |
| STAR_AlignmentWN2 | WN2         | WT_untreated |
| STAR_AlignmentWN3 | WN3         | WT_untreated |

This file will serve as a input to concatenate gene counts.

# Execution
``` 
perl star2deseq_strand-specific_paired-end.pl
```

This generates two files to be used as input files for DeSEQ2.




