library(Hmisc)
fname=file.choose()
stopifnot(file.exists(fname))
titlename=strsplit(basename(fname),"\\.")[[1]][1];
#alternatively you can use
#titlename=unlist(strsplit(basename(fname),"[.]"))[1]

dat=read.csv(fname,sep="\t",skip=2)
cond=dat[3:4]
cond=cond[complete.cases(cond),]
names(cond)=c("x","cond")

uv=dat[1:2]
uv=uv[complete.cases(uv),]
names(uv)=c("x","uv")
uv$uv=uv$uv/1000 #fplc unit was mAU
#uv$uv=uv$uv/max(uv$uv) #normalize
plot(uv$x,uv$uv,type="l",col="blue",lwd=2,ylim=c(0,1.2),xlim=c(0,25),xlab="Elution (ml)",ylab="Abs./Fluor.")

minor.tick(nx=5)

#library(xlsx)
#fname=file.choose()
#stopifnot(file.exists(fname))
#file <- loadWorkbook(fname)
#df1 <- readColumns(getSheets(file)[[1]], startColumn = 3, endColumn = 5, startRow = 5, endRow = 8, header = T)

winDialog("ok", paste0("Copy the plate reading for",titlename,"to clipboard!"))
# str1=readClipboard(format = 1, raw = FALSE)
# str2=gsub("OVRFLW","Inf",str1)
# writeClipboard(str2, format = 1)
f=read.csv('clipboard',sep="\t",head=F)
#this line convert sepentine to row by row.
# f[c(2,4,6,8), 1:12]=f[c(2,4,6,8), 12:1]

f=c(t(f)) #convert back to one column
f=(f-mean(f[91:95]))/(max(f)-mean(f[91:95]))*1 #normalize

#read from the chromatogram, the fraction of A1 should be 6.65 to 6.9ml. 
#The tubing from UV detector to the fraction connector = 287ul.
df=data.frame(elution=0.25*(0:95)+6.25-0.287,F=f)
names(df)=c("Elution","Fluorescence")
lines(df$Elution,df$Fluorescence,type="s",col='red',lwd=2) 

legend("topleft",legend=c("Abs@280nm","fluor@520nm"),bty="n",lwd=2,col=c("blue","red"))
title(titlename)

write.csv(df,paste0(titlename,"_fluor.dat"),row.names = F)

pdfname=choose.files(paste0(titlename,"_fluor.pdf"),caption = "Save to pdf?",filters = "*.pdf")
if (length(pdfname)==1) {
  pdf(pdfname)
  plot(uv$x,uv$uv,type="l",col="blue",lwd=2,ylim=c(0,1.3),xlim=c(0,25),xlab="Elution (ml)",ylab="Abs./Fluor.")

 
  minor.tick(nx=5)
  lines(df$Elution,df$Fluorescence,type="s",col='red',lwd=2) 
  legend("topleft",legend=c("Abs@280nm","Fluor.em@520"),bty="n",lwd=2,col=c("blue","red"))
  title(titlename)
  dev.off()
  system(paste("explorer",pdfname),wait=F)
  
  }