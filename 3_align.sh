#For aligning fast files to hg38

#################### BEFORE STARTING #################
#run the following on the command line
chmod 755 *.gz
ls *r1.fq.gz  > acc1
ls *r2.fq.gz  > acc2

################### align.sh ########################
#!/bin/sh
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --mem 34G
#SBATCH -t 12:00:00
#SBATCH --array=1-3
#SBATCH --output=%A_%a.mysample.stdout

#change array number above to match number of samples

raw='/past/to/fastq/files/trimmed'

samples1=$raw'/acc1'
export l=$SLURM_ARRAY_TASK_ID\p
line=`sed -n $l $samples1`
acc1=`echo $line | cut -d ' ' -f1`
echo $acc1
cd $out

samples2=$raw'/acc2'
export l=$SLURM_ARRAY_TASK_ID\p
line=`sed -n $l $samples2`
acc2=`echo $line | cut -d ' ' -f1`
echo $acc2
cd $out

source activate /path/to/conda/environment
out='/path/to/fastq/files/trimmed/aligned'
ref='/path/to/genome/hg38/fasta/hsa.hg38.fa'
samtools faidx $ref
bwa index $ref
bwa mem -t 12 -M -R '@RG\tID:'$acc2'\tSM:'$acc2'\tPL:Illumina\tLB:'$acc2 $ref $raw/${acc2}> $out/$acc2.sam
