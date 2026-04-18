# RNA-seq Demo Workflow

A lightweight RNA-seq differential expression workflow demo built to showcase reproducible bioinformatics workflow design, modular structure, and interpretable downstream analysis.


## Project purpose

This repository is a compact portfolio project created to demonstrate how raw RNA-seq data can be processed into differential expression results using a workflow-oriented design.

The goal is to highlight:

- reproducible pipeline thinking
- modular workflow structure
- separation of preprocessing and statistical analysis
- transparent assumptions and limitations


## Scope

This is a representative workflow demo, not a production or clinical-grade pipeline.

It is intentionally simplified to emphasize:

- clear pipeline stages
- parameterized execution
- environment capture
- interpretable outputs


## Planned workflow

- Quality control with FastQC
- Trimming
- Alignment
- Gene-level counting
- Differential expression with DESeq2

## Reproducibility features

- Nextflow-style workflow structure
- Parameterized configuration
- Captured software environment
- Version-controlled project history