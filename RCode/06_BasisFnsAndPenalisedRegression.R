# 06_BasisFnsAndPenalisedRegression.R
# Author: Alan Chalk
# Date: 12 Jan 2018 
# Copyright 2018, Alan Chalk, All rights reserved.

# Purpose: 

# Contents:
#   Start_.  (Keep tbl_all from previous session)
#            Summarise data by pa
#   1. glm: Straight line
#   2. Introducing linear basis functions
#   3. glm: One linear basis function
#   4. glm: Two linear basis functions
#   5. glm: Many linear basis functions
#   6. Introducing penalised regression
#   7. Generalised additive models

# Notes:
#   1.  


#--------------------------------------------------------------------------------
#  Start_.  (Keep tbl_all from previous session)
#            Summarise data by pa

tbl_ageFreq <- 
  tbl_all %>%
  group_by(pa) %>%
  summarise(actual = mean(nucl))


#-----------------------------------------------------------------------
#  1. glm_1: straight line

## TODO 
# Using the glm() function, fit a model with formula nucl ~ pa,
# family = poisson to the training data only
glm_1 <- glm(nucl ~ , 
             family = ,
             data = )

## TODO
# Run the code below to see a summary of the model and graph of the 
# predictions
# 1. Do you see what you expect to see?
# 2. Is the result different from the linear model?
summary(glm_1)
tbl_ageFreq$pred <- predict(glm_1, newdata = tbl_ageFreq, type = "response")

gg_glm_1 <- fn_graph(tbl_ageFreq, title = 'glm: intercept only')
print(gg_glm_1)
rm(gg_glm_1)


#-----------------------------------------------------------------------
#  2. Introducing linear basis functions

# TODO
## Submit the code below to create the function fn_h.
#  What would the output be if the hinge (p) is at 35 and the input 
#  is c(20, 35, 55).  Run the function with these inputs and check that
#  the output is as expected
fn_h <- function(x, p){
  # p is the hinge point and should be numeric
  # x is the input and can be a vector
  pmax(0, x - p)  
}

fn_h(c(20, 35, 55), 35)

## TODO
#  Create a new variable called pa_2 on both tbl_all and on tbl_ageFreq
#  which is a linear spline function based on pa with a knot at 35.
#  Inspect the output to make sure it is correct.
tbl_all <- 
  tbl_all %>%
  mutate()

tbl_ageFreq <- 
  tbl_ageFreq %>%
  mutate()

tbl_ageFreq %>%
  select(pa, pa_2) %>%
  print(n = Inf)

ggplot(data = tbl_ageFreq) +
  geom_line(aes(x = pa, y = pa, col = "age"), lwd = 1.1) +
  geom_line(aes(x = pa, y = pa_2, col="fn_h(., 35)"), lwd=1.1) +
  geom_point(aes(x = pa, y = actual, col="Actual")) +
  ylab('') +
  theme_gray(base_size = 20) +
  theme(legend.title = element_blank(), legend.position = "top")

## TODO
#  1. Note how the graph immediately below combines and intercept 
#     and the pa feature to create a downward sloping line.
#  2. In the second graph below, choose an intercept and coefficients 
#     for pa and pa_2 so that the line drawn fits the data better.
ggplot(data = tbl_ageFreq) +
  geom_line(aes(x = pa, y = 0.425 - pa / 100), lwd = 1.1) +
  geom_point(aes(x = pa, y = actual, col="Actual")) +
  ylab('') +
  theme_gray(base_size = 20) +
  theme(legend.title = element_blank(), legend.position = "top")

ggplot(data = tbl_ageFreq) +
  geom_line(aes(x = pa, y = 0.425 - ? * pa  + ? * pa_2), lwd = 1.1) +
  geom_point(aes(x = pa, y = actual, col="Actual")) +
  ylab('') + ylim(c(0.025, 0.275)) + 
  theme_gray(base_size = 20) +
  theme(legend.title = element_blank(), legend.position = "top")


#-----------------------------------------------------------------------
#  3. glm: One linear basis function

## TODO
# Use glm() to fit model where nucl depends on pa and the linear spline
# we created above,
glm_2 <- glm(nucl ~ , 
             family = poisson,
             data = tbl_all[idx_train,])

summary(glm_2)
tbl_ageFreq$pred <- predict(glm_2, newdata = tbl_ageFreq, type = "response")
gg_glm_2 <- fn_graph(tbl_ageFreq, 'glm: 2 splines')
print(gg_glm_2)


#-----------------------------------------------------------------------
#  4. glm: Two linear basis functions

## TODO
# Create a new linear spline, pa_3, on both tbl_all and tbl_ageFreq,
# where the knot is at pa = 20








ggplot(data = tbl_ageFreq) +
  geom_line(aes(x = pa, y = pa, col = "age"), lwd = 1.1) +
  geom_line(aes(x = pa, y = pa_2, col="fn_h(., 35)"), lwd=1.1) +
  geom_line(aes(x = pa, y = pa_3, col="fn_h(., 20)"), lwd=1.1) +
  ylab('') +
  theme_gray(base_size = 20) +
  theme(legend.title = element_blank(), legend.position = "top")

