#install.packages("openxlsx")
#library(openxlsx)
if(!require(openxlsx)){install.packages("openxlsx"); library(openxlsx);}
fname=choose.files(filters="*.xlsx",multi=F)

stopifnot(file.exists(fname))
titlename=strsplit(basename(fname),"\\.")[[1]][1]

#a=read.xlsx("2019-08-22C 6pm 60C1hr cooled.xlsx",startRow = 41,cols=2:14,rowNames = F,colNames = F)
info=read.xlsx(fname,rows=28:36,cols=2:14,rowNames = T,colNames = T)
dat=read.xlsx(fname,rows = 41:49,cols=2:14,rowNames = T,colNames = T)
