# 03_EDA.R
# Author: Alan Chalk
# Date: 10 Jan 2018

# Purpose: Basic EDA

# Contents
#  -. Load data
#  1. Inspect a few lines of data
#  2. Summarise each variable
#  3. Histograms and plots
#  4. Remove data, gc.

# Notes


#--------------------------------------------------------------------------------
#  _. Load data

load(file = file.path(dirRData, '02_tbl_all.RData'))


#--------------------------------------------------------------------------------
#  1. Inspect a few lines of data

## TODO 
# Inspect the top 5 records and bottom 5 records of the data using
# head() and tail()




#--------------------------------------------------------------------------------
#  2. Summarise each variable

## TODO
# Use the summary() function to summarise the data.
# Does the result tell you anything you did not already know?



#--------------------------------------------------------------------------------
#  3. Histograms and plots

## TODO
# Use the hist() function to create a histogram of policyholder age (pa)
# Histogram of driver age 
hist()
hist(, breaks = 100)

## TODO
# Run the code below to summarise the number of drivers and claims
# by age and to plot the result.
# Is the result useful?
tbl_summary <- 
  tbl_all %>%
  group_by(pa) %>%
  summarize(numberOfDrivers = n(),
            nucl = sum(nucl)) %>%
  print(n = Inf)

plot(tbl_summary$pa, tbl_summary$nucl)

## TODO
# The number of claims at each age is not a useful statistic for us.
# We need the frequency of claims by age.
# Copy the above code and change it so that a variable called actual is created
# This should be the claims frequency for each age
tbl_summary <- 
  
  
  

## TODO 
# 1. Run the code below to plot frequency of claims by age.
# 2. Does the shape of this graph make sense to you?
# 3. Given what you see, can you decide what you expect the output to be?
ggplot(data = tbl_summary, mapping = aes(x = pa, y = actual)) +
  geom_point() + 
  xlab('Age') + ylab('Frequency') + ggtitle('Actual claims frequency by age')


#--------------------------------------------------------------------------------
# End. Remove data. gc.

rm(tbl_all, tbl_summary); gc()
