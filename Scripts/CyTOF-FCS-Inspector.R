require(flowCore)
require(cytofkit)
require(ConsensusClusterPlus)
require(dplyr)
require(cytofCore)

# Choose File
files <- choose.files(caption = "Please select one already concatonated .fsc file or multiple .fcs files to be concatonated.") 
if (!all(grepl(pattern = '.fcs$', x = files))) {stop("All selected files must have the \".fsc\" extension!")}
concat <- (length(files)>1)
if (!concat) {
  outputdir <- sub(pattern = '.fcs$', x = files, replacement = "")
} else {outputdir <- paste(dirname(files[1]),"/concatenated_",gsub("\\s+","_",gsub(pattern = ":", replacement = "_", x = date())),sep="")
}
if (!concat) {fcs <- read.FCS(filename = files, transformation = FALSE)} else {fcs <- concatFCS(x = files, file_num = TRUE); write.FCS(fcs, filename = paste(outputdir,".fcs",sep=""))}
exprs <- as.data.frame(fcs@exprs)
fcs@parameters@data
t(summary(exprs))
for (col in colnames(exprs)) {print(paste(col, length(unique(exprs[,col]))))}

## Pregating
exprs <- dplyr::filter(exprs, exprs$Ce140Di < 250)
exprs <- dplyr::filter(exprs, exprs$Ir191Di > 200)
exprs <- dplyr::filter(exprs, exprs$Ir191Di < 450)
exprs <- dplyr::filter(exprs, exprs$Y89Di > 10)

## Make colnames human readable using information in the parameter data slot
markers <- gsub(pattern = ".*_", replacement = "", x = as.vector(fcs@parameters@data$desc));
colnames(exprs)[which(!is.na(markers))] <- markers[which(!is.na(markers))]


## Channel Description
"Time,Event_length,Center,SampleID,Offset,Width,Residual"
pregating_channels <- strsplit(params$pregating_channels, split = ",")[[1]]
pregating_channels <- pregating_channels[pregating_channels %in% colnames(exprs)]
instrument_channels <- strsplit(params$instrument_channels, split = ",")[[1]]
instrument_channels <- instrument_channels[instrument_channels %in% colnames(exprs)]
lineage_channels <- unlist(colnames(exprs))[!unlist(colnames(exprs)) %in% c(pregating_channels,instrument_channels)]

## Arcsinh Data Transformation
print(paste("Arcsinh Data Transformation enabled:",params$arcsinh)); if (params$arcsinh) {
  require(MASS)
  require(RColorBrewer)
  k <- 11; my.cols <- rev(brewer.pal(k, "RdYlBu"))
  cofac <- params$arcsinhcofac
  exprs <- cbind(asinh(exprs[,c(pregating_channels, lineage_channels)]/cofac), exprs[,instrument_channels])
  summary(exprs)
}

## Examine Data
plot(exprs$SampleID, exprs$CD3)

## Assign Samples
samplenumber <- params$sampleidnumber
SampleIDStart <- params$sampleidstart
SampleWidth <- params$sampleidwidth
for (sample in 1:samplenumber) 
{exprs[ between(exprs$SampleID, SampleIDStart + (sample-1)*SampleWidth, SampleIDStart + sample*SampleWidth) , "Sample"] <- sample}
#for (marker in lineage_channels) {plot(exprs[,c("SampleID", marker)], pch=".", col = exprs$Sample, main=marker)}

## Examine Data
plot(exprs$SampleID, exprs$CD3, col = exprs$Sample)
