# 00b_DirectoriesAndFns
# Author: Alan Chalk
# Date: 29 March 2017

# Purpose: Set directory strings for later use.  

# Contents:
#   1. Define directories
#   2. Load functions
#   3. Save session information

# Notes:
#   1.


#--------------------------------------------------------------------------------
#   1.  Define directories 

# Assumed using RStudio project in the root to rawdata etc.
dirRoot <- getwd()

dirRawData <- file.path(dirRoot, 'RawData')
dirRData   <- file.path(dirRoot, 'RData')
dirROutput <- file.path(dirRoot, 'ROutput')
dirRCode   <- file.path(dirRoot, 'RCode')


#--------------------------------------------------------------------------------
#  2. Load functions

# identify all scripts containing functions stored in code directory
functionNames <- list.files(dirRCode,
                            pattern = "^fn")
functionPaths <- paste(dirRCode, functionNames, sep = "/")

# source functions
sapply(functionPaths, source)
rm(functionNames, functionPaths)


#--------------------------------------------------------------------------------
#  3. Save session information

# Set time zone
Sys.setenv(TZ = "Europe/London")
Sys.getenv("TZ")

fileOut <- paste(c('Rsession_', format(Sys.time(), "%d%b%Y"), '.txt'), sep="", collapse="")
sink(file = file.path(dirROutput, fileOut))
sessionInfo()
sink()

rm(fileOut); gc()


