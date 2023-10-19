#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// These paths are relative to the workflow .nf file
include { TRIM } from './modules/trim.nf'
include { BWA } from './modules/bwa.nf'

Channel
  .fromFilePairs("$baseDir/subset_fq/*_{1,2}.fq.gz", checkIfExists:true)
  .set{ paired_reads }

workflow {
  main:
    TRIM(paired_reads)
    BWA(TRIM.out.trimmed_seqs)
}
