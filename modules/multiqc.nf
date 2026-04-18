process MULTIQC {
    publishDir "${params.outdir}/qc", mode: 'copy'

    input:
    path fastqc_archives

    output:
    path("multiqc_report.html")

    script:
    """
    multiqc .
    """
}