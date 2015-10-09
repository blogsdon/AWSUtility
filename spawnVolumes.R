
#create n lightweight volumes based on snap shot id
#return volume ids
require(dplyr,quietly=TRUE,warn.conflicts=FALSE)

snapshot <- commandArgs(TRUE)[[1]] %>% as.character
nVolumes <- commandArgs(TRUE)[[2]] %>% as.numeric
tempFile <- commandArgs(TRUE)[[3]] %>% as.character
outputFile <- commandArgs(TRUE)[[4]] %>% as.character


for (i in 1:nVolumes){
	awsString <- paste0('aws ec2 create-volume --region us-east-1 --availability-zone us-east-1b --volume-type gp2 --snapshot-id ',
		snapshot,
		' >> ',
		tempFile)

	cat(awsString,'\n')
	system(awsString)
}

jsonRes <- readLines(tempFile)

keep<-grep('VolumeId',jsonRes)

#paste0('rm ',tempFile) %>% system

extractVolume <- function(x){
	foo <- strsplit(x,": \"")[[1]][2]
	bar <- strsplit(foo,"\",")[[1]][1]
	return(bar)
}

volumes <- sapply(jsonRes[keep],extractVolume)

cat(volumes,sep='\n',file=outputFile)
