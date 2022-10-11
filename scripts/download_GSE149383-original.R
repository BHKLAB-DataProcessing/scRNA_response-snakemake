setwd("/results/")
library(GEOquery)
library(SummarizedExperiment)

getGEOSuppFiles("GSE134836")
untar("./GSE134836/GSE134836_RAW.tar", exdir = "./GSE134836")
gunzip("./GSE134836/GSM3972651_PC9D0_filtered_feature_bc_matrices.tar.gz")
gunzip("./GSE134836/GSM3972652_PC9D3Erl_filtered_feature_bc_matrices.tar.gz")
untar("./GSE134836/GSM3972651_PC9D0_filtered_feature_bc_matrices.tar")
untar("./GSE134836/GSM3972652_PC9D3Erl_filtered_feature_bc_matrices.tar")
GSE134836_list <- list()
gunzip("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/barcodes.tsv.gz")
gunzip("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/matrix.mtx.gz")
gunzip("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/features.tsv.gz")
gunzip("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/barcodes.tsv.gz")
gunzip("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/matrix.mtx.gz")
gunzip("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/features.tsv.gz")
matrix <- Matrix::readMM("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/matrix.mtx")
matrix <- as.data.frame(as.matrix(matrix))
barcodes <- read.csv2("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/barcodes.tsv", sep = "\t", header = FALSE, col.names = c("Cell"))
genes <- read.csv2("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day0/outs/filtered_feature_bc_matrix/features.tsv", sep = "\t", header = FALSE)
experiment <- SummarizedExperiment(assay = matrix, rowData = genes, colData = barcodes)
GSE134836_list[1] <- experiment
matrix <- Matrix::readMM("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/matrix.mtx")
matrix <- as.data.frame(as.matrix(matrix))
barcodes <- read.csv2("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/barcodes.tsv", sep = "\t", header = FALSE, col.names = c("Cell"))
genes <- read.csv2("./GSE134836/home/alex/lab/drugres/10x/D0D3FullSeq/Day3/outs/filtered_feature_bc_matrix/features.tsv", sep = "\t", header = FALSE)
experiment <- SummarizedExperiment(assay = matrix, rowData = genes, colData = barcodes)
GSE134836_list[2] <- experiment
names(GSE134836_list) <- c("Day0", "Day3")

getGEOSuppFiles("GSE134838")
untar("./GSE134838/GSE134838_RAW.tar", exdir = "./GSE134838")
gunzip("./GSE134838/GSM3972655_M14Day0.dge.txt.gz")
gunzip("./GSE134838/GSM3972656_M14Day3_Vem.dge.txt.gz")
Day0 <- read.table("./GSE134838/GSM3972655_M14Day0.dge.txt", sep = "\t", header = TRUE, row.names = 1)
Day3 <- read.table("./GSE134838/GSM3972656_M14Day3_Vem.dge.txt", sep = "\t", header = TRUE, row.names = 1)
GSE134838_list <- list(Day0 = SummarizedExperiment(assay = Day0, rowData = data.frame(cell = rownames(Day0)), colData = data.frame(gene = colnames(Day0))), Day3 = SummarizedExperiment(assay = Day3, rowData = data.frame(cell = rownames(Day3)), colData = data.frame(cell = colnames(Day3))))

getGEOSuppFiles("GSE134839")
untar("./GSE134839/GSE134839_RAW.tar", exdir = "./GSE134839")
system("rm ./GSE134839/GSE134839_RAW.tar")
gunzip("./GSE134839/GSM3972657_D0.dge.txt.gz")
gunzip("./GSE134839/GSM3972658_D1.dge.txt.gz")
gunzip("./GSE134839/GSM3972659_D2.dge.txt.gz")
gunzip("./GSE134839/GSM3972660_D4.dge.txt.gz")
gunzip("./GSE134839/GSM3972661_D9.dge.txt.gz")
gunzip("./GSE134839/GSM3972662_D11.dge.txt.gz")
files_list <- list.files("./GSE134839/")
GSE134839_list <- list()
for (i in 1:length(files_list)) {
  file <- (paste("./GSE134839/", files_list[i], sep = ""))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE134839_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE134839_list) <- c("Day0", "Day1", "Day2", "Day4", "Day9", "Day11")

getGEOSuppFiles("GSE134841")
untar("./GSE134841/GSE134841_RAW.tar", exdir = "./GSE134841/")
system("rm ./GSE134841/GSE134841_RAW.tar")
files <- list.files("./GSE134841/")
for (i in files) {
  gunzip(paste("./GSE134841/", i, sep = ""))
}
files <- list.files("./GSE134841/")
GSE134841_list <- list()
for (i in 1:length(files)) {
  file <- (paste("./GSE134841/", files[i], sep = ""))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE134841_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE134841_list) <- c("Day0", "Day2", "Day11", "Day19_DMSO", "Day19")

getGEOSuppFiles("GSE149214")
untar("./GSE149214/GSE149214_RAW.tar", exdir = "./GSE149214")
system("rm ./GSE149214/GSE149214_RAW.tar")
files <- list.files("./GSE149214/")
for (i in files) {
  gunzip(paste("./GSE149214/", i, sep = ""))
}
files <- list.files("./GSE149214/")
GSE149214_list <- list()
for (i in 1:length(files)) {
  file <- (paste("./GSE149214/", files[i], sep = ""))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE149214_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE149214_list) <- c("Day0", "Day11_a", "Day11_b")

getGEOSuppFiles("GSE149215")
untar("./GSE149215/GSE149215_RAW.tar", exdir = "./GSE149215/")
system("rm ./GSE149215/GSE149215_RAW.tar")
files <- list.files("./GSE149215/")
GSE149215_list <- list()
for (i in 1:length(files)) {
  file <- (paste("./GSE149215/", files[i], sep = ""))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE149215_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE149215_list) <- c("D3-Erl1", "D3-Erl2", "D3-Criz-Erl1", "D3-Criz-Erl2", "D3-Eto")

getGEOSuppFiles("GSE160244")
untar("./GSE160244/GSE160244_RAW.tar", exdir = "./GSE160244/")
system("rm ./GSE160244/GSE160244_RAW.tar")
files <- list.files("./GSE160244/")
for (i in files) {
  gunzip(paste("./GSE160244/", i, sep = ""))
}
files <- list.files("./GSE160244/")
GSE160244_list <- list()
for (i in 1:length(files)) {
  print(i)
  file <- (paste("./GSE160244/", files[i], sep = ""))
  table <- read.table(file, header = TRUE, row.names = 1, sep = "\t")
  GSE160244_list[i] <- SummarizedExperiment(assay = table, rowData = data.frame(gene = rownames(table)), colData = data.frame(cell = colnames(table)))
}
names(GSE160244_list) <- c("Control", "Criz", "Osim", "Osim + Criz")

full_experiment_list <- list(GSE134836 = GSE134836_list, GSE134838 = GSE134838_list, GSE134839 = GSE134839_list, GSE134841 = GSE134841_list, GSE149214 = GSE149214_list, GSE149215 = GSE149215_list, GSE160244 = GSE160244_list)
