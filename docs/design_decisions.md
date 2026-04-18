# Design Decisions

## Goal

This project was designed as a lightweight RNA-seq workflow demo to show how raw sequencing data can be processed into interpretable differential expression results using a reproducible, modular structure.

It is intended as a representative portfolio workflow rather than a production or clinical-grade analysis pipeline.

## Why quality control matters

Quality control is the first checkpoint in RNA-seq because downstream results depend on the quality of the reads entering the workflow. FastQC helps identify low-quality bases, adapter contamination, sequence duplication, and other technical artifacts that can affect alignment and quantification.

## Why trimming is included

Trimming is included to represent a common preprocessing step used to remove adapters and low-quality bases. In a minimal workflow, this stage shows awareness that preprocessing decisions can influence alignment quality and downstream counts.

## Why alignment and counting are separate steps

Alignment and counting solve different problems. Alignment maps sequencing reads to genomic coordinates, while counting summarizes aligned reads into gene-level abundance values suitable for statistical analysis.

## Why normalization is needed

Raw counts are not directly comparable across samples because sequencing depth and library composition differ. DESeq2 normalization adjusts for these systematic differences so that expression differences are interpreted on a comparable scale.

## Assumptions in differential expression

This workflow assumes that most genes are not differentially expressed, that count data can be modeled with a negative binomial distribution, and that the sample metadata correctly represents the experimental design. It also assumes that there are no major unmodeled batch effects.

## Why simulated counts were used

For speed and clarity, the downstream statistical analysis was demonstrated using a small synthetic count matrix. This keeps the project feasible as a compact portfolio example while still showing the structure of an RNA-seq workflow and the interpretation of DESeq2 outputs.

## Limitations

This workflow is intentionally simplified. It does not include batch correction, transcript-level quantification, strandedness checks, detailed alignment QC review, containerization, or production-scale resource optimization. The aim is to demonstrate reproducible workflow thinking rather than to provide a full analysis framework.