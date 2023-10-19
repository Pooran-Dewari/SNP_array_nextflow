#!/bin/sh

#$ -V -cwd
#$ -l h_rt=01:00:00 ###HH:MM:SS
#$ -l h_vmem=25G
#$ -pe sharedmem 2 
#$ -P roslin_macqueen_lab

module load igmm/apps/TrimGalore/0.6.6
module load igmm/apps/cutadapt/1.16
module load igmm/apps/FastQC/0.11.9
module load roslin/nextflow/22.10.7

module load roslin/nextflow/22.10.7

module load igmm/apps/bwa/0.7.16
module load igmm/apps/samtools/1.2

nextflow run workflow.nf -with-report report.html
