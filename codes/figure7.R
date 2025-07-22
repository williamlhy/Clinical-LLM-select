#get labels (single or multi) for models
library(ggpattern)
library(plyr)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(dplyr)
f22 <- data[,c(1:9,26)]
t <- data.frame(paste(f22$model,f22$submodel,sep="-"))
nam <- data.frame(matrix(NA, nrow(f22), 1))
for (i in seq(1:nrow(t))){
  a <- t[i,1]
  if (substring(a,nchar(a), nchar(a))=="-")
    nam[i,1] <- substring(a,1, nchar(a)-1)
  else
    nam[i,1] <- a
}
colnames(nam) <- "model"
f22$model <- nam$model
#combine the same model name and also the same subtask but different input-output
f22$appear <- as.numeric(f22$appear)
label <- aggregate(appear~model+input1+input2+output+access,data=f22,sum)
#delete appear=0
label[label==0] <- NA
label <- na.omit(label)
label$io <- NA
for (i in seq(1:nrow(label))){
  label$io[i] <- paste(label$input1[i],label$input2[i],label$output[i])
}
label$modal <- NA
for (i in seq(1:nrow(label))){
  if (label$io[i]=="text  text")
    label$modal[i] <- 0
  else
    label$modal[i] <- 1
}
label <- aggregate(modal~model+access,data=label,sum)
label$modal[which(label$modal!=0)] <- "Multi"
label$modal[which(label$modal==0)] <- "Single"

#We only count the number of subtasks where the model can be applied for
f2 <- data[,c(1:8,10)]
t <- data.frame(paste(f2$model,f2$submodel,sep="-"))
nam <- data.frame(matrix(NA, nrow(f2), 1))
for (i in seq(1:nrow(t))){
  a <- t[i,1]
  if (substring(a,nchar(a), nchar(a))=="-")
    nam[i,1] <- substring(a,1, nchar(a)-1)
  else
    nam[i,1] <- a
}
colnames(nam) <- "model"
f2$model <- nam$model
#combine the same model name and also the same subtask but different input-output
f2$best <- as.numeric(f2$best)
f2 <- cbind(f2,data$access)
colnames(f2)[10] <- "Access"
f2$best[which(f2$best!=0)] <- 1
tt <- f2[,c(1,5:10)]
tt <- tt[!duplicated(tt[,c("model","subtask","input1","input2","output")]),]
f4 <- aggregate(best~model+input1+input2+output+Access,data=tt,sum)
f4[f4==0] <- NA
f4 <- na.omit(f4)
f4$io <- NA
for (i in seq(1:nrow(f4))){
  f4$io[i] <- paste(f4$input1[i],f4$input2[i],f4$output[i])
}
f4 <- aggregate(best~model+Access,data=f4,sum)

#map label to f4
f4$modal <- NA
for (i in seq(1:nrow(f4))){
  for (j in seq(1:nrow(label))){
    if (f4$model[i]==label$model[j])
      f4$modal[i]=label$modal[j]
  }
}

f4$ln_best <- log(f4$best+1)
ff <- f4[,-3]
ff <- ff %>% arrange(Access, ln_best)
plot_io <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(ff$modal)), ncol(ff)) )
  colnames(to_add) <- colnames(ff)
  to_add$modal <- rep(levels(as.factor(ff$modal)), each=empty_bar)
  to_add$Access <- rep(levels(as.factor(ff$Access)), each=2)
  ff <- rbind(ff, to_add)
  ff <- ff %>% arrange(modal)
  ff$id <- seq(1, nrow(ff))
  # Get the name and the y position of each label
  label_data <- ff
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- ff %>% 
    group_by(modal) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- c("Open"=1,"API"=0.7,"Restricted"=0.4)
  #ln_best is in 1:4 modal:1,2
  p1 <- ggplot(ff, aes(x=as.factor(id), y=ln_best,pattern=Access)) +       #, fill=modal Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar_pattern(aes(x=as.factor(id),y=ln_best,fill=modal), stat="identity", pattern_fill = "black", colour = "black", pattern_spacing = 0.0075,
                     pattern_frequency = 5, pattern_angle = 45)+ #,fill="white"
    #specific colors
    scale_fill_manual(values = c("white","white"),name="modal"
                      ,labels=c("Single","Multi"),guide="none")+ 
    #scale_alpha_manual(values = alpha_vector ,breaks=c("Open","API","Restricted")) +
    scale_pattern_manual(values = c("Open" = "none", "API" = "stripe", "Restricted" = "circle"))+
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(ff$id),4), y = c(1, 2, 3,4), label = c("1", "2", "3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    ylim(-4,5.5) +
    theme_minimal() +
    theme(
      #legend.key.size = unit(0.15, "cm"),
      legend.position="none",
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-0.7,4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_best+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=2, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=0.8, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.5, label=modal), hjust=c(1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  #p1 <- gridExtra::grid.arrange(p1, bottom="Modalities")
  return(p1)
}
p_io<- plot_io()
#p_io
ff$id <- seq(1, nrow(ff))
p10 <- ggplot(ff, aes(x=as.factor(id), y=ln_best,pattern=Access)) +       #, fill=modal Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar_pattern(aes(x=as.factor(id),y=ln_best), stat="identity", pattern_fill = "black",
                   fill = "white", colour = "black", pattern_spacing = 0.02,
                   pattern_frequency = 5, pattern_angle = 45) +
  scale_pattern_manual(values = c("Open" = "none", "API" = "stripe", "Restricted" = "circle"))

leg2 <-  ggpubr::get_legend(p10)
legend2 <- as_ggplot(leg2)

#plots <- cowplot::plot_grid(p_io, legend2, ncol = 2, rel_widths = c(1, .001))
plots <- cowplot::ggdraw() +
  cowplot::draw_plot(p_io, x = 0, y = 0, width = 0.93, height = 1,scale=1.3) + 
  cowplot::draw_plot(legend2, x = 0.87, y = .35, width = .1, height = .35,scale=1)

#plots <- gridExtra::grid.arrange(p_io, gridExtra::arrangeGrob(legend, legend2), ncol = 2)
ggsave(plot=plots, file="plots3/fig3_io3.pdf", width = 8.5, height = 6.5)
ggsave(plot=plots, file="plots3/fig3_io3.png", width = 8.5, height = 6.5, bg = "white")
