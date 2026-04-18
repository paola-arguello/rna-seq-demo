# RNA-seq Demo Workflow

A lightweight RNA-seq differential expression workflow demo designed to showcase reproducible bioinformatics workflow design, modular structure, and interpretable downstream analysis.

## Project purpose

This repository was built as a compact portfolio project to demonstrate how raw RNA-seq data can be processed into interpretable differential expression results using a workflow-oriented design.

The goal is to highlight:

- reproducible pipeline thinking
- modular workflow structure
- separation of preprocessing and statistical analysis
- transparent assumptions and limitations

## Scope

This is a representative workflow demo, not a production or clinical-grade pipeline.

To keep the project feasible as a compact portfolio example, the workflow structure reflects a realistic RNA-seq preprocessing pipeline, while the downstream DESeq2 analysis is demonstrated using a small synthetic count matrix.

## Workflow overview

The project is organized in a Nextflow-style structure with modular process definitions for:

- Quality control with FastQC
- Read trimming
- Alignment with STAR
- Gene-level counting with featureCounts
- Differential expression analysis with DESeq2

## Reproducibility features

- modular Nextflow-style workflow structure
- parameterized configuration in `params.yaml` and `nextflow.config`
- software environment definition in `environment.yml`
- version-controlled project history with Git/GitHub
- outputs organized by analysis stage

## Repository structure

```text
rna-seq-demo/
├── README.md
├── .gitignore
├── main.nf
├── nextflow.config
├── params.yaml
├── environment.yml
├── data/
│   ├── raw/
│   ├── metadata/
│   └── reference/
├── modules/
├── scripts/
├── results/
└── docs/