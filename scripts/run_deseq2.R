#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(DESeq2)
  library(ggplot2)
  library(dplyr)
  library(tibble)
})

# Create output directories if they do not exist
dir.create("results/deseq2", recursive = TRUE, showWarnings = FALSE)
dir.create("results/figures", recursive = TRUE, showWarnings = FALSE)

# Read inputs
counts <- read.csv("results/counts/demo_counts_matrix.csv", row.names = 1, check.names = FALSE)
meta <- read.csv("data/metadata/sample_sheet.csv", stringsAsFactors = FALSE)

meta$condition <- factor(meta$condition, levels = c("control", "treated"))
rownames(meta) <- meta$sample

# Reorder count columns to match metadata
counts <- counts[, rownames(meta)]

# Build DESeq2 dataset
dds <- DESeqDataSetFromMatrix(
  countData = round(as.matrix(counts)),
  colData = meta,
  design = ~ condition
)

# Prefilter low-count genes
keep <- rowSums(counts(dds) >= 10) >= 2
dds <- dds[keep, ]

# Run DESeq2
dds <- DESeq(dds)
res <- results(dds, contrast = c("condition", "treated", "control"))

# Save results
res_df <- as.data.frame(res) |>
  rownames_to_column("gene") |>
  arrange(padj)

write.csv(res_df, "results/deseq2/deseq2_results.csv", row.names = FALSE)
write.csv(head(res_df, 20), "results/deseq2/top20_results.csv", row.names = FALSE)

# PCA plot
vsd <- varianceStabilizingTransformation(dds, blind = FALSE)
pca_data <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pca_data, "percentVar"))

p_pca <- ggplot(pca_data, aes(PC1, PC2, color = condition, label = name)) +
  geom_point(size = 4) +
  geom_text(vjust = -0.8, size = 3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  ggtitle("PCA of variance-stabilized counts") +
  theme_minimal(base_size = 12)

ggsave("results/figures/pca_plot.png", p_pca, width = 7, height = 5)

# Volcano plot
res_df <- res_df |>
  mutate(
    significant = ifelse(!is.na(padj) & padj < 0.05 & abs(log2FoldChange) > 1, "yes", "no"),
    neglog10padj = ifelse(!is.na(padj) & padj > 0, -log10(padj), NA_real_)
  )

p_volcano <- ggplot(res_df, aes(x = log2FoldChange, y = neglog10padj, color = significant)) +
  geom_point(alpha = 0.8) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
  xlab("log2 fold change") +
  ylab("-log10 adjusted p-value") +
  ggtitle("Volcano plot") +
  theme_minimal(base_size = 12)

ggsave("results/figures/volcano_plot.png", p_volcano, width = 7, height = 5)

message("DESeq2 analysis complete.")
message("Results written to results/deseq2/")
message("Figures written to results/figures/")
