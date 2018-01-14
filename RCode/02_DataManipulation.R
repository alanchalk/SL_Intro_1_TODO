# 02_ManipulateData.R
# Author: Alan Chalk
# Date: 10 Jan 2018

# Purpose: Carry out any data manipulation needed

# Contents
#  _. Load data
#  1. Add an exposure variable
#  2. Add folds

# Notes


#--------------------------------------------------------------------------------
#  _. Load data

load(file.path(dirRData, '01_tbl_all.RData'))


#--------------------------------------------------------------------------------
#  1. Add an exposure variable

## TODO
# Add an variable called ex to the data.  It should always take the value of 1


# or using dplyr::mutate
tbl_all <- 
  tbl_all %>%
  


#--------------------------------------------------------------------------------
#  2. Add folds

set.seed(2018)

# Note: The function sample() creates random draws, with or without replacement
#       for example:
sample(x = 1:1000, size = 10, replace = FALSE)

## TODO 
# Create a variable called n_examples, which contains the number of examples
# in our dataset
# Note: Consider the output of dim(tbl_all)
n_examples <- 

## TODO 
# Add a variable called fold to the data, it should take values 1- 10
# fold should be sampled from the numbers 1:10

fold <- 
hist(fold)

tbl_all$fold <- 

rm(fold, n_examples)


#--------------------------------------------------------------------------------
# End.  Save data.  rm.  gc

save(tbl_all,
     file = file.path(dirRData, '02_tbl_all.RData'))
rm(tbl_all); gc()

