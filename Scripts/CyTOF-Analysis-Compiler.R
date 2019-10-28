## Check if all necessary packages are installed
PACKAGES_TOTAL <- c('abind', 'askpass', 'assertthat', 'backports', 'base64enc', 'beachmat', 'beeswarm', 'BH', 'Biobase', 'BiocGenerics', 'BiocInstaller', 'BiocNeighbors', 'BiocParallel', 'BiocSingular', 'bitops', 'brew', 'callr', 'car', 'carData', 'CATALYST', 'caTools', 'cellranger', 'circlize', 'cli', 'clipr', 'clisymbols', 'clue', 'colorspace', 'colourpicker', 'colorRamps', 'commonmark', 'ComplexHeatmap', 'ConsensusClusterPlus', 'corpcor', 'covr', 'crayon', 'crosstalk', 'curl', 'cydar', 'cytofCore', 'cytofkit', 'cytolib', 'cytutils', 'data.table', 'DelayedArray', 'DelayedMatrixStats', 'DEoptimR', 'desc', 'destiny', 'devtools', 'digest', 'doParallel', 'dotCall64', 'dplyr', 'drc', 'DT', 'e1071', 'edgeR', 'ellipsis', 'evaluate', 'fansi', 'fastmap', 'fields', 'flowCL', 'flowCore', 'flowDensity', 'FlowSOM', 'flowUtils', 'flowViz', 'flowWorkspace', 'forcats', 'foreach', 'formatR', 'fs', 'futile.logger', 'futile.options', 'gdata', 'GenomeInfoDb', 'GenomeInfoDbData', 'GenomicRanges', 'GEOmap', 'GetoptLong', 'ggbeeswarm', 'ggplot2', 'ggrepel', 'ggridges', 'ggthemes', 'gh', 'git2r', 'GlobalOptions', 'glue', 'gplots', 'graph', 'gridBase', 'gridExtra', 'gtable', 'gtools', 'haven', 'HDF5Array', 'hexbin', 'highr', 'hms', 'htmltools', 'htmlwidgets', 'httpuv', 'httr', 'IDPmisc', 'igraph', 'ini', 'installr', 'IRanges', 'irlba', 'iterators', 'jsonlite', 'knitr', 'kableExtra', 'kohonen', 'labeling', 'laeken', 'lambda.r', 'later', 'latticeExtra', 'lazyeval', 'lifecycle', 'limma', 'lme4', 'lmtest', 'locfit', 'magrittr', 'maps', 'maptools', 'markdown', 'MASS', 'MatrixModels', 'matrixStats', 'MBA', 'MEM', 'memoise', 'mime', 'miniUI', 'minqa', 'miscTools', 'multcomp', 'munsell', 'mvtnorm', 'ncdfFlow', 'nloptr', 'nnls', 'openssl', 'openxlsx', 'pbkrtest', 'pcaPP', 'pdist', 'permute', 'pheatmap', 'pillar', 'pkgbuild', 'pkgconfig', 'pkgload', 'plogr', 'plotly', 'plotrix', 'plyr', 'png', 'praise', 'prettyunits', 'processx', 'progress', 'promises', 'proxy', 'ps', 'purrr', 'quantreg', 'R6', 'Radviz', 'ranger', 'RANN', 'RBGL', 'rcmdcheck', 'RColorBrewer', 'Rcpp', 'RcppAnnoy', 'RcppArmadillo', 'RcppEigen', 'RcppHNSW', 'RcppParallel', 'RCurl', 'readr', 'readxl', 'rematch', 'remotes', 'reshape2', 'rex', 'RFOC', 'rgeos', 'Rgraphviz', 'rhdf5', 'Rhdf5lib', 'rio', 'rjson', 'rlang', 'rmarkdown', 'robustbase', 'roxygen2', 'Rphenograph', 'RPMG', 'rprojroot', 'RProtoBufLib', 'rrcov', 'RSEIS', 'rstudioapi', 'rsvd', 'Rtsne', 'RUnit', 'rversions', 'Rwave', 'S4Vectors', 'sandwich', 'scales', 'scater', 'scatterplot3d', 'sessioninfo', 'shape', 'shiny', 'shinyBS', 'shinydashboard', 'shinyFiles', 'shinyjs', 'SingleCellExperiment', 'smoother', 'snow', 'sourcetools', 'sp', 'spam', 'SPARQL', 'SparseM', 'splancs', 'statmod', 'stringi', 'stringr', 'SummarizedExperiment', 'sys', 'testthat', 'TH.data', 'tibble', 'tidyr', 'tidyselect', 'tinytex', 'tsne', 'TTR', 'usethis', 'utf8', 'vcd', 'vctrs', 'vegan', 'VGAM', 'VIM', 'vipor', 'viridis', 'viridisLite', 'whisker', 'withr', 'xfun', 'XML', 'xml2', 'xopen', 'xtable', 'xts', 'XVector', 'yaml', 'zeallot', 'zip', 'zlibbioc', 'zoo')
installation_needed <- unlist(lapply(PACKAGES_TOTAL, require, character.only = TRUE, quietly = TRUE))
installation_needed <- PACKAGES_TOTAL[installation_needed == FALSE]
if(length(installation_needed) > 0) {stop(paste("\n\nNot all necessary packages are installed! Run the Installation Executable or contact the author. The following packages are missing:", paste(installation_needed, collapse = ", ")))}

## Load required Packages
require(rmarkdown); require(knitr); require(shiny); require(yaml)

## Set Pandoc
if (pandoc_available(version = NULL, error = FALSE)) {write_yaml(file = "../PATHS.YML", x= data.frame("PANDOC_INSTALLATION_PATH" = Sys.getenv("RSTUDIO_PANDOC")))
} else {paths <- read_yaml("../PATHS.YML");  Sys.setenv(RSTUDIO_PANDOC = paths$PANDOC_INSTALLATION_PATH)}

## Ask User for .fcs files to be concatenated or for an already concatenated file. Based on these files, generate an output folder.
files <- choose.files()#capticon = "Please select one already concatonated .fsc file or multiple .fcs files to be concatonated.") 
if (!all(grepl(pattern = '.fcs$', x = files))) {stop("All selected files must have the \".fsc\" extension!")}
concat <- (length(files)>1)
if (!concat) {
  outputdir <- sub(pattern = '.fcs$', x = files, replacement = "")
} else {outputdir <- paste(dirname(files[1]),"/concatenated_",gsub("\\s+","_",gsub(pattern = ":", replacement = "_", x = date())),sep="")
}
dir.create(outputdir)
message(paste("Output folder will be", outputdir))

## Save variables from this script to be loaded again inside the Rmarkdown Report.
if (!(dir.exists("Scripts"))) {setwd("..")}
save.image(file = "temp.RData")

## Knit the Report! All this needed to be done outside of knitting the report itself in order to be able to move the report to the output folder when finished.
message("\nINSTRUCTIONS: \nYou will now be able to specify parameters for the report in a shiny interface.\nParameters with an asterisk (*) should be correct and should not be touched.")
rmarkdown::render(input = "./Scripts/CyTOF-Titration-Report.Rmd", params = "ask", output_dir = outputdir)
