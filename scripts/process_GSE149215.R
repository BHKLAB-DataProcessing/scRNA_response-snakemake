library(SummarizedExperiment)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE149215")
dir.create(extracted_dir)

untar(file.path(input_dir, "GSE149215_RAW.tar"), exdir = extracted_dir)

files <- list.files(extracted_dir)
GSE149215_list <- list()
for (i in 1:length(files)) {
  file <- (file.path(extracted_dir, files[i]))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE149215_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE149215_list) <- c("D3-Erl1", "D3-Erl2", "D3-Criz-Erl1", "D3-Criz-Erl2", "D3-Eto")

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE149215_list, file.path(output_dir, "GSE149215_list.rds"))
