#!/bin/sh

#$ -V -cwd
#$ -l h_rt=60:00:00 ###HH:MM:SS
#$ -l h_vmem=20G
#$ -pe sharedmem 16

module load igmm/apps/TrimGalore/0.6.6
module load igmm/apps/cutadapt/1.16
module load igmm/apps/FastQC/0.11.9

module load igmm/apps/bwa/0.7.16
# make sure you are using recent version of samtools to avoid issues with -o option
module load igmm/apps/samtools/1.16.1

module load igmm/apps/picard/2.25.4
module load roslin/java/18.0.2

./nextflow run workflow.nf
