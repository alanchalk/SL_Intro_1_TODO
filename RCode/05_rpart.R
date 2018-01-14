# 05_rpart.R
# Author: Alan Chalk
# Date: 11 Jan 2018
# Copyright 2018, Alan Chalk, All rights reserved.

# Purpose: rpart tree on frequency data

# Contents:
#  Start_. (Keep tbl_all from previous session)
#  1. A simple decision tree
#  2. A complex decision tree
#  3. Pruning decision trees
#  4. Performance measurement


# Notes:
#   1. 


#--------------------------------------------------------------------------------
# Start_.  (Keep tbl_all from previous session)


#--------------------------------------------------------------------------------
# 1. A simple decision tree

## TODO
# Run the code below, which creates a decision tree of maxdepth 1
# Is the output useful?
rpart_1 <- rpart::rpart(nucl ~ pa,
                        data = tbl_all,
                        method = "anova",
                        maxdepth = 1)

rpart.plot::rpart.plot(rpart_1)

## TODO
# The reason we did not a good result was due to the cp parameter
# Run the model again with cp = 1e-4
# Does the result make sense?
rpart_2 <- rpart::rpart(nucl ~ ,
                        data = ,
                        method = ,
                        maxdepth = ,
                        cp = )

rpart.plot::rpart.plot()

## TODO 
# Create predictions and store the results in a variable called 
# rpart_2_pred in the tbl_all dataframe
tbl_all$rpart_2_pred <- predict(rpart_2)

## TODO
# 1. Run the code below
# 2. Are the predictions correct are average?
# 3. Can you explain the shape of the resulting graph?
mean(tbl_all$nucl)
mean(tbl_all$rpart_2_pred)

tbl_summary <- 
  tbl_all %>%
  group_by(pa) %>%
  summarize(actual = mean(nucl),
            pred = mean(rpart_2_pred))
gg_rpart_2 <- fn_graph(tbl_summary, title = 'rpart model')
print(gg_rpart_2)

rm(rpart_1, rpart_2, gg_rpart_2)

## TODO
# The result consists of 2 flat lines.  Does this "feel" right?


#--------------------------------------------------------------------------------
# 2. A complex decision tree

## TODO
# Copy the code from rpart_2 above, but change the maxdepth to 30 and 
# cp to 1e-10
# Open the resulting pdf - what is the tree actualy doing?
rpart_3 <- rpart::rpart(nucl ~ ,
                        data = ,
                        method = ,
                        maxdepth = ,
                        cp = )

pdf(file.path(dirROutput, '05_rpart_3.pdf'))
rpart.plot::rpart.plot(rpart_3)
dev.off()

## TODO 
# Run the code below to create and graph the predictions.
# Discuss: Is this a good model?
tbl_all$rpart_3_pred <- predict(rpart_3)

mean(tbl_all$nucl)
mean(tbl_all$rpart_3_pred)

tbl_summary <- 
  tbl_all %>%
  group_by(pa) %>%
  summarize(actual = mean(nucl),
            pred = mean(rpart_3_pred))
gg_rpart_3 <- fn_graph(tbl_summary, title = 'rpart model')
print(gg_rpart_3)
rm(gg_rpart_3)


#--------------------------------------------------------------------------------
# 3. Pruning decision trees

# TODO
# Run the code below to produce train and (cross) validation curves.
# Is the CV curve the expected shape?
tbl_tree_results <- as_data_frame(rpart_3$cptable)
colnames(tbl_tree_results)[3] <- 'trainError'
colnames(tbl_tree_results)[4] <- 'cvError'

ggplot(data = tbl_tree_results, aes(x = nsplit)) +
  geom_line(aes(y = trainError, color = 'Train')) +
  geom_line(aes(y = cvError,   color = 'CV')) +
  ylab('Error') +
  xlab('Increasing Model Complexity') + 
  theme_grey(base_size = 16) + 
  theme(legend.title = element_blank(), legend.position="top")

# TODO
# 1. Find which cp gives the minimum cross validation error.
# 2. Should we use a tree of this complexity? 
which.min()
cp_toUse <- tbl_tree_results$CP[]

# However we will use something slightly simpler (nsplit33)
cp_toUse <- tbl_tree_results$CP[which(tbl_tree_results$nsplit == 33)]

## TODO
# Use rpart::prune to prune the model
# Then run the rest of the code.
# Discuss: Is this model better than the previous one?
rpart_best <- 

tbl_all$rpart_best_pred <- predict(rpart_best)

mean(tbl_all$nucl)
mean(tbl_all$rpart_best_pred)

tbl_summary <- 
  tbl_all %>%
  group_by(pa) %>%
  summarize(actual = mean(nucl),
            pred = mean(rpart_best_pred))
gg_rpart_best <- fn_graph(tbl_summary, title = 'rpart model')
print(gg_rpart_best)

## TODO 
# Discuss:
# How is this model different to the previous model?
# Is this a good model?


rm(rpart_3, rpart_best, tbl_tree_results, tbl_summary, cp_toUse, gg_rpart_best)


#--------------------------------------------------------------------------------
# 4. Performance measurement

## TODO
# Go back to 02_DataManipulation and add a variable called fold to the 
# dataset.  There should be 10 folds.

## TODO
# 1. Create two variables folds_train and folds_val.  They should take the
#    values of 1-7 and 8-10 respectively.



# 2. Create two variables, n_train and n_val which are the number of 
#    examples in the training and validation folds respectively



# 3. Create two variables idx_train and idx_val which are an index of
#    the row numbers of the train and validation examples respectively
idx_train <- which(tbl_all$fold %in% folds_train)
idx_val <- which(tbl_all$fold %in% folds_val)

## TODO
# Find the intercept of an intercept only model on the training folds and 
# store it in a variable called m0 (this is our null model)
m0 <- 

## TODO
# What is the CE of an intercept only model (on the validation folds).
fn_CE(actuals = , 
      preds = rep(m0, n_val))

## TODO
# Run the code below to create a (pruned) rpart model based on 
# the train folds only
rpart_3 <- rpart::rpart(nucl ~ pa,
                        data = tbl_all[idx_train,],
                        method = "anova",
                        maxdepth = 30,
                        cp = 1e-10)

tbl_tree_results <- as_data_frame(rpart_3$cptable)
colnames(tbl_tree_results)[3] <- 'trainError'
colnames(tbl_tree_results)[4] <- 'cvError'

ggplot(data = tbl_tree_results, aes(x = nsplit)) +
  geom_line(aes(y = trainError, color = 'Train')) +
  geom_line(aes(y = cvError,   color = 'CV')) +
  ylab('Error') +
  xlab('Increasing Model Complexity') + 
  theme_grey(base_size = 16) + 
  theme(legend.title = element_blank(), legend.position="top")

which.min(tbl_tree_results$cvError)
cp_toUse <- tbl_tree_results$CP[which.min(tbl_tree_results$cvError)]
rpart_best <- rpart::prune(rpart_3, cp_toUse)

## TODO
# Find the CE of this model on the validation data
rpart_best_pred <- 
fn_CE(actuals = tbl_all$nucl[idx_val], 
      preds = )

## TODO
# Discuss: Is this model better than the intercept only model?


