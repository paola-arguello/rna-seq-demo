process FASTQC {
    tag "$sample_id"
    publishDir "${params.outdir}/qc", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    path("*_fastqc.zip"), emit: zip_files
    path("*_fastqc.html"), emit: html_files

    script:
    """
    fastqc ${reads.join(' ')}
    """
}