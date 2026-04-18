process TRIM_READS {
    tag "$sample_id"
    publishDir "${params.outdir}/trimmed", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}_R1.trimmed.fastq.gz"), path("${sample_id}_R2.trimmed.fastq.gz")

    script:
    """
    trimmomatic PE \
      ${reads[0]} ${reads[1]} \
      ${sample_id}_R1.trimmed.fastq.gz ${sample_id}_R1.unpaired.fastq.gz \
      ${sample_id}_R2.trimmed.fastq.gz ${sample_id}_R2.unpaired.fastq.gz \
      SLIDINGWINDOW:4:20 MINLEN:30
    """
}