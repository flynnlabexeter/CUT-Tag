# CUT-Tag
Scripts for analysis of CUT&Tag data. 

Four scripts are provided. Each script is modular and can be run separately:
1. Demultiplexing
2. Trimming
3. Alignment
4. Sam to bigWig 

## Dependencies
demuxFQ is required for demultiplexing. 

The subsequent steps require the tools below:

cutadapt
bwa
samtools
bedtools
bamCoverage (from deepTools)

These can be installed using
conda install -c bioconda cutadapt bwa samtools bedtools deeptools

### SLURM Job Submission
Scripts are formatted for SLURM job scheduling.

#### Notes
Modify file paths in the scripts before running.
#SBATCH parameters should be adjusted based on cluster configuration.
