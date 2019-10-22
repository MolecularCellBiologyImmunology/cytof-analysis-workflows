## MANUAL THINGS TO DO BEFORE RUNNING THIS SCRIPT
## -> CHECK Rscript.exe LOCATION IN EXECUTABLES!
## -> SET PANDOC LOCATION BY RUNNING THE LOWEST CODE CHUNK BELOW IN RSTUDIO!


## Check if all necessary packages are installed
PACKAGES_TOTAL <- c('rhdf5', 'beeswarm', 'vipor', 'HDF5Array', 'RcppAnnoy', 'RcppHNSW', 'irlba', 'rsvd', 'ggbeeswarm', 'DelayedMatrixStats', 'BiocNeighbors', 'BiocSingular', 'beachmat', 'scater', 'abind', 'askpass', 'assertthat', 'backports', 'base64enc', 'BH', 'Biobase', 'BiocGenerics', 'BiocInstaller', 'BiocParallel', 'bitops', 'brew', 'callr', 'car', 'carData', 'CATALYST', 'caTools', 'cellranger', 'circlize', 'cli', 'clipr', 'clisymbols', 'clue', 'colorspace', 'colourpicker', 'commonmark', 'ComplexHeatmap', 'ConsensusClusterPlus', 'corpcor', 'covr', 'crayon', 'crosstalk', 'curl', 'cydar', 'cytofCore', 'cytofkit', 'cytolib', 'cytutils', 'data.table', 'DelayedArray', 'DEoptimR', 'desc', 'destiny', 'devtools', 'digest', 'doParallel', 'dotCall64', 'dplyr', 'drc', 'DT', 'e1071', 'edgeR', 'ellipsis', 'evaluate', 'fansi', 'fastmap', 'fields', 'flowCL', 'flowCore', 'flowDensity', 'FlowSOM', 'flowUtils', 'flowViz', 'flowWorkspace', 'forcats', 'foreach', 'formatR', 'fs', 'futile.logger', 'futile.options', 'gdata', 'GenomeInfoDb', 'GenomicRanges', 'GEOmap', 'GetoptLong', 'ggplot2', 'ggrepel', 'ggridges', 'ggthemes', 'gh', 'git2r', 'GlobalOptions', 'glue', 'gplots', 'graph', 'gridBase', 'gridExtra', 'gtable', 'gtools', 'haven', 'hexbin', 'highr', 'hms', 'htmltools', 'htmlwidgets', 'httpuv', 'httr', 'IDPmisc', 'igraph', 'ini', 'IRanges', 'iterators', 'jsonlite', 'knitr', 'kohonen', 'labeling', 'laeken', 'lambda.r', 'later', 'latticeExtra', 'lazyeval', 'lifecycle', 'limma', 'lme4', 'lmtest', 'locfit', 'magrittr', 'maps', 'maptools', 'markdown', 'MASS', 'MatrixModels', 'matrixStats', 'MBA', 'MEM', 'memoise', 'mime', 'miniUI', 'minqa', 'miscTools', 'multcomp', 'munsell', 'mvtnorm', 'ncdfFlow', 'nloptr', 'nnls', 'openssl', 'openxlsx', 'pbkrtest', 'pcaPP', 'pdist', 'permute', 'pillar', 'pkgbuild', 'pkgconfig', 'pkgload', 'plogr', 'plotly', 'plotrix', 'plyr', 'png', 'praise', 'prettyunits', 'processx', 'progress', 'promises', 'proxy', 'ps', 'purrr', 'quantreg', 'R6', 'Radviz', 'ranger', 'RANN', 'RBGL', 'rcmdcheck', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen', 'RcppParallel','RCurl', 'readr', 'readxl', 'rematch', 'remotes', 'reshape2', 'rex', 'RFOC', 'rgeos', 'Rgraphviz', 'Rhdf5lib', 'rio', 'rjson', 'rlang', 'rmarkdown', 'robustbase', 'roxygen2', 'Rphenograph', 'RPMG', 'rprojroot', 'RProtoBufLib', 'rrcov', 'RSEIS', 'rstudioapi', 'Rtsne', 'RUnit', 'rversions', 'Rwave', 'S4Vectors', 'sandwich', 'scales', 'scatterplot3d', 'sessioninfo', 'shape', 'shiny', 'shinyBS', 'shinydashboard', 'shinyFiles', 'shinyjs', 'SingleCellExperiment', 'smoother', 'snow', 'sourcetools', 'sp', 'spam', 'SPARQL', 'SparseM', 'splancs', 'statmod', 'stringi', 'stringr', 'SummarizedExperiment', 'sys', 'testthat', 'TH.data', 'tibble', 'tidyr', 'tidyselect', 'tinytex', 'tsne', 'TTR', 'usethis', 'utf8', 'vcd', 'vctrs', 'vegan', 'VGAM', 'VIM', 'viridis', 'viridisLite', 'whisker', 'withr', 'xfun', 'XML', 'xml2', 'xopen', 'xtable', 'xts', 'XVector', 'yaml', 'zeallot', 'zip', 'zlibbioc', 'zoo')
PACKAGES_CRAN <- c('fastmap', 'clue', 'png', 'RcppParallel', "yaml","rmarkdown","knitr", "shiny", "scales", "RColorBrewer", "MASS", "Rtsne", "kohonen", "miscTools", "gplots", "Radviz", "igraph", "statmod","dplyr","readr","tibble", "devtools")
PACKAGES_BIOCONDOCTOR <- c('rhdf5', 'beeswarm', 'vipor', 'HDF5Array', 'RcppAnnoy', 'RcppHNSW', 'irlba', 'rsvd', 'ggbeeswarm', 'DelayedMatrixStats', 'BiocNeighbors', 'BiocSingular', 'beachmat', 'scater', 'ggridges', 'SingleCellExperiment', "DelayedArray","GenomeInfoDb","GenomeInfoDbData","stringr","ggplot","flowCore", "cytofkit", "ConsensusClusterPlus", "cydar", "flowCL", "CATALYST", "ncdfFlow", "edgeR", "FlowSOM", "flowDensity")
PACKAGES_SOURCE <- c("cytofCore", "cytutils", "Rphenograph", "MEM")

setwd("..")

installation_needed <- unlist(lapply(PACKAGES_TOTAL, require, character.only = TRUE, quietly = TRUE))
installation_needed <- PACKAGES_TOTAL[installation_needed == FALSE]
installation_still_needed <- unlist(lapply(installation_needed, require, character.only = TRUE, quietly = TRUE))
installation_needed <- installation_needed[installation_still_needed == FALSE]
if (length(installation_needed) == 0) {message("\nAll packages are already installed! No installation needed.\n")} else {
  message(paste("\nThe following packages are missing:\n", paste(installation_needed, collapse = ", ")))
  
  
  ## Determine User Package Library
  LibPath <- Sys.getenv("R_LIBS_USER")
  if (!(dir.exists(LibPath))) {dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)}
  message(paste("\nInstalling Packages into Personal Library:\n",LibPath))
  
  
  ## Install Packages from local zip file or compile from the cloud
  get_os <- function(){
    sysinf <- Sys.info()
    if (!is.null(sysinf)){
      os <- sysinf['sysname']
      if (os == 'Darwin')
        os <- "osx"
    } else { ## mystery machine
      os <- .Platform$OS.type
      if (grepl("^darwin", R.version$os))
        os <- "osx"
      if (grepl("linux-gnu", R.version$os))
        os <- "linux"
    }
    tolower(os)
  }
  if (get_os()[[1]] == "windows") {packagefolder <- "./Packages_ZIP"} else {packagefolder <- "./Packages_TAR_GZ"; setwd(system("pwd", intern = T))}
  if (!(dir.exists(packagefolder))) {setwd("..")}
  if (!(dir.exists(packagefolder))) {message("\nNo directory with Package zip files found. Installing from cloud instead.\n")} else {
    
    ## From Zips
    message("\nDirectory with Package zip files found, installing from local zips.\n")
    setwd(packagefolder)
    for (file in list.files()) {if (any(grepl(pattern = strsplit(file,split="[_.]+")[[1]][1], x = installation_needed))) {install.packages(file, repos = NULL, type = "source", lib =LibPath)}}

    ## Check if all necessary packages are installed
    installation_still_needed <- unlist(lapply(installation_needed, require, character.only = TRUE, quietly = TRUE))
    installation_needed <- installation_needed[installation_still_needed == FALSE]
    installation_still_needed <- unlist(lapply(installation_needed, require, character.only = TRUE, quietly = TRUE))
    installation_needed <- installation_needed[installation_still_needed == FALSE]
    if (length(installation_needed) == 0) {message("\nAll necessary packages installed!!! You're ready to launch the other executables.\n")} 
    else {message("\nNot all packages succesfully instealled from Zips, attempting to install from cloud as well.\nThe following packages are still missing:\n", paste(installation_needed, collapse = ", "))}
  }  
  
  ## From Internet 
  if (length(installation_needed) > 1) {
    
    ## From CRAN
    chooseCRANmirror(ind = 8)
    for (package in installation_needed) {if (package %in% PACKAGES_CRAN) {install.packages(pkgs = package, repos='http://cran.us.r-project.org', dependencies = TRUE)}}
    
    ## From Bioconductor
    if (!requireNamespace("BiocManager", quietly = TRUE)) {install.packages("BiocManager")}
    for (package in installation_needed) {if (package %in% PACKAGES_BIOCONDOCTOR) {BiocManager::install(package, update = FALSE)}}
    
    ## From Source  
    require(devtools)
    require(flowCore)
    if ("cytofCore" %in% installation_needed) {install_github("nolanlab/cytofCore", force = TRUE)}
    if ("cytutils" %in% installation_needed) {install_github("ismmshimc/cytutils", force = TRUE)}
    if ("Rphenograph" %in% installation_needed) {install_github("JinmiaoChenLab/Rphenograph", force = TRUE)}
    if ("MEM" %in% installation_needed) {
      download.file(url = "http://www.nature.com/nmeth/journal/v14/n3/extref/nmeth.4149-S5.zip", destfile = "./MEM.zip")
      unzip("MEM.zip"); setwd("./MEM"); build(); install.packages("./", repos = NULL, type="source"); setwd(".."); unlink("../MEM", recursive = TRUE); # optional cleanup
      
    }

    
    ## Check if all necessary packages are installed
    installation_still_needed <- unlist(lapply(installation_needed, require, character.only = TRUE, quietly = TRUE))
    installation_needed <- installation_needed[installation_still_needed == FALSE]
    if(length(installation_needed) > 0) {message(paste("\nNot all necessary packages are installed! Run the Installation Executable again or contact the Author. The following packages are missing:\n", paste(installation_needed, collapse = ", "), "\n"))
    } else {message("\nAll necessary packages installed!!! You're ready to launch the other executables.\n")}
  }
}

## Set Pandoc
require(yaml); require(rmarkdown)
if (pandoc_available(version = NULL, error = FALSE)) {write_yaml(file = "./PATHS.YML", x= data.frame("PANDOC_INSTALLATION_PATH" = Sys.getenv("RSTUDIO_PANDOC")))
} else {paths <- read_yaml("./PATHS.YML");  Sys.setenv(RSTUDIO_PANDOC = paths$PANDOC_INSTALLATION_PATH)}

## Detach and Delete nonfunctional package folder
setwd(Sys.getenv("R_LIBS_USER"))
for (package in installation_needed) {
  try({detach(name = package)}, silent = TRUE)
  try({dir_delete(list.dirs(recursive = FALSE)[which(grepl(pattern = package, x = list.dirs(recursive = FALSE)))]); 
    message(paste("Uninstalled Disfunctional Package", package))})
}

## Delete nonfunctional Zip Files (dev only)
# for (package in installation_needed) {try({detach(name = package)}, silent = TRUE); try({dir_delete(list.dirs(recursive = FALSE)[which(grepl(pattern = package, x = list.dirs(recursive = FALSE)))]); message(paste("Uninstalled Disfunctional Package", package))})}