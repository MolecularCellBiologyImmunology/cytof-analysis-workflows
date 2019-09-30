## Check if all necessary packages are installed
packages_to_check <- c("scales", "RColorBrewer", "MASS", "Rtsne", "kohonen", "miscTools", "gplots", "Radviz", "igraph", "statmod","dplyr","readr","tibble", "flowCore", "cytofkit", "ConsensusClusterPlus", "cydar", "flowCL", "CATALYST", "ncdfFlow", "edgeR", "FlowSOM", "flowDensity", "devtools", "cytofCore", "cytutils", "Rphenograph", "MEM")
installation_needed <- (packages_to_check %in% installed.packages())
installation_needed <- packages_to_check[installation_needed == FALSE]
if(length(installation_needed) > 0) {print(paste("The following packages are missing:",installation_needed))
  stop("Not all necessary packages are installed! Run the Installation Executable.")}

## Load required Packages
require(rmarkdown); require(knitr); require(shiny)

## Ask User for .fcs files to be concatenated or for an already concatenated file. Based on these files, generate an output folder.
files <- choose.files()#capticon = "Please select one already concatonated .fsc file or multiple .fcs files to be concatonated.") 
if (!all(grepl(pattern = '.fcs$', x = files))) {stop("All selected files must have the \".fsc\" extension!")}
concat <- (length(files)>1)
if (!concat) {
  outputdir <- sub(pattern = '.fcs$', x = files, replacement = "")
} else {outputdir <- paste(dirname(files[1]),"/concatenated_",gsub("\\s+","_",gsub(pattern = ":", replacement = "_", x = date())),sep="")
}
dir.create(outputdir)

## Save variables from this script to be loaded again inside the Rmarkdown Report.
save.image(file = "temp.RData")

## Knit the Report! All this needed to be done outside of knitting the report itself in order to be able to move the report to the output folder when finished.
message("\nINSTRUCTIONS: \nYou will now be able to specify parameters for the report in a shiny interface.\nParameters with an asterisk (*) should be correct and should not be touched.")
rmarkdown::render(input = "CyTOF-Titration-Report.Rmd", params = "ask", output_dir = outputdir)
