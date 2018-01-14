# 04_LinearModel.R
# Author: Alan Chalk
# Date: 10 Jan 2018
# Copyright 2018, Alan Chalk, All rights reserved.

# Purpose: Linear model on claims frequency data

# Contents
#  Start_. Load data
#  1. Fit linear model
#  2. Inspect model
#  3. Create predictions
#  4. Inspect predictions
#  End_.  Tidy up

# Notes


#--------------------------------------------------------------------------------
#  Start_. Load data

load(file = file.path(dirRData, '02_tbl_all.RData'))


#--------------------------------------------------------------------------------
# 1. Fit linear model

## TODO
# Using the lm() function fit a linear model to the data.
# The formula should have nucl depending on pa only.  Use the tbl_all data
lm_1 <- 

## TODO 
# 1. Run the code below to find the class of the lm_1 object and to see
#    which R functions have methods for this class
# 2  Look at the help for summary.lm and predict.lm to see what the 
#    summary and predict functions return for the lm class.
class(lm_1)
methods(class = class(lm_1))




#--------------------------------------------------------------------------------
# 2. Inspect model

## TODO
# Inspect the model coefficients using the summary() function.
# Do the results make sense?



#--------------------------------------------------------------------------------
# 3. Create predictions 

## TODO 
# Use the predict() generic function on the lm_1 object to create predictions
# and store the results in a variable called lm_1_pred in the tbl_all dataframe



#--------------------------------------------------------------------------------
#  4. Inspect predictions

# TODO
# 1. Run the code below to inspect the predictions.
# 2. On average, are the predictions correct?
# 3. Is this a good model?
head(tbl_all)

mean(tbl_all$nucl)
mean(tbl_all$lm_1_pred)

tbl_summary <- 
  tbl_all %>%
  group_by(pa) %>%
  summarize(actual = mean(nucl),
            pred = mean(lm_1_pred))

gg_1 <- fn_graph(tbl_summary, 'Linear model')
print(gg_1)


#--------------------------------------------------------------------------------
# End_.  Tidy up

rm(lm_1, tbl_summary, gg_1)
