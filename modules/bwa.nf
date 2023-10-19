#!/usr/bin/env nextflow

process BWA {
  tag "$sampleId"
  debug true

  publishDir 'bwa_aligned/', mode: 'copy', overwrite: false, pattern: "*"

  input:
  // your original input declaration didn't match the cardinality of your TRIM process output. 
  tuple val(sampleId), path(r1), path(r2)

  output:
  path "*" // I would update this to be less promiscuous

  script:
  """
  bwa mem /exports/eddie/scratch/pdewari/hamour/genome/fEpiCoi_cnag1_curated_primary.no_mt.fa $r1 $r2 -t 2 > ${sampleId}.sam
  """
}
