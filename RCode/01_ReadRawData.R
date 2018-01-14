# 01_ReadRawData.R
# Author: Alan Chalk
# Date: 14 Jan 2018

# Purpose: Read any raw data files

# Contents
#  1. Read insSim_1 dataset
#  End.  Save data.  rm.  gc

# Notes


#--------------------------------------------------------------------------------
# 1. Read insSim_1 dataset

# create the file path to the data

fpath <- file.path(dirRawData, 'insSim_1.csv')
  
## TODO
# Use read_csv() to read the data into a file called tbl_all
# What class is tbl_all?  Is it a dataframe?
tbl_all <- 
class()

# Look at the data
head(tbl_all)


#--------------------------------------------------------------------------------
# End.  Save data.  rm.  gc

save(tbl_all,
     file = file.path(dirRData, '01_tbl_all.RData'))
rm(tbl_all); gc()




