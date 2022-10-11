library(SummarizedExperiment)
library(stringr)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE160244")
dir.create(extracted_dir)

untar(file.path(input_dir, "GSE160244_RAW.tar"), exdir = extracted_dir)

files <- list.files(extracted_dir)
GSE160244_list <- list()
for (i in files) {
  gunzip(file.path(extracted_dir, i))
  extracted_file <- str_replace(i, "\\.gz$", "")
  table <- read.table(file.path(extracted_dir, extracted_file), header = TRUE, row.names = 1, sep = "\t")
  GSE160244_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
  file.remove(file.path(extracted_dir, extracted_file))
}

names(GSE160244_list) <- c("Control", "Criz", "Osim", "Osim + Criz")

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE160244_list, file.path(output_dir, "GSE160244_list.rds"))
