process COUNT_GENES {
    tag "$sample_id"
    publishDir "${params.outdir}/counts", mode: 'copy'

    input:
    tuple val(sample_id), path(bam)
    path annotation

    output:
    path("${sample_id}_counts.txt")

    script:
    """
    gunzip -c ${annotation} > annotation.gtf

    featureCounts \
      -a annotation.gtf \
      -o ${sample_id}_counts.txt \
      ${bam}
    """
}