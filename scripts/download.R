options(timeout=1000)
library(GEOquery)
args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]

download_dir <- paste0(work_dir, 'download')
dir.create(download_dir)

getGEOSuppFiles("GSE134836", makeDirectory=FALSE, baseDir=download_dir)
getGEOSuppFiles("GSE134838", makeDirectory=FALSE, baseDir=download_dir)
getGEOSuppFiles("GSE134839", makeDirectory=FALSE, baseDir=download_dir)
getGEOSuppFiles("GSE134841", makeDirectory=FALSE, baseDir=download_dir)
getGEOSuppFiles("GSE149214", makeDirectory=FALSE, baseDir=download_dir)
getGEOSuppFiles("GSE149215", makeDirectory=FALSE, baseDir=download_dir)
getGEOSuppFiles("GSE160244", makeDirectory=FALSE, baseDir=download_dir)