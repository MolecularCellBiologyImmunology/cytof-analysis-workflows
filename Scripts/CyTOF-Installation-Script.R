## MANUAL THINGS TO DO BEFORE RUNNING THIS SCRIPT
## -> CHECK Rscript.exe LOCATION IN EXECUTABLES!
## -> SET PANDOC LOCATION BY RUNNING THE LOWEST CODE CHUNK BELOW IN RSTUDIO!


## Check if all necessary packages are installed
packages_to_check <- c('abind', 'askpass', 'assertthat', 'backports', 'base64enc', 'BH', 'Biobase', 'BiocGenerics', 'BiocInstaller', 'BiocParallel', 'bitops', 'brew', 'callr', 'car', 'carData', 'CATALYST', 'caTools', 'cellranger', 'circlize', 'cli', 'clipr', 'clisymbols', 'colorspace', 'colourpicker', 'commonmark', 'ComplexHeatmap', 'ConsensusClusterPlus', 'corpcor', 'covr', 'crayon', 'crosstalk', 'curl', 'cydar', 'cytofCore', 'cytofkit', 'cytolib', 'cytutils', 'data.table', 'DelayedArray', 'DEoptimR', 'desc', 'destiny', 'devtools', 'digest', 'doParallel', 'dotCall64', 'dplyr', 'drc', 'DT', 'e1071', 'edgeR', 'ellipsis', 'evaluate', 'fansi', 'fields', 'flowCL', 'flowCore', 'flowDensity', 'FlowSOM', 'flowUtils', 'flowViz', 'flowWorkspace', 'forcats', 'foreach', 'formatR', 'fs', 'futile.logger', 'futile.options', 'gdata', 'GenomeInfoDb', 'GenomicRanges', 'GEOmap', 'GetoptLong', 'ggplot2', 'ggrepel', 'ggthemes', 'gh', 'git2r', 'GlobalOptions', 'glue', 'gplots', 'graph', 'gridBase', 'gridExtra', 'gtable', 'gtools', 'haven', 'hexbin', 'highr', 'hms', 'htmltools', 'htmlwidgets', 'httpuv', 'httr', 'IDPmisc', 'igraph', 'ini', 'IRanges', 'iterators', 'jsonlite', 'knitr', 'kohonen', 'labeling', 'laeken', 'lambda.r', 'later', 'latticeExtra', 'lazyeval', 'lifecycle', 'limma', 'lme4', 'lmtest', 'locfit', 'magrittr', 'maps', 'maptools', 'markdown', 'MASS', 'MatrixModels', 'matrixStats', 'MBA', 'MEM', 'memoise', 'mime', 'miniUI', 'minqa', 'miscTools', 'multcomp', 'munsell', 'mvtnorm', 'ncdfFlow', 'nloptr', 'nnls', 'openssl', 'openxlsx', 'pbkrtest', 'pcaPP', 'pdist', 'permute', 'pillar', 'pkgbuild', 'pkgconfig', 'pkgload', 'plogr', 'plotly', 'plotrix', 'plyr', 'praise', 'prettyunits', 'processx', 'progress', 'promises', 'proxy', 'ps', 'purrr', 'quantreg', 'R6', 'Radviz', 'ranger', 'RANN', 'RBGL', 'rcmdcheck', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen', 'RCurl', 'readr', 'readxl', 'rematch', 'remotes', 'reshape2', 'rex', 'RFOC', 'rgeos', 'Rgraphviz', 'Rhdf5lib', 'rio', 'rjson', 'rlang', 'rmarkdown', 'robustbase', 'roxygen2', 'Rphenograph', 'RPMG', 'rprojroot', 'RProtoBufLib', 'rrcov', 'RSEIS', 'rstudioapi', 'Rtsne', 'RUnit', 'rversions', 'Rwave', 'S4Vectors', 'sandwich', 'scales', 'scatterplot3d', 'sessioninfo', 'shape', 'shiny', 'shinyBS', 'shinydashboard', 'shinyFiles', 'shinyjs', 'smoother', 'snow', 'sourcetools', 'sp', 'spam', 'SPARQL', 'SparseM', 'splancs', 'statmod', 'stringi', 'stringr', 'SummarizedExperiment', 'sys', 'testthat', 'TH.data', 'tibble', 'tidyr', 'tidyselect', 'tinytex', 'tsne', 'TTR', 'usethis', 'utf8', 'vcd', 'vctrs', 'vegan', 'VGAM', 'VIM', 'viridis', 'viridisLite', 'whisker', 'withr', 'xfun', 'XML', 'xml2', 'xopen', 'xtable', 'xts', 'XVector', 'yaml', 'zeallot', 'zip', 'zlibbioc', 'zoo')
installation_needed <- (packages_to_check %in% installed.packages())
installation_needed <- packages_to_check[installation_needed == FALSE]
if (length(installation_needed) == 0) {message("\nAll packages are already installed! No installation needed.\n")} else {
  print(paste("\nThe following packages are missing:", paste(installation_needed, collapse = ", ")))
  
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
  if (dir.exists(packagefolder)) {
    
    ## From Zips
    message("\nDirectory with Package zip files found, installing from local zips.\n")
    setwd(packagefolder)
    for (file in list.files()) {if (any(grepl(pattern = strsplit(file,split="[_.]+")[[1]][1], x = installation_needed))) {install.packages(file, repos = NULL, type = "source", lib =.libPaths()[1])}}
    setwd("..")
    
    ## From Internet  
    } else {
    message("\nNo directory with Package zip files found, installing from cloud.\n")
    install.packages(pkgs = c("yaml","rmarkdown","knitr", "shiny", "scales", "RColorBrewer", "MASS", "Rtsne", "kohonen", "miscTools", "gplots", "Radviz", "igraph", "statmod","dplyr","readr","tibble", "devtools"), repos='http://cran.us.r-project.org', dependencies = TRUE)
    source("https://bioconductor.org/biocLite.R")
    biocLite(c("ggplot","flowCore", "cytofkit", "ConsensusClusterPlus", "cydar", "flowCL", "CATALYST", "ncdfFlow", "edgeR", "FlowSOM", "flowDensity"), suppressUpdates = TRUE)
    library(devtools)
    library(flowCore)
    install_github("nolanlab/cytofCore", force = TRUE)
    install_github("ismmshimc/cytutils", force = TRUE)
    install_github("JinmiaoChenLab/Rphenograph", force = TRUE)
    download.file(url = "http://www.nature.com/nmeth/journal/v14/n3/extref/nmeth.4149-S5.zip", destfile = "./MEM.zip")
    unzip("MEM.zip")
    setwd("./MEM")
    build()
    install.packages("./", repos = NULL, type="source")
    unlink("../MEM/", recursive = TRUE) # optional cleanup
    setwd("../..")    
    }
  
  ## Check if all necessary packages are installed
  installation_needed <- (packages_to_check %in% installed.packages())
  installation_needed <- packages_to_check[installation_needed == FALSE]
  if(length(installation_needed) > 0) {message(paste("\nNot all necessary packages are installed! Run the Installation Executable again or contact the Author. The following packages are missing:\n", paste(installation_needed, collapse = ", "), "\n"))
    } else {message("\nAll necessary packages installed!!! You're ready to launch the other executables.\n")}
}


## Set Pandoc
require(yaml); require(rmarkdown)
if (pandoc_available(version = NULL, error = FALSE)) {write_yaml(file = "./PATHS.YML", x= data.frame("PANDOC_INSTALLATION_PATH" = Sys.getenv("RSTUDIO_PANDOC")))
} else {paths <- read_yaml("./PATHS.YML");  Sys.setenv(RSTUDIO_PANDOC = paths$PANDOC_INSTALLATION_PATH)}

