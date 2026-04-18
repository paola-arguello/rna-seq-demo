nextflow.enable.dsl=2

params.reads      = params.reads ?: 'data/raw/*_{R1,R2}.fastq.gz'
params.genome     = params.genome ?: 'data/reference/genome.fa.gz'
params.annotation = params.annotation ?: 'data/reference/annotation.gtf.gz'
params.outdir     = params.outdir ?: 'results'
params.metadata   = params.metadata ?: 'data/metadata/sample_sheet.csv'

include { FASTQC }      from './modules/fastqc'
include { TRIM_READS }  from './modules/trim'
include { ALIGN_STAR }  from './modules/align'
include { COUNT_GENES } from './modules/count'
include { MULTIQC }     from './modules/multiqc'

workflow {

    reads_ch = Channel
        .fromFilePairs(params.reads, flat: true)

    FASTQC(reads_ch)

    trimmed_ch = TRIM_READS(reads_ch)

    aligned_ch = ALIGN_STAR(trimmed_ch, file(params.genome), file(params.annotation))

    counts_ch = COUNT_GENES(aligned_ch, file(params.annotation))

    MULTIQC(FASTQC.out.zip_files)
}
