# fn_performance.R

# Cross entropy
fn_CE <- function(actuals, preds, eps = 1e-10){
  idx_actuals0 <- (actuals == 0)
  idx_actuals1 <- (actuals == 1)
  n_examples <- length(preds)
  preds <- pmax(eps, (pmin(preds, 1 - eps)))
  CE <- 1 / n_examples * ( - sum(log(preds[idx_actuals1])) - sum(log(1-preds[idx_actuals0])))
  CE
}
