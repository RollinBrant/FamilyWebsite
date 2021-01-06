curDir <-  paste("static/letters/")
yamlFields <-   c("date","description","featured_image","title")
system(paste("rm -rf", paste0("content/",1915:1919,collapse=" ")))
for (yri in c(1915,1917)) {
#  yri <- "1915"  
  system(paste0("mkdir content/",yri))
  webDir <- paste("/letters",yri,sep="/")
  dirs <- system(paste0("ls ",curDir,yri) ,intern=TRUE)
  for (dirx in seq(along=dirs)) {
    #  dirx <- 2
    diri <- dirs[dirx]
    dateL <- as.Date(sed(diri,"s/ .*//"),format="%m-%d-%Y")
    tag <- sed(diri,"s/^[0-9-]* //")
    locdir <- paste0("'",curDir,"/",yri,"/",diri,"'") 
    page1 <- paste0(webDir,"/",diri,"/",system(paste0("ls ",locdir),intern=TRUE))[1]
    mdFile <- sed(paste0(paste0("content/",yri,"/chapter-",dirx,".md")),"s/ //g") 
    mdText <- c("---",paste(yamlFields, c(as.character(dateL),
      paste0('"',c(diri,page1,diri),'"')),sep=": "),"---",
    paste0('{{< gallery dir="',webDir,'/',diri,'" />}} {{< load-photoswipe >}}'))
    cat(mdText,file=mdFile,sep="\n",fill=TRUE)
  }
}