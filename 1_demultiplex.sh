#Read1 and Read2 can be demultiplexed with separate scripts (demux1.sh and demux2.sh)

############## BEFORE STARTING ###########################
##create text files with indexes and sample names. For example
#For read 1, create demux_myrun_1.txt
AGCGATAG	CTTCGCCT	Sample1.r1.fq.gz	Sample1
AGCGATAG	TAAGATTA	Sample2.r1.fq.gz	Sample2
AGCGATAG	ACGTCCTG	Sample3.r1.fq.gz	Sample3 

#For read 2, create demux_myrun_2.txt
AGCGATAG	CTTCGCCT	Sample1.r2.fq.gz	Sample1
AGCGATAG	TAAGATTA	Sample2.r2.fq.gz	Sample2
AGCGATAG	ACGTCCTG	Sample3.r2.fq.gz	Sample3 

################# demux1.sh ################################
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --mem 34G
#SBATCH -t 36:00:00
#SBATCH -o demult1RNA_.out
#SBATCH -e demult1_.err

/path/to/demultiplexer.rhel/demuxFQ -c -d -i -e -t 1 -r 0.01 -R -l 8 -o /path/to/output/folder/ -s slx24070_summary_demuxFQ_r1.txt demux_myrun_1.txt myrun.s_1.r_1.fq.gz

################ demux2.sh ###################################
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --mem 34G
#SBATCH -t 36:00:00
#SBATCH -o demult2_.out
#SBATCH -e demult2_.err

/path/to/demultiplexer.rhel/demuxFQ -c -d -i -e -t 1 -r 0.01 -R -l 8 -o /path/to/output/folder/ -s slx24070_summary_demuxFQ_r2.txt demux_myrun_2.txt myrun.s_1.r_2.fq.gz
