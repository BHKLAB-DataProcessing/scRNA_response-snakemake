library(SummarizedExperiment)
library(GEOquery)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

extracted_dir <- file.path(output_dir, "GSE149214")
dir.create(extracted_dir)

untar(file.path(input_dir, "GSE149214_RAW.tar"), exdir = extracted_dir)
files <- list.files(extracted_dir)
for (i in files) {
  gunzip(file.path(extracted_dir, i))
}

files <- list.files(extracted_dir)
GSE149214_list <- list()
for (i in 1:length(files)) {
  file <- (file.path(extracted_dir, files[i]))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE149214_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE149214_list) <- c("Day0", "Day11_a", "Day11_b")

unlink(extracted_dir, recursive = TRUE)

saveRDS(GSE149214_list, file.path(output_dir, "GSE149214_list.rds"))
