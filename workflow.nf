#!/usr/bin/env nextflow
nextflow.enable.dsl=2


params.genome_index = file("$baseDir/genome/fEpiCoi_cnag1_curated_primary.no_mt.fa")

// These paths are relative to the workflow .nf file
include { TRIM } from '/exports/eddie/scratch/pdewari/hamour/script_working/v9/trim.nf'
include { BWA } from '/exports/eddie/scratch/pdewari/hamour/script_working/v9/bwa.nf'
include { SAM_TO_BAM } from '/exports/eddie/scratch/pdewari/hamour/script_working/v9/sam2bam.nf'
include { SORT_BAM } from '/exports/eddie/scratch/pdewari/hamour/script_working/v9/sort_bam.nf'
include { ADD_RG } from '/exports/eddie/scratch/pdewari/hamour/script_working/v9/add_RG.nf'

Channel
  .fromFilePairs("$baseDir/subset_fq/*_{1,2}.fq.gz", checkIfExists:true)
  .set{ paired_reads }

workflow {

    genome = params.genome_index
    TRIM(paired_reads)
    BWA(TRIM.out.trimmed_seqs, genome)
    SAM_TO_BAM(BWA.out.sam_files)
    SORT_BAM(SAM_TO_BAM.out.bam_files)
    ADD_RG(SORT_BAM.out.sorted_bams, SORT_BAM.out.index_bams)
}
