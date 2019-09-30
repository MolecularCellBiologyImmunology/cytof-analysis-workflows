## MANUAL THINGS TO DO BEFORE RUNNING THIS SCRIPT
## -> SET R.exe LOCATION IN EXECUTABLES!
## -> SET PANDOC LOCATION BELOW!

## Set Pandoc
Sys.setenv(RSTUDIO_PANDOC="C:/ProgramData/App-V/8ADEA80A-6016-478D-8DF6-902A63AA5A6C/E7D739E4-E94B-42E5-AA61-39DF513EE42D/Root/RStudio/bin/pandoc")

## Check if all necessary packages are installed
packages_to_check <- c("ggplot2","scales", "RColorBrewer", "MASS", "Rtsne", "kohonen", "miscTools", "gplots", "Radviz", "igraph", "statmod","dplyr","readr","tibble", "flowCore", "cytofkit", "ConsensusClusterPlus", "cydar", "flowCL", "CATALYST", "ncdfFlow", "edgeR", "FlowSOM", "flowDensity", "devtools", "cytofCore", "cytutils", "Rphenograph", "MEM")
installation_needed <- (packages_to_check %in% installed.packages())
installation_needed <- packages_to_check[installation_needed == FALSE]
if (length(installation_needed) == 0) {stop("All packages are already installed! No installation needed.")} else {print(paste("The following packages are missing:",installation_needed))}

## Install Packages from local zip file or compile from the cloud
local <- dir.exists("Packages")
if (local) {
  message("\nDirectory with Package zip files found, installing from local zips.\n")
  
  ## From Zips
  # setwd("../.")
  setwd("./Packages")
  
  for (file in list.files()) {install.packages(file, repos = NULL, lib =.libPaths()[1])}
  install.packages(pkgs = "./MEM.zip", repos = NULL, type="source")
  install.packages("./MEM", repos = NULL, type="source")
  
  
  } else {
  message(" No directory with Package zip files found, installing from cloud.")
  
  ## From CRAN
  chooseCRANmirror("http://cran.us.r-project.org", ind = 1)
  install.packages(pcks = c("rmarkdown","knitr", "shiny", "scales", "RColorBrewer", "MASS", "Rtsne", "kohonen", "miscTools", "gplots", "Radviz", "igraph", "statmod","dplyr","readr","tibble", "devtools"), repos='http://cran.us.r-project.org')
  
  require(rmarkdown); require(knitr); require(shiny)
  
  ## From BioConductor
  source("https://bioconductor.org/biocLite.R")
  biocLite(c("ggplot","flowCore", "cytofkit", "ConsensusClusterPlus", "cydar", "flowCL", "CATALYST", "ncdfFlow", "edgeR", "FlowSOM", "flowDensity"), suppressUpdates = TRUE)
  
  ## From Source
  library(devtools)
  library(flowCore)
  install_github("nolanlab/cytofCore")
  install_github("ismmshimc/cytutils")
  install_github("JinmiaoChenLab/Rphenograph")
  download.file(url = "http://www.nature.com/nmeth/journal/v14/n3/extref/nmeth.4149-S5.zip", destfile = "./MEM.zip")
  unzip("MEM.zip")
  setwd("./MEM")
  build()
  install.packages("./", repos = NULL, type="source")
  unlink("../MEM/", recursive = TRUE) # optional cleanup
  }

## Check if all necessary packages are installed
packages_to_check <- c("ggplot2","scales", "RColorBrewer", "MASS", "Rtsne", "kohonen", "miscTools", "gplots", "Radviz", "igraph", "statmod","dplyr","readr","tibble", "flowCore", "cytofkit", "ConsensusClusterPlus", "cydar", "flowCL", "CATALYST", "ncdfFlow", "edgeR", "FlowSOM", "flowDensity", "devtools", "cytofCore", "cytutils", "Rphenograph", "MEM")
installation_needed <- (packages_to_check %in% installed.packages())
installation_needed <- packages_to_check[installation_needed == FALSE]
if(length(installation_needed) > 0) {print(paste("The following packages are missing:",installation_needed)); 
  message("Not all necessary packages are installed! Run the Installation Executable again.")} else {message("All necessary packages installed!!! You're ready to launch the executables.")}