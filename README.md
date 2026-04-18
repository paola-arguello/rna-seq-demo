# RNA-seq Demo Workflow

A lightweight RNA-seq workflow designed to show how raw sequencing data can be transformed into interpretable differential expression results using a reproducible and modular analysis structure.

This project was built as a compact portfolio piece for bioinformatics applications. The focus is not on scaling or production deployment, but on demonstrating clear workflow design, reproducibility practices, and the reasoning behind each step of the analysis.

---

## Project overview

RNA-seq pipelines are often presented either as fragmented scripts or as final statistical outputs. This repository brings both sides together in a single, structured example.

The workflow is designed to show:

- how preprocessing steps connect to downstream analysis  
- how modular workflows improve clarity and extensibility  
- how reproducibility can be built in from the start  
- how statistical outputs can be interpreted in context  

To keep the project concise and runnable within a short time frame, the preprocessing stages are represented structurally, while the differential expression analysis is executed on a small synthetic dataset.

---

## What this workflow includes

The repository follows a Nextflow-style structure with modular components for:

- quality control with FastQC  
- read trimming  
- alignment with STAR  
- gene-level counting with featureCounts  
- differential expression analysis with DESeq2 in R  

The goal is to demonstrate how these steps fit together conceptually, rather than to fully execute a production RNA-seq pipeline.

---

## Reproducibility approach

Reproducibility is treated as part of the design, not an afterthought. This project includes:

- a Nextflow-style workflow (`main.nf`)  
- modular process definitions (`modules/`)  
- parameterized configuration (`params.yaml`, `nextflow.config`)  
- a defined software environment (`environment.yml`)  
- version-controlled development with Git  

Outputs are organized by stage under `results/` to make data flow easy to follow.

---

## Repository structure

```text
rna-seq-demo/
├── main.nf
├── nextflow.config
├── params.yaml
├── environment.yml
├── modules/
├── scripts/
├── data/
├── results/
└── docs/

```

---

## Example outputs

The downstream analysis produces a minimal but interpretable set of results.

### PCA plot

Samples separate by condition after variance-stabilizing transformation, indicating that the simulated treatment effect is captured in the expression structure.

### Volcano plot

A subset of genes shows larger fold changes and stronger statistical significance, illustrating how differential expression results are typically summarized.

### Results tables

`results/deseq2/deseq2_results.csv`

`results/deseq2/top20_results.csv`

These files provide ranked differential expression results, including log2 fold changes and adjusted p-values.

---

## How to run

### 1. Create the environment

`conda env create -f environment.yml`

`conda activate rnaseq-demo`

### 2. Generate demo counts

`Rscript scripts/make_demo_counts.R`

### 3. Run differential expression analysis

`Rscript scripts/run_deseq2.R`

### 4. Inspect the workflow scaffold
`nextflow run main.nf -params-file params.yaml`

---

## Workflow logic

At a high level, the analysis follows:

FASTQ
  → QC
  → Trimming
  → Alignment
  → Counting
  → Differential expression
  → PCA / Volcano / Results

This structure reflects a standard RNA-seq workflow, with a clear separation between preprocessing and statistical analysis.

---


## Design decisions

A short explanation of the key choices in this workflow is available in:

`docs/design_decisions.md`

This includes:

- why quality control is essential
- why normalization is required before comparison
- assumptions behind differential expression analysis
- limitations of this simplified setup

---

## Scope and limitations

This is a simplified workflow by design.

It does not include:

- batch correction
- transcript-level quantification
- detailed alignment QC review
- containerization
- large-scale execution

Instead, the project focuses on demonstrating how to structure a reproducible analysis and communicate its results clearly.