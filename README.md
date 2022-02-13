# RNA-Seq-perl-scripts

## Software requirements
This file will provide detailed instruction on setting up an automated RNA-seq pipeline.
Following tools are required for this analysis. These must be installed and in path.

1. Quality control - fastQC
2. Alignment of reads - STAR
3. Differential expression analysis - DeSEQ2

## Initialization
1. Download compressed readFiles from designated website/server.
2. Contruct a 3-column table with Folder-name, sample-name and group (replicates) information:

| Folder-name       | sample-name | group        |
|-------------------|-------------|--------------|
| STAR_AlignmentWN1 | WN1         | WT_untreated |
| STAR_AlignmentWN2 | WN2         | WT_untreated |
| STAR_AlignmentWN3 | WN3         | WT_untreated |

This file will serve as a database to construct an automation script.

## Generate automation script



