# fn_SLIntro_1_freqGraphs.R
# Author: Alan Chalk
# Date: 16 December 2016

# Purpose: Create a ggplot specifically for the models in SL_Intro_1

#---------------------------------------------------------------------
# fn_SLIntro_1_freqGraphs

fn_graph <- function(tbl_, title='', base_size = 20){
  gg_1 <- ggplot(data = tbl_, aes(x = pa)) + 
    geom_point(aes(y = actual, col = 'actual')) + 
    geom_line(aes(y = pred, col = 'predictions')) + 
    ylim(c(0, 0.275)) + 
    ylab('Claim frequency') + xlab('Policyholder age') + 
    theme_gray(base_size = 20) +
    theme(legend.title = element_blank(), legend.position = "top") + 
    ggtitle(title)
  
}
