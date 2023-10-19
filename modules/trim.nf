#!/usr/bin/env nextflow

process TRIM {
  debug true
  tag "$sampleId"

  publishDir 'trimmed/', mode: 'copy', overwrite: false

  input:
  tuple val(sampleId), path(reads)
  
  output:
  tuple val(sampleId), path("*_val_1.fq.gz"), path("*_val_2.fq.gz"), emit: trimmed_seqs
  // you can add an output channel for fastqc here, as it doesn't need to be in the same channel as the reads. 

  script:
  """
  trim_galore --paired -q 30 --length 30 --fastqc --phred33 $reads
  """
}
