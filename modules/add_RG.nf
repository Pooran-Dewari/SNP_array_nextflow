#!/usr/bin/env nextflow

process ADD_RG {
  debug true

  publishDir 'results_test/bams/RG', mode: 'copy', overwrite: false

  input:
  path bam
  path bai

  output:
  path "*sortedRG.bam"

  shell:
  '''
  SUFFIX=$(echo !{bam} | cut -d"_" -f 2)
    
  picard AddOrReplaceReadGroups \
  I=!{bam} \
  O=!{bam}_sortedRG.bam \
  RGID=$(echo !{bam.baseName} | cut -d"_" -f 3-5) \
  RGLB="lib1"\
  RGPL="illumina" \
  RGPU="safi_${SUFFIX}" \
  RGSM="safi_${SUFFIX}"
  '''
}
