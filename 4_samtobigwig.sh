#to convert sam to bigwig

############### BEFORE STARTING #################
chmod 755 *sam
ls *sam  > acc1


################# SCRIPT  #######################
#!/bin/sh
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --mem 34G
#SBATCH -t 12:00:00
#SBATCH --array=1-3
#SBATCH --output=%A_%a.mysample.stdout

raw='path/to/fastqs/trimmed/aligned'
out='path/to/fastqs/trimmed/aligned'
ref='/path/to/genomes/hg38/fasta/hsa.hg38.fa'

samples1=$raw'/acc1'
export l=$SLURM_ARRAY_TASK_ID\p
line=`sed -n $l $samples1`
acc1=`echo $line | cut -d ' ' -f1`
echo $acc1
cd $out

source activate /path/to/conda/environment

samtools view -@ 8 -Sb -F 780 -q 10 -t ${ref}.fai -o $out/$acc1.bam $out/$acc1
#next sort and then remove PCR duplicates
samtools sort -@ 12 -o $out/$acc1.sort.bam $out/$acc1.bam
samtools index $out/$acc1.sort.bam
samtools rmdup $out/$acc1.sort.bam $out/$acc1.rmdup.bam
samtools index $out/$acc1.rmdup.bam

source activate /path/to/conda/environment

# --normalizeUsing CPM is optional but usually reccommended
bamCoverage --bam $out/$acc1.rmdup.bam -o $out/$acc1.rmdup.bw --normalizeUsing CPM --binSize 10
