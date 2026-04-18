process ALIGN_STAR {
    tag "$sample_id"
    publishDir "${params.outdir}/aligned", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)
    path genome
    path annotation

    output:
    tuple val(sample_id), path("${sample_id}.sorted.bam")

    script:
    """
    mkdir -p star_index
    gunzip -c ${genome} > genome.fa
    gunzip -c ${annotation} > annotation.gtf

    STAR \
      --runMode genomeGenerate \
      --genomeDir star_index \
      --genomeFastaFiles genome.fa \
      --sjdbGTFfile annotation.gtf \
      --runThreadN 2

    STAR \
      --genomeDir star_index \
      --readFilesIn ${read1} ${read2} \
      --readFilesCommand zcat \
      --runThreadN 2 \
      --outSAMtype BAM SortedByCoordinate \
      --outFileNamePrefix ${sample_id}.

    mv ${sample_id}.Aligned.sortedByCoord.out.bam ${sample_id}.sorted.bam
    """
}