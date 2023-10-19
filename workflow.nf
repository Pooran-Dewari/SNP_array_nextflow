#!/usr/bin/env nextflow
nextflow.enable.dsl=2


params.genome_index = file("$baseDir/genome/fEpiCoi_cnag1_curated_primary.no_mt.fa")

// These paths are relative to the workflow .nf file
include { TRIM } from './modules/trim.nf'
include { BWA } from './modules/bwa.nf'

Channel
  .fromFilePairs("$baseDir/subset_fq/*_{1,2}.fq.gz", checkIfExists:true)
  .set{ paired_reads }

workflow {

    genome = params.genome_index
    TRIM(paired_reads)
    BWA(TRIM.out.trimmed_seqs, genome)

}
