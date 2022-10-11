library(SummarizedExperiment)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE134838")
dir.create(extracted_dir)

untar(file.path(input_dir, "GSE134838_RAW.tar"), exdir = extracted_dir)
gunzip(file.path(extracted_dir, "GSM3972655_M14Day0.dge.txt.gz"))
gunzip(file.path(extracted_dir, "GSM3972656_M14Day3_Vem.dge.txt.gz"))

Day0 <- read.table(file.path(extracted_dir, "GSM3972655_M14Day0.dge.txt"), sep = "\t", header = TRUE, row.names = 1)
Day3 <- read.table(file.path(extracted_dir, "GSM3972656_M14Day3_Vem.dge.txt"), sep = "\t", header = TRUE, row.names = 1)
GSE134838_list <- list(
  Day0 = SummarizedExperiment(assay = Day0, rowData = data.frame(cell = rownames(Day0)), colData = data.frame(gene = colnames(Day0))),
  Day3 = SummarizedExperiment(assay = Day3, rowData = data.frame(cell = rownames(Day3)), colData = data.frame(cell = colnames(Day3)))
)

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE134838_list, file.path(output_dir, "GSE134838_list.rds"))
