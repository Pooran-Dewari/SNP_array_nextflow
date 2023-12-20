#!/usr/bin/env nextflow

process SORT_BAM {
  debug true

  publishDir 'results_test/bams/sorted', mode: 'copy', overwrite: false

  input:
  path bam

  output:
  path "${bam}_sorted.bam", emit: sorted_bams
  path "${bam}_sorted.bam.bai", emit: index_bams

  script:
  """
  samtools sort $bam -o ${bam}_sorted.bam
  samtools index ${bam}_sorted.bam
  """
}
