# 00a_Packages.R
# Author: Alan Chalk
# Date: 12 January 2018

# Purpose: Install and / or load libraries

# Contents:
#  1. Clear all working variables and most packages
#  2. If needed, install pacakges
#  3. Load packages

# Notes:
#  1.

#--------------------------------------------------------------------------------
#  1.  Clear all working variables and most packages
#       Source:

pkgs = names(sessionInfo()$otherPkgs)
if (!is.null(pkgs)){
    pkgs = paste('package:', pkgs, sep = "")
    lapply(pkgs, detach, character.only = TRUE, unload = TRUE, force = TRUE)
}
rm(list = ls(all = TRUE))


#--------------------------------------------------------------------------------
#  2.  If needed, install pacakges

# data manipulation
packagesToInstall <- c('tidyverse', 'data.table')
sapply(packagesToInstall, install.packages)

# graphs
packagesToInstall <- c('ggplot2')
sapply(packagesToInstall, install.packages)

# decision trees
packagesToInstall <- c('rpart', 'rpart.plot')
sapply(packagesToInstall, install.packages)

# penalised regression and gams
packagesToInstall <- c('glmnet', 'mgcv')
sapply(packagesToInstall, install.packages)

rm(packagesToInstall)


#--------------------------------------------------------------------------------
#  3.  Load packages

packagesToLoad <- c('tidyverse',
                    'data.table',
                    'ggplot2'
                    )
sapply(packagesToLoad, require, character.only = TRUE, quietly = TRUE)
rm(packagesToLoad)




