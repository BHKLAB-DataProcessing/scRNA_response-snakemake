library(SummarizedExperiment)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE134839")
dir.create(extracted_dir)

untar(file.path(input_dir, "GSE134839_RAW.tar"), exdir = extracted_dir)

gunzip(file.path(extracted_dir, "GSM3972657_D0.dge.txt.gz"))
gunzip(file.path(extracted_dir, "GSM3972658_D1.dge.txt.gz"))
gunzip(file.path(extracted_dir, "GSM3972659_D2.dge.txt.gz"))
gunzip(file.path(extracted_dir, "GSM3972660_D4.dge.txt.gz"))
gunzip(file.path(extracted_dir, "GSM3972661_D9.dge.txt.gz"))
gunzip(file.path(extracted_dir, "GSM3972662_D11.dge.txt.gz"))

files_list <- list.files(extracted_dir)
GSE134839_list <- list()
for (i in 1:length(files_list)) {
  file <- (file.path(extracted_dir, files_list[i]))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE134839_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE134839_list) <- c("Day0", "Day1", "Day2", "Day4", "Day9", "Day11")

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE134839_list, file.path(output_dir, "GSE134839_list.rds"))
