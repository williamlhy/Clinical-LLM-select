#Data pre-processing
library(plyr)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(dplyr)
f1 <- data[,1:9]
f1$appear <- as.numeric(f1$appear)
f4 <- aggregate(appear~model+stage+task+subtask,data=f1,sum)
#delete appear=0
f4[f4==0] <- NA
f4 <- na.omit(f4)

f4 <- f4[order(f4$stage),]
f4_sub <- aggregate(appear~stage+subtask,data=f4,sum)
f4_sub <- f4_sub[order(f4_sub$stage),]
f4_sub$seq <- NA
stage_num <- aggregate(appear~stage,data=f4,sum)[,-2]
b <- 1
for (i in seq(1:length(stage_num))){
  a <- seq(1:length(which(f4_sub$stage==stage_num[i])))
  f4_sub$seq[b:(b+length(a)-1)] <- a
  b <- b+length(a)
}
f4_sub$tran <- NA
#stage1 1
f4_sub[1,5] <- 1
#stage2 16
f4_sub[2:5,5] <- 1-(f4_sub$seq[2:5]-1)*0.2
f4_sub[6:9,5] <- 1-(f4_sub$seq[6:9]-5)*0.2
f4_sub[10:13,5] <- 1-(f4_sub$seq[10:13]-9)*0.2
f4_sub[14:17,5] <- 1-(f4_sub$seq[14:17]-13)*0.2
#stage3 13
f4_sub[18:21,5] <- 1-(f4_sub$seq[18:21]-1)*0.2
f4_sub[22:25,5] <- 1-(f4_sub$seq[22:25]-5)*0.2
f4_sub[26:30,5] <- 1-(f4_sub$seq[26:30]-9)*0.2
#stage4 16
f4_sub[31:34,5] <- 1-(f4_sub$seq[31:34]-1)*0.2
f4_sub[35:38,5] <- 1-(f4_sub$seq[35:38]-5)*0.2
f4_sub[39:42,5] <- 1-(f4_sub$seq[39:42]-9)*0.2
f4_sub[43:46,5] <- 1-(f4_sub$seq[43:46]-13)*0.2
#stage5 10
f4_sub[47:51,5] <- 1-(f4_sub$seq[47:51]-1)*0.2
f4_sub[52:56,5] <- 1-(f4_sub$seq[52:56]-6)*0.2

f4_sub$stage2[1] <- "1"
f4_sub$stage2[2:5] <- "2_1"
f4_sub$stage2[6:9] <- "2_2"
f4_sub$stage2[10:13] <- "2_3"
f4_sub$stage2[14:17] <- "2_4"
f4_sub$stage2[18:21] <- "3_1"
f4_sub$stage2[22:25] <- "3_2"
f4_sub$stage2[26:30] <- "3_3"
f4_sub$stage2[31:34] <- "4_1"
f4_sub$stage2[35:38] <- "4_2"
f4_sub$stage2[39:42] <- "4_3"
f4_sub$stage2[43:46] <- "4_4"
f4_sub$stage2[47:51] <- "5_1"
f4_sub$stage2[52:56] <- "5_2"

sty <- f4_sub[,c(1:2,5:6)]
f4$tran <- NA
f4$stage2 <- NA
for (i in seq(1:nrow(f4))){
  for (j in seq(1:nrow(sty))){
    if (f4[i,2]==sty[j,1]&&f4[i,4]==sty[j,2]){
      f4$tran[i]=sty$tran[j]
      f4$stage2[i]=sty$stage2[j]}
  }
}
#"#8B8378FF" "#00008BFF" "#4169E1" "#6495EDFF""#9FB6CDFF""#708090" "#458B74FF" "#556B2FFF""#FFA07A" "#CD9B9BFF"
#cols <- c("1"= "#8B8378FF","2_1" = "#00008BFF","2_2"="#4169E1","2_3"="#6495EDFF",
 #         "2_4"="#9FB6CDFF","3"="#458B74FF","4_1"="#556B2FFF","4_2"="#8B8B00FF","5_1"="#CD853FFF","5_2"="#FFA07A")
