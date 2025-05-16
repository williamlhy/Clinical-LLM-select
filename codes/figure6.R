#This plot is only concern about how many subtasks the models can be applied.
#io and io2 difference: best <- count
library(plyr)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(ggpattern)
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
colnames(f2)[10] <- "access"
#We only count the number of subtasks where the model can be applied for
f2$best[which(f2$best!=0)] <- 1
tt <- f2[,c(1,5:10)]
tt <- tt[!duplicated(tt[,c("model","subtask","input1","input2","output")]),]
f4 <- aggregate(best~model+input1+input2+output+access,data=tt,sum)
f4[f4==0] <- NA
f4 <- na.omit(f4)
f4$io <- NA
for (i in seq(1:nrow(f4))){
  f4$io[i] <- paste(f4$input1[i],f4$input2[i],f4$output[i])
}
cols <- c("text  text"= "A","image (2D) text text" = "B","image (2D)+text  text"="C","image (2D)  image (2D)"="D",
          "image (2D)  text"="E","image (3D)+text  image (3D)"="F","image (3D) text text"="G","image (3D)  image (3D)"="H",
          "text time-series text"="I","audio text audio"="J", "text+audio  text"="K","text+ECG  text"="L", "video+text  text"="M")
cols <- tibble::enframe(cols, name = "io", value = "io_abb")
f4 <- left_join(f4, cols, by = "io")
f4$ln_best <- log(f4$best+1)
ff <- f4[,c(1,5,8:9)]
ff <- ff %>% arrange(access, ln_best)
plot_io <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(ff$io_abb)), ncol(ff)) )
  colnames(to_add) <- colnames(ff)
  to_add$io_abb <- rep(levels(as.factor(ff$io_abb)), each=empty_bar)
  to_add$access <- rep(levels(as.factor(ff$access)), each=13)
  ff <- rbind(ff, to_add)
  ff <- ff %>% arrange(io_abb)
  ff$id <- seq(1, nrow(ff))
  # Get the name and the y position of each label
  label_data <- ff
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- ff %>% 
    group_by(io_abb) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- c("open"=1,"api"=0.7,"restricted"=0.4)
  #ln_best is in 1:4 io_abb:1,2
  p1 <- ggplot(ff, aes(x=as.factor(id), y=ln_best,pattern=access)) +       #, fill=io_abb Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar_pattern(aes(x=as.factor(id),y=ln_best,fill=io_abb), stat="identity", pattern_fill = "black", colour = "black", pattern_spacing = 0.0075,
                     pattern_frequency = 5, pattern_angle = 45)+ #,fill="white"
    #specific colors
    scale_fill_manual(values = c("white","white","white","white","white","white","white","white","white","white","white","white","white"),name="Input - output combination\nfirst input | second input | output"
                      ,labels=c("A. text | - | text", "B. image (2D) | text | text","C. image (2D)+text | - | text","D. image (2D) | - | image (2D)",
                                "E. image (2D) | - | text", "F. image (3D)+text | - | image (3D)","G. image (3D) | text | text","H. image (3D) | - | image (3D)",
                                "I. text | time-series | text","J. audio | text | audio","K. audio+text | - | text",
                                "L. ECG+text | - | text", "M. video+text | - | text"))+ 
    #scale_alpha_manual(values = alpha_vector ,breaks=c("open","api","restricted")) +
    scale_pattern_manual(values = c("open" = "none", "api" = "stripe", "restricted" = "circle"))+
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(ff$id),4), y = c(1, 2, 3,4), label = c("1", "2", "3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    ylim(-5.5,4.5) +
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
    geom_text(data=label_data, aes(x=id, y=ln_best+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.5, label=io_abb), hjust=c(1,0,0,0,0,0,0,0,0,0,0,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  #p1 <- gridExtra::grid.arrange(p1, bottom="Modalities")
  return(p1)
}
p_io <- plot_io()

ff$id <- seq(1, nrow(ff))
p9 <- ggplot(ff, aes(x=as.factor(id), y=ln_best)) +       #, fill=io_abb Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar(aes(x=as.factor(id),y=ln_best,fill=io_abb), stat="identity") +
  #specific colors
  scale_fill_manual(values = c("black","black","black","black","black","black","black","black","black","black","black","black","black"),name="Input - output combination\nfirst input | second input | output"
                    ,labels=c("A. text | - | text", "B. image (2D) | text | text","C. image (2D)+text | - | text","D. image (2D) | - | image (2D)",
                              "E. image (2D) | - | text", "F. image (3D)+text | - | image (3D)","G. image (3D) | text | text","H. image (3D) | - | image (3D)",
                              "I. text | time-series | text","J. audio | text | audio","K. audio+text | - | text",
                              "L. ECG+text | - | text", "M. video+text | - | text"))+
  theme(legend.key.size = unit(0.6, 'cm'), #change legend key size
        legend.key.height = unit(0.6, 'cm'), #change legend key height
        legend.key.width = unit(0, 'cm'), #change legend key width
        legend.title = element_text(size=12), #change legend title font size
        legend.text = element_text(size=8))
p9
p10 <- ggplot(ff, aes(x=as.factor(id), y=ln_best,pattern=access)) +       #, fill=io_abb Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar_pattern(aes(x=as.factor(id),y=ln_best), stat="identity", pattern_fill = "black",
                   fill = "white", colour = "black", pattern_spacing = 0.02,
                   pattern_frequency = 5, pattern_angle = 45) +
  scale_pattern_manual(values = c("open" = "none", "api" = "stripe", "restricted" = "circle"))

leg <-  ggpubr::get_legend(p9)
legend <- as_ggplot(leg)
leg2 <-  ggpubr::get_legend(p10)
legend2 <- as_ggplot(leg2)

plots <- cowplot::ggdraw() +
  cowplot::draw_plot(p_io, x = 0.07, y = 0, width = 0.5, height = 1,scale=1.4) + 
  cowplot::draw_plot(legend2, x = 0.501, y = .6, width = .4, height = .3,scale=1) + 
  cowplot::draw_plot(legend, x = 0.521, y = 0.2, width = 0.5, height = 0.3,scale=1)
#plots <- gridExtra::grid.arrange(p_io, gridExtra::arrangeGrob(legend, legend2), ncol = 2)
mycolumn <- 2
myh <- mycolumn+4.5
myw <- mycolumn*5
ggsave(plot=plots, file="plots/figure6.pdf", width = myw, height = myh)
ggsave(plot=plots, file="plots/figure6.png", width = myw, height = myh, bg = "white")
