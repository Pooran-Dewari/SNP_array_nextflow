#!/usr/bin/env nextflow

process BWA {
  tag "$sampleId"
  debug true

  publishDir 'results_test/sams/', mode: 'copy', overwrite: false, pattern: "*"

  input:
  // your original input declaration didn't match the cardinality of your TRIM process output. 
  tuple val(sampleId), path(r1), path(r2)
  val genome
  // using 'val' here and not 'path' for $genome so that it can "be read unlimited times without consuming its contents"

  output:
  path "*.sam", emit: sam_files

  script:
  """
  bwa mem $genome $r1 $r2 -t 2 > ${sampleId}.sam
  """
}
