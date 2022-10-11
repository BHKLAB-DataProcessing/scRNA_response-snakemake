library(SummarizedExperiment)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

full_experiment_list <- list(
  GSE134836 = readRDS(file.path(input_dir, "GSE134836_list.rds")),
  GSE134838 = readRDS(file.path(input_dir, "GSE134838_list.rds")),
  GSE134839 = readRDS(file.path(input_dir, "GSE134839_list.rds")),
  GSE134841 = readRDS(file.path(input_dir, "GSE134841_list.rds")),
  GSE149214 = readRDS(file.path(input_dir, "GSE149214_list.rds")),
  GSE149215 = readRDS(file.path(input_dir, "GSE149215_list.rds")),
  GSE160244 = readRDS(file.path(input_dir, "GSE160244_list.rds"))
)

saveRDS(full_experiment_list, file.path(output_dir, "scRNA_response.rds"))
