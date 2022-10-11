library(SummarizedExperiment)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE134836")
dir.create(extracted_dir)
untar(file.path(input_dir, "GSE134836_RAW.tar"), exdir = extracted_dir)

gunzip(file.path(extracted_dir, "GSM3972651_PC9D0_filtered_feature_bc_matrices.tar.gz"))
gunzip(file.path(extracted_dir, "GSM3972652_PC9D3Erl_filtered_feature_bc_matrices.tar.gz"))
untar(file.path(extracted_dir, "GSM3972651_PC9D0_filtered_feature_bc_matrices.tar"), exdir = extracted_dir)
untar(file.path(extracted_dir, "GSM3972652_PC9D3Erl_filtered_feature_bc_matrices.tar"), exdir = extracted_dir)

gunzip(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/barcodes.tsv.gz"))
gunzip(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/matrix.mtx.gz"))
gunzip(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/features.tsv.gz"))
gunzip(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/barcodes.tsv.gz"))
gunzip(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/matrix.mtx.gz"))
gunzip(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/features.tsv.gz"))

matrix <- Matrix::readMM(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/matrix.mtx"))
matrix <- as.data.frame(as.matrix(matrix))
barcodes <- read.csv2(
  file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/barcodes.tsv"),
  sep = "\t",
  header = FALSE,
  col.names = c("Cell")
)
genes <- read.csv2(
  file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/features.tsv"),
  sep = "\t",
  header = FALSE
)
experiment <- SummarizedExperiment(assay = matrix, rowData = genes, colData = barcodes)

GSE134836_list <- list()
GSE134836_list[1] <- experiment
matrix <- Matrix::readMM(file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/matrix.mtx"))
matrix <- as.data.frame(as.matrix(matrix))
barcodes <- read.csv2(
  file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/barcodes.tsv"),
  sep = "\t",
  header = FALSE,
  col.names = c("Cell")
)
genes <- read.csv2(
  file.path(extracted_dir, "home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/features.tsv"),
  sep = "\t",
  header = FALSE
)
experiment <- SummarizedExperiment(assay = matrix, rowData = genes, colData = barcodes)
GSE134836_list[2] <- experiment
names(GSE134836_list) <- c("Day0", "Day3")

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE134836_list, file.path(output_dir, "GSE134836_list.rds"))