cols <- c("1"= "#9932CCFF","2_1" = "#00008BFF","2_2"="blue2","2_3"="#4169E1","2_4"="#00688BFF",
          "3_1"="#2F4F4FFF","3_2"="#006400FF","3_3"="#1CBE4F","4_1"="#556B2FFF","4_2"="#8B8B00FF","4_3"="#EEB422FF","4_4"="#CD853FFF","5_1"="orangered3","5_2"="maroon2")
cols <- tibble::enframe(cols, name = "stage2", value = "fill")
#f4$stage <- as.character(f4$stage)
f4 <- left_join(f4, cols, by = "stage2")
f4$fill_alpha <- NA
for (i in seq(1:nrow(f4))){
  f4$fill_alpha[i] <- colorspace::adjust_transparency(f4$fill[i], f4$tran[i])
}
f4$subtask_abb <- NA
f4_sub$subtask_abb <- NA
for (i in seq(1:nrow(f4_sub))){
  f4_sub$subtask_abb[i] <- paste(f4_sub$stage[i],"_",as.character(f4_sub$seq[i]))
}
for (i in seq(1:nrow(f4))){
  for (j in seq(1:nrow(f4_sub))){
    if (f4$stage[i]==f4_sub$stage[j]&&f4$subtask[i]==f4_sub$subtask[j])
      f4$subtask_abb[i]=f4_sub$subtask_abb[j]
  }
}
#each stage has a main color: 1:#FFA07A, 2:#4169E1 3:#207345 4:#708090 5:#F5DEB3

