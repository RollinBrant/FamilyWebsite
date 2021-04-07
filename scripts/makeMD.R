curDir <-  paste("content/")
yamlFields <-   c("date","description","title")
for (yri in c(1915:1919)) {
#  
  yri <- "1919"  
  dirs <- system(paste0("ls ",curDir,yri) ,intern=TRUE)
  for (dirx in seq(along=dirs)) {
    #  dirx <- 2
    diri <- dirs[dirx]
    dateL <- as.Date(sed(diri,"s/ .*//"),format="%m-%d-%Y")
    tag <- sed(diri,"s/^[0-9-]* //")
    locdir <- paste0("'",curDir,yri,"/",diri,"'") 
    cmd <-  paste0("mkdir ", locdir, "/img")
    system(cmd)
    cmd <- paste0("mv ", locdir, "/*.jpg* ", locdir, "/img")
    system(cmd)
    mdText <- c("---",paste(yamlFields, c(as.character(dateL),
     paste0('"',c(diri,diri),'"')),sep=": "),"---",
     paste0('{{< gallery >}}')) 
    cat(mdText,file="index.md",sep="\n",fill=TRUE)
    cmd <- paste0("mv index.md ",locdir)
    system(cmd)
  }
} 

