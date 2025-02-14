#To trim fastqs. 

############## BEFORE STARTING ####################
#Before starting fun the following on the command line
chmod 755 *.gz
ls *r1.fq.gz  > acc1
ls *r2.fq.gz  > acc2

################ SCRIPT ###########################
#!/bin/sh
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --mem 34G
#SBATCH -t 12:00:00
#SBATCH --array=1-3 
#SBATCH --output=%A_%a.mysample.stdout

#adjust the array number above to your number of samples

raw='path/to/fastq/files'
out='path/to/fastq/files/trimmed'

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
out='path/to/fastq/files/trimmed'

cutadapt -q 20 -o $out/trimmed.$acc1 -p $out/trimmed.$acc2 $acc1 $acc2