#Task1: Disease diagnosis appear is in 1:4 stage:2,3
s1 <- f4[which(f4$task=="Disease diagnosis"),]
s1 <- s1[,-3]
s1$ln_appear <- log(s1$appear)+1
plot1 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s1$stage)), ncol(s1)) )
  colnames(to_add) <- colnames(s1)
  to_add$stage <- rep(levels(as.factor(s1$stage)), each=empty_bar)
  s1 <- rbind(s1, to_add)
  s1 <- s1 %>% arrange(stage)
  s1$id <- seq(1, nrow(s1))
  # Get the name and the y position of each label
  label_data <- s1
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s1 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- tapply(unique(s1$fill_alpha), unique(s1$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s1$subtask_abb)]
  #appear is in 1:4 stage:1,2
  p1 <- ggplot(s1, aes(x=as.factor(id), y=appear)) +       #, fill=stage Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear,fill=subtask_abb), stat="identity") +
    #specific colors
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s1$subtask_abb))),guide="none") +
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 18, xend = start, yend = 18), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s1$id),4), y = c(1, 2,3,4), label = c("1","2","3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    ylim(-5,5.5) +
    #labs(caption = "Figure 1. GDP Growth Rate") +
    theme_minimal() +
    theme(
      #plot.caption=element_text(colour = "blue", hjust=0.5),
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1.5,4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.3, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.7, label=stage), hjust=c(1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p1 <- gridExtra::grid.arrange(p1, bottom="Disease diagnosis")
  return(p1)
}
p1 <- plot1()
p1
#Task2: Text generation appear is in 1:4 stage:1,2,3,4,5
s2 <- f4[which(f4$task=="Text generation"),]
s2 <- s2[,-3]
s2$ln_appear <- log(s2$appear)+1
plot2 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s2$stage)), ncol(s2)) )
  colnames(to_add) <- colnames(s2)
  to_add$stage <- rep(levels(as.factor(s2$stage)), each=empty_bar)
  s2 <- rbind(s2, to_add)
  s2 <- s2 %>% arrange(stage)
  s2$id <- seq(1, nrow(s2))
  # Get the name and the y position of each label
  label_data <- s2
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s2 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- tapply(unique(s2$fill_alpha), unique(s2$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s2$subtask_abb)]
  #appear is in 1:5 stage:2,3,4,5
  p2 <- ggplot(s2, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s2$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s2$id),4), y = c(1, 2,3,4), label = c("1","2","3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    ylim(-5,5.5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1.5,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.6, label=stage), hjust=c(1,0,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p2 <- gridExtra::grid.arrange(p2, bottom="Text generation")
  return(p2)
}
p2 <- plot2()
p2
#Task3: Text summarization appear is in 1:7 stage:2,3,4
s3 <- f4[which(f4$task=="Text summarization"),]
s3 <- s3[,-3]
s3$ln_appear <- log(s3$appear)+1
plot3 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s3$stage)), ncol(s3)) )
  colnames(to_add) <- colnames(s3)
  to_add$stage <- rep(levels(as.factor(s3$stage)), each=empty_bar)
  s3 <- rbind(s3, to_add)
  s3 <- s3 %>% arrange(stage)
  s3$id <- seq(1, nrow(s3))
  # Get the name and the y position of each label
  label_data <- s3
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s3 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  #have same subtask in different stages
  alpha_vector <- tapply(unique(s3$fill_alpha), unique(s3$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s3$subtask_abb)]
  #appear is in 1:7 stage:2,4
  p3 <- ggplot(s3, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s3$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s3$id),4), y = c(1, 2,3,4), label = c("1","2","3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    ylim(-5,5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.6, label=stage), hjust=c(1,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p3 <- gridExtra::grid.arrange(p3, bottom="Text summarization")
  return(p3)
}
p3 <- plot3()
p3
#Task4: Information extraction appear is in 1:4 stage:2,3,4,5
s4 <- f4[which(f4$task=="Information extraction"),]
s4 <- s4[,-3]
s4$ln_appear <- log(s4$appear)+1
plot4 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s4$stage)), ncol(s4)) )
  colnames(to_add) <- colnames(s4)
  to_add$stage <- rep(levels(as.factor(s4$stage)), each=empty_bar)
  s4 <- rbind(s4, to_add)
  s4 <- s4 %>% arrange(stage)
  s4$id <- seq(1, nrow(s4))
  # Get the name and the y position of each label
  label_data <- s4
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s4 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  #do not have same subtask in different stages
  alpha_vector <- tapply(unique(s4$fill_alpha), unique(s4$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s4$subtask_abb)]
  #appear is in 1:4 stage:2,4,5
  p4 <- ggplot(s4, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s4$subtask_abb))),guide="none") +
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 2.5, xend = start, yend = 2.5), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 1.5, xend = start, yend = 1.5), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s4$id),3), y = c(1, 2,3), label = c("1", "2","3") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=appear, fill=stage, alpha=subtask), stat="identity") +
    ylim(-5,4) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-0.7,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.6, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.6, label=stage), hjust=c(1,1,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p4 <- gridExtra::grid.arrange(p4, bottom="Information extraction")
  return(p4)
}
p4 <- plot4()
p4
#Task5: Textual question answering appear is in 1:14 stage:1,2,3,4,5
s5 <- f4[which(f4$task=="Textual question answering"),]
s5 <- s5[,-3]
s5$ln_appear <- log(s5$appear)+1
plot5 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s5$stage)), ncol(s5)) )
  colnames(to_add) <- colnames(s5)
  to_add$stage <- rep(levels(as.factor(s5$stage)), each=empty_bar)
  s5 <- rbind(s5, to_add)
  s5 <- s5 %>% arrange(stage)
  s5$id <- seq(1, nrow(s5))
  # Get the name and the y position of each label
  label_data <- s5
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s5 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  #have same subtask in different stages
  alpha_vector <- tapply(unique(s5$fill_alpha), unique(s5$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s5$subtask_abb)]
  #appear is in 1:10 stage:2,3,4,5
  p5 <- ggplot(s5, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s5$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 5, xend = start, yend = 5), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
      annotate("text", x = rep(max(s5$id),5), y = c(1, 2, 3,4,5), label = c("1", "2", "3","4","5") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=appear, fill=stage, alpha=subtask), stat="identity") +
    ylim(-7,8) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-2.5,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.7, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.8, label=stage), hjust=c(0,1,1,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p5 <- gridExtra::grid.arrange(p5, bottom="Textual question answering")
  return(p5)
}
p5 <- plot5()
p5
#Task6: Medical image processing appear is in 1:3 stage:2,3
s6 <- f4[which(f4$task=="Medical image processing"),]
s6 <- s6[,-3]
s6$ln_appear <- log(s6$appear)+1
plot6 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s6$stage)), ncol(s6)) )
  colnames(to_add) <- colnames(s6)
  to_add$stage <- rep(levels(as.factor(s6$stage)), each=empty_bar)
  s6 <- rbind(s6, to_add)
  s6 <- s6 %>% arrange(stage)
  s6$id <- seq(1, nrow(s6))
  # Get the name and the y position of each label
  label_data <- s6
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s6 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  #have same subtask in different stages
  alpha_vector <- tapply(unique(s6$fill_alpha), unique(s6$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s6$subtask_abb)]
  #appear is in 1:3 stage:2,3
  p6 <- ggplot(s6, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s6$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s6$id),3), y = c(1, 2, 3), label = c("1", "2", "3") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=appear, fill=stage, alpha=subtask), stat="identity") +
    ylim(-2,3.5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm")
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.5, label=stage), hjust=c(1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p6 <- gridExtra::grid.arrange(p6, bottom="Medical image processing")
  return(p6)
}
p6 <- plot6()
p6
#Task7: Disease prediction appear is in 1:2 stage:3,4, 5
s7 <- f4[which(f4$task=="Disease prediction"),]
s7 <- s7[,-3]
s7$ln_appear <- log(s7$appear)+1
plot7 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s7$stage)), ncol(s7)) )
  colnames(to_add) <- colnames(s7)
  to_add$stage <- rep(levels(as.factor(s7$stage)), each=empty_bar)
  s7 <- rbind(s7, to_add)
  s7 <- s7 %>% arrange(stage)
  s7$id <- seq(1, nrow(s7))
  # Get the name and the y position of each label
  label_data <- s7
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s7 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- tapply(unique(s7$fill_alpha), unique(s7$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s7$subtask_abb)]
  #appear is in 1:2 stage:4, 5
  p7 <- ggplot(s7, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s7$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 6, xend = start, yend = 6), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s7$id),2), y = c(1, 2), label = c("1", "2") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=appear, fill=stage, alpha=subtask), stat="identity") +
    ylim(-2,4) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.4, label=stage), hjust=c(0,1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p7 <- gridExtra::grid.arrange(p7, bottom="Disease prediction")
  return(p7)
}
p7 <- plot7()
p7
#Task8: Open question answering appear is in 1:4 stage:3,4
s8 <- f4[which(f4$task=="Multimodal question answering"),]
s8 <- s8[,-3]
s8$ln_appear <- log(s8$appear)+1
plot8 <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(s8$stage)), ncol(s8)) )
  colnames(to_add) <- colnames(s8)
  to_add$stage <- rep(levels(as.factor(s8$stage)), each=empty_bar)
  s8 <- rbind(s8, to_add)
  s8 <- s8 %>% arrange(stage)
  s8$id <- seq(1, nrow(s8))
  # Get the name and the y position of each label
  label_data <- s8
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # prepare a data frame for base lines
  base_data <- s8 %>% 
    group_by(stage) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # prepare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  #have same subtask in different stages
  alpha_vector <- tapply(unique(s8$fill_alpha), unique(s8$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s8$subtask_abb)]
  #appear is in 1:7 stage:2,3,4,5
  p8 <- ggplot(s8, aes(x=as.factor(id), y=ln_appear)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_appear, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s8$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #(data=grid_data, aes(x = end, y = 16, xend = start, yend = 16), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s8$id),4), y = c(1, 2, 3,4), label = c("1", "2", "3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=appear, fill=stage, alpha=subtask), stat="identity") +
    ylim(-3,5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1.1,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_appear+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.6, label=stage), hjust=c(1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p8 <- gridExtra::grid.arrange(p8, bottom="Multimodal question answering")
  return(p8)
}
p8 <- plot8()
p8

alpha_vector <- tapply(unique(f4$fill_alpha), unique(f4$subtask_abb), FUN = function(x) x[1])
alpha_vector <- alpha_vector[unique(f4$subtask_abb)]
f4$id <- seq(1, nrow(f4))
p9 <- ggplot(f4, aes(x=as.factor(id), y=appear, fill=subtask_abb)) + 
  geom_bar(aes(x=as.factor(id),y=appear, fill=subtask_abb), stat="identity") +
  scale_fill_manual(name="Subtasks of LLMs in clinical settings",values =alpha_vector,breaks = na.omit(c(unique(f4$subtask_abb))),
                    labels=c("Outpatient registration recommendation","Clinical history generation","Clinical triage classification","ECG report generation","Image caption","Image classification",
                             "Image segmentation","Imaging protocol generation","Open question answering",
                             "Report error check","Report extraction","Report generation","Report reprocessing","Report simplification",
                             "Report standardization","Report summarization","Text classification",
                             "Clinical decision support improving suggestions","Clinical letter generation","Diagnosis conclusion generation","Disease classification",
                             "Disease feature extraction","Disease phenotype extraction","Image segmentation","Medical question summarization","Multi-choice question answering","Open question answering","Respiratory health prediction",
                             "Treatment plan recommendations","Visual question answering","Clinical letter generation","Clinical named entity recognition","Dialogue summarization","Disease feature recognition","Handoff note generation","ICD code assignment",
                             "Informed consent document generation","Multi-choice question answering","Open question answering","Postoperative complication extraction","Risk prediction","Surgical consent form simplification","Survival prediction","Video question answering",
                             "Visual question answering","Voice conversations","Diagnosis-related group prediction","Discharge letter generation","Discharge summary generation","Discharge summary simplification","Disease feature recognition",
                             "Disease phenotype recognition","Disease recurrence prediction","Open question answering","Social determinant of health extraction","Text deidentification")) +
  theme(legend.key.size = unit(0.6, 'cm'), #change legend key size
        legend.key.height = unit(0.6, 'cm'), #change legend key height
        legend.key.width = unit(0.6, 'cm'), #change legend key width
        legend.title = element_text(size=14), #change legend title font size
        legend.text = element_text(size=8)) +
  guides(fill=guide_legend(ncol=2))#change legend text font size
        
p9
leg <-  ggpubr::get_legend(p9)
legend <- as_ggplot(leg)
#put the plots together
#ggarrange(p1,p2,p3,p4,p5,p6,p7,p8,nrow=2,ncol=4)
#pl <- list(p1,p2,p3,p4,p7,p6,p5,p8)
pl <- list(p1,p7,p2,p3,p4,p6,p5,p8)
custom_labels <- list("(A)", "(B)", "(C)", "(D)", "(E)", "(F)", "(G)", "(H)")
# Labelling plots
#   customize_label <- function(label, size = 14, weight = "bold") {
#     ggdraw() + draw_text(label, size = size, hjust = 0.5, vjust = 0.5, fontface = "bold")
#   }
# Create the plot grid with labels
mycolumn <- max(1,round(length(pl)/2))
plots <- cowplot::plot_grid(plotlist = pl, labels = custom_labels,
                            rel_widths = c(rep(1, length(pl))),label_size = 18,align = "hv", nrow=2)
plots2 <- cowplot::plot_grid(plots, legend, ncol = 2, rel_widths = c(1, .47))
myh <- mycolumn+4
myw <- mycolumn*5-1
ggsave(plot=plots2, file="plots3/fig1_leg2.pdf", width = myw, height = myh)
ggsave(plot=plots2, file="plots3/fig1_leg2.png", width = myw, height = myh, bg = "white")
#ggsave(plot=plots2, file="plots3/fig1_leg2.png", width = 1200, height = 1200, units = "px", dpi = 300, bg = "white")

