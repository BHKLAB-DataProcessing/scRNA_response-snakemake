library(SummarizedExperiment)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE134841")
dir.create(extracted_dir)

untar(file.path(input_dir, "GSE134841_RAW.tar"), exdir = extracted_dir)

files <- list.files(extracted_dir)
for (i in files) {
  gunzip(file.path(extracted_dir, i))
}

files <- list.files(extracted_dir)
GSE134841_list <- list()
for (i in 1:length(files)) {
  file <- (file.path(extracted_dir, files[i]))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE134841_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE134841_list) <- c("Day0", "Day2", "Day11", "Day19_DMSO", "Day19")

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE134841_list, file.path(output_dir, "GSE134841_list.rds"))