## TODO
# Fit a glm to pa and the 2 linear splines
glm_3 <- glm(nucl ~ , 
             family = poisson,
             data = tbl_all)

summary(glm_3)
tbl_ageFreq$pred <- predict(glm_3, newdata = tbl_ageFreq, type = "response")
gg_glm_3 <- fn_graph(tbl_ageFreq, 'glm: 3 splines')
print(gg_glm_3)


#-----------------------------------------------------------------------
#   5. glm: Many linear basis functions

## TODO
# Inspect the code below, can you see how it is creating many linear 
# splines and adding them to tbl_all and tbl_ageFreq.
# Inspect the formula fmla_4 - which terms does it contain?
f_ <- as.matrix(sapply(seq(20,68, by = 2), 
                       function(x) fn_h(tbl_all$pa, x))
                )
colnames(f_) <- paste0("h_", seq(20, 68, by = 2))
tbl_all <- cbind(tbl_all, f_)

f_ <- as.matrix(sapply(seq(20, 68, by = 2), 
                       function(x) fn_h(tbl_ageFreq$pa, x))
                )
colnames(f_) <- paste0("h_", seq(20, 68, by = 2))
tbl_ageFreq <- cbind(tbl_ageFreq, f_)

fmla_4 <- as.formula(paste0('nucl ~ ', 
                            paste(colnames(f_), sep = " ", collapse = "+")))

## TODO 
# Use the formula fmla_4, created above, to fit a glm to all the splines
glm_4 <- glm(, 
             family = poisson,
             data = tbl_all[idx_train,])

summary(glm_4)

tbl_ageFreq$pred <- predict(glm_4, newdata = tbl_ageFreq, type = "response")
gg_glm_4 <- fn_graph(tbl_ageFreq, 'glm: Many splines')
print(gg_glm_4)

rm(f_)

## TODO 
# Discuss:
# 1. Why does the fitted model not go through every point?
# 2. Is it a good model?


#-----------------------------------------------------------------------
#  6. Introducing penalised regression

f_all <- cbind(tbl_all$pa, f_all)
class(f_all)
head(f_all)
f_ageFreq <- cbind(tbl_ageFreq$pa, f_ageFreq)

## TODO
# Fit a penalised regression glmnet() model with no penalisation
# (lambda = 0).
# Comment on the result - is it similar to the previous glm?
glmnet_1 <- glmnet::glmnet(x = f_all[idx_train,], 
                           y = tbl_all$nucl[idx_train], 
                           family = "poisson", 
                           lambda = )
tbl_ageFreq$pred <- predict(glmnet_1, 
                            newx = f_ageFreq, 
                            type = "response")

gg_glmnet_1 <- fn_graph(tbl_ageFreq, 'glmnet: Many splines, lambda = 0')
print(gg_glmnet_1)

## TODO
# Fit a penalised regression glmnet() model with lambda = 100
# Comment on the result.
glmnet_2 <- glmnet::glmnet(x = f_all[idx_train,], 
                           y = tbl_all$nucl[idx_train], 
                           family = "poisson", 
                           lambda = )
tbl_ageFreq$pred <- predict(glmnet_2, 
                            newx = f_ageFreq, 
                            type = "response")

gg_glmnet_2 <- fn_graph(tbl_ageFreq, 'glmnet: Many splines, lambda = 100')
print(gg_glmnet_2)

## TODO
# Fit a penalised regression glmnet() model with lambda = .0001
# Comment on the result.
glmnet_3 <- glmnet::glmnet(x = f_all[idx_train,], 
                           y = tbl_all$nucl[idx_train], 
                           family = "poisson", 
                           lambda = )
print(glmnet_3$beta)
tbl_ageFreq$pred <- predict(glmnet_3, 
                            newx = f_ageFreq, 
                            type = "response")

gg_glmnet_3 <- fn_graph(tbl_ageFreq, 'glmnet: Many splines, lambda = 0.01')
print(gg_glmnet_3)


#-----------------------------------------------------------------------
#  6. Penalised regression with lambda chosen by cross validation

## TODO
# Run the code below and comment on the results.
# Note that the code takes a few minutes to run.
glmnet_4 <- glmnet::cv.glmnet(x = f_all[idx_train,], 
                              y = tbl_all$nucl[idx_train], 
                              family = "poisson"
                              )
plot(glmnet_4)

idx_ <- which(glmnet_4$lambda ==  glmnet_4$lambda.min)
as.matrix(glmnet_4$glmnet.fit$beta[, idx_])

tbl_ageFreq$pred <- predict(glmnet_4, 
                            newx = f_ageFreq, 
                            type = "response")

gg_glmnet_4 <- fn_graph(tbl_ageFreq, 'glmnet: Many splines, CV')
print(gg_glmnet_3)


#-----------------------------------------------------------------------
#  7. Generalised additive models

gam_1 <- mgcv::bam(nucl ~ s(pa, bs = "cs", k = 5),
             data = tbl_all[idx_train,],
             family = poisson(link = "log"))

tbl_ageFreq$pred <- predict(gam_1, 
                            newdata = tbl_ageFreq,
                            type = "response")

gg_gam_1 <- fn_graph(tbl_ageFreq, 'GAM: cubic splines')
print(gg_gam_1)



