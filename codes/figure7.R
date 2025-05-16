#Fig 3
library(plyr)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(dplyr)
f2 <- data[,1:8]
f2 <- cbind(f2,data$best)
colnames(f2)[9] <- "best"
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


f3 <- f2[,c(1,3:9)]
f3 <- cbind(f3,data[,11:32])
f3[is.na(f3)] <- 0
f3 <- aggregate(best~model+stage+task+pre_num+pre_gpu+TDP1+pre_TDP+fin_num+fin_gpu+TDP2+fin_TDP+infe_num+infe_gpu+TDP3+infe_TDP+pre_m+fin_m+infe_m+access+price1+pre_price+price2+fin_price+price3+infe_price,data=f3,sum)
f3[which(f3$best==0),21] <- NA
f3 <- na.omit(f3)
#f3[f3==""] <- 1


#plot1: GPU memory
gpu <- f3[,c(1:3,16:18)]
#gpu <- gpu[,-4]
gpu$add <- gpu$pre_m+gpu$fin_m+gpu$infe_m
gpu[which(gpu$add==0),7] <- NA
gpu <- na.omit(gpu)
gpu <- gpu[,-7]
gpu$process1 <- NA
for (i in seq(1:nrow(gpu))){
  if (gpu$pre_m[i]!=0)
    gpu$process1[i]="pretrain"
}
gpu$process2 <- NA
for (i in seq(1:nrow(gpu))){
  if (gpu$fin_m[i]!=0)
    gpu$process2[i]="finetune"
}
gpu$process3 <- NA
for (i in seq(1:nrow(gpu))){
  if (gpu$infe_m[i]!=0)
    gpu$process3[i]="inference"
}

gpu2 <- data.frame( matrix(NA, nrow(gpu)*3, ncol(gpu)-4) )
for (i in seq(1:3)){
  n1 <- (i-1)*nrow(gpu)+1
  n2 <- i*nrow(gpu)
  gpu2[n1:n2,1:5] <- gpu[,c(1:3,i+3,i+6)]
}
gpu2 <- na.omit(gpu2)
colnames(gpu2) <- c("model","stage","task","memory","process")#,"access"
#do ln transform for GPU memory
gpu2$ln_memory <- log(gpu2$memory)
gpu2$taskabb <- NA
for (i in seq(1:nrow(gpu2))){
  if (gpu2$task[i]=="Disease diagnosis")
    gpu2$taskabb[i]="A"
  if (gpu2$task[i]=="Disease prediction")
    gpu2$taskabb[i]="B"
  if (gpu2$task[i]=="Information extraction")
    gpu2$taskabb[i]="C"
  if (gpu2$task[i]=="Medical image processing")
    gpu2$taskabb[i]="D"
  if (gpu2$task[i]=="Textual question answering")
    gpu2$taskabb[i]="E"
  if (gpu2$task[i]=="Multimodal question answering")
    gpu2$taskabb[i]="F"
  if (gpu2$task[i]=="Text generation")
    gpu2$taskabb[i]="G"
  if (gpu2$task[i]=="Text summarization")
    gpu2$taskabb[i]="H"
}

#cols <- c("pretrain"= "#000000FF","finetune" = "#595959FF","inference"="#B3B3B3FF")
#cols <- tibble::enframe(cols, name = "process", value = "fill_pro")
#gpu2 <- left_join(gpu2, cols, by = "process")
gpu2 <- gpu2 %>% arrange(process, ln_memory)

plot_gpu <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(gpu2$taskabb)), ncol(gpu2)) )
  colnames(to_add) <- colnames(gpu2)
  to_add$taskabb <- rep(levels(as.factor(gpu2$taskabb)), each=empty_bar)
  #to_add$access <- rep(levels(as.factor(gpu2$access)), each=11)
  #to_add$process <- rep(levels(as.factor(gpu2$process)), each=8)
  gpu2 <- rbind(gpu2, to_add)
  gpu2 <- gpu2 %>% arrange(taskabb)
  gpu2$id <- seq(1, nrow(gpu2))
  # Get the name and the y position of each label
  label_data <- gpu2
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # gpu2pare a data frame for base lines
  base_data <- gpu2 %>% 
    group_by(taskabb) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # gpu2pare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- c("pretrain"=1,"finetune"=0.65,"inference"=0.3)
  #alpha_vector <- tapply(unique(gpu2$fill_pro), unique(gpu2$process), FUN = function(x) x[1])
  #alpha_vector <- alpha_vector[unique(gpu2$process)]
  #memory is in 0:12, task: 8
  p1 <- ggplot(gpu2, aes(x=as.factor(id), y=ln_memory)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_memory,alpha=process), stat="identity") +
    #specific colors
    scale_fill_manual(values = c("black"),breaks=na.omit(c(unique(gpu2$process))),guide="none" ) +
    scale_alpha_manual(values = alpha_vector ,breaks=c("pretrain","finetune","inference"),guide="none") +
    #scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(gpu2$process)))) +
    #scale_pattern_manual(values = c("open" = "none", "close" = "circle"))+
    #scale_pattern_alpha_manual(values = alpha_vector, breaks=c("pretrain","finetune","inference"), name="Process") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 10, xend = start, yend = 10), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 12, xend = start, yend = 12), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 9, xend = start, yend = 9), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 6, xend = start, yend = 6), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(gpu2$id),4), y = c(3, 6, 9,12), label = c("3", "6", "9","12") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=ln_memory, fill=taskabb, alpha=process), stat="identity") +
    ylim(-20,19) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_memory+1, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -1, xend = end, yend = -1), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -3, label=taskabb), hjust=c(1,1,1,1,0,0,0,0), colour = "black", alpha=1, size=3, fontface="bold", inherit.aes = FALSE)
  p1 <- gridExtra::grid.arrange(p1, bottom="GPU Memory")
  return(p1)
}
p_gpu <- plot_gpu()

#plot2:GPU TDP
tdp <- f3[,c(1:3,7,11,15)]
tdp$add <- tdp$pre_TDP+tdp$fin_TDP+tdp$infe_TDP
tdp[which(tdp$add==0),7] <- NA
tdp <- na.omit(tdp)
tdp <- tdp[,-7]
tdp$process1 <- NA
for (i in seq(1:nrow(tdp))){
  if (tdp$pre_TDP[i]!=0)
    tdp$process1[i]="pretrain"
}
tdp$process2 <- NA
for (i in seq(1:nrow(tdp))){
  if (tdp$fin_TDP[i]!=0)
    tdp$process2[i]="finetune"
}
tdp$process3 <- NA
for (i in seq(1:nrow(tdp))){
  if (tdp$infe_TDP[i]!=0)
    tdp$process3[i]="inference"
}
tdp2 <- data.frame( matrix(NA, nrow(tdp)*3, ncol(tdp)-4) )
for (i in seq(1:3)){
  n1 <- (i-1)*nrow(tdp)+1
  n2 <- i*nrow(tdp)
  tdp2[n1:n2,1:5] <- tdp[,c(1:3,i+3,i+6)]
}
tdp2 <- na.omit(tdp2)
colnames(tdp2) <- c("model","stage","task","TDP","process")
tdp2$ln_TDP <- log(tdp2$TDP)
tdp2$taskabb <- NA
for (i in seq(1:nrow(tdp2))){
  if (tdp2$task[i]=="Disease diagnosis")
    tdp2$taskabb[i]="A"
  if (tdp2$task[i]=="Disease prediction")
    tdp2$taskabb[i]="B"
  if (tdp2$task[i]=="Information extraction")
    tdp2$taskabb[i]="C"
  if (tdp2$task[i]=="Medical image processing")
    tdp2$taskabb[i]="D"
  if (tdp2$task[i]=="Textual question answering")
    tdp2$taskabb[i]="E"
  if (tdp2$task[i]=="Multimodal question answering")
    tdp2$taskabb[i]="F"
  if (tdp2$task[i]=="Text generation")
    tdp2$taskabb[i]="G"
  if (tdp2$task[i]=="Text summarization")
    tdp2$taskabb[i]="H"
}

tdp2 <- tdp2 %>% arrange(process, ln_TDP)

plot_tdp <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(tdp2$taskabb)), ncol(tdp2)) )
  colnames(to_add) <- colnames(tdp2)
  to_add$taskabb <- rep(levels(as.factor(tdp2$taskabb)), each=empty_bar)
  tdp2 <- rbind(tdp2, to_add)
  tdp2 <- tdp2 %>% arrange(taskabb)
  tdp2$id <- seq(1, nrow(tdp2))
  # Get the name and the y position of each label
  label_data <- tdp2
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # tdp2pare a data frame for base lines
  base_data <- tdp2 %>% 
    group_by(taskabb) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # tdp2pare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- c("pretrain"=1,"finetune"=0.65,"inference"=0.3)
  #memory is in 4:13, taskabb: 8
  p1 <- ggplot(tdp2, aes(x=as.factor(id), y=ln_TDP)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_TDP, alpha=process), stat="identity") +
    #specific colors
    scale_fill_manual(values = c("black"),guide="none" ) +
    scale_alpha_manual(values = alpha_vector ,breaks=c("pretrain","finetune","inference"),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 12, xend = start, yend = 12), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 13, xend = start, yend = 13), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 10, xend = start, yend = 10), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 7, xend = start, yend = 7), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(tdp2$id),4), y = c( 4, 7,10,13), label = c( "4", "7","10","13") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=ln_TDP, fill=taskabb, alpha=process), stat="identity") +
    ylim(-20,19) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_TDP+1, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -1, xend = end, yend = -1), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -3, label=taskabb), hjust=c(1,1,1,1,0,0,0,0), colour = "black", alpha=1, size=3, fontface="bold", inherit.aes = FALSE)
  p1 <- gridExtra::grid.arrange(p1, bottom="GPU TDP")
  return(p1)
}
p_tdp <- plot_tdp()
p_tdp

#plot3:GPU price
price <- f3[,c(1:3,21,23,25)]
price$add <- price$pre_price+price$fin_price+price$infe_price
price[which(price$add==0),7] <- NA
price <- na.omit(price)
price <- price[,-7]
price$process1 <- NA
for (i in seq(1:nrow(price))){
  if (price$pre_price[i]!=0)
    price$process1[i]="pretrain"
}
price$process2 <- NA
for (i in seq(1:nrow(price))){
  if (price$fin_price[i]!=0)
    price$process2[i]="finetune"
}
price$process3 <- NA
for (i in seq(1:nrow(price))){
  if (price$infe_price[i]!=0)
    price$process3[i]="inference"
}
price2 <- data.frame( matrix(NA, nrow(price)*3, ncol(price)-4) )
for (i in seq(1:3)){
  n1 <- (i-1)*nrow(price)+1
  n2 <- i*nrow(price)
  price2[n1:n2,1:5] <- price[,c(1:3,i+3,i+6)]
}
price2 <- na.omit(price2)
colnames(price2) <- c("model","stage","task","price","process")
price2$ln_price <- log(price2$price)
price2$taskabb <- NA
for (i in seq(1:nrow(price2))){
  if (price2$task[i]=="Disease diagnosis")
    price2$taskabb[i]="A"
  if (price2$task[i]=="Disease prediction")
    price2$taskabb[i]="B"
  if (price2$task[i]=="Information extraction")
    price2$taskabb[i]="C"
  if (price2$task[i]=="Medical image processing")
    price2$taskabb[i]="D"
  if (price2$task[i]=="Textual question answering")
    price2$taskabb[i]="E"
  if (price2$task[i]=="Multimodal question answering")
    price2$taskabb[i]="F"
  if (price2$task[i]=="Text generation")
    price2$taskabb[i]="G"
  if (price2$task[i]=="Text summarization")
    price2$taskabb[i]="H"
}

price2 <- price2 %>% arrange(process, ln_price)

plot_price <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(price2$taskabb)), ncol(price2)) )
  colnames(to_add) <- colnames(price2)
  to_add$taskabb <- rep(levels(as.factor(price2$taskabb)), each=empty_bar)
  price2 <- rbind(price2, to_add)
  price2 <- price2 %>% arrange(taskabb)
  price2$id <- seq(1, nrow(price2))
  # Get the name and the y position of each label
  label_data <- price2
  number_of_bar <- nrow(label_data)
  angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
  label_data$hjust <- ifelse( angle < -90, 1, 0)
  label_data$angle <- ifelse(angle < -90, angle+180, angle)
  
  # price2pare a data frame for base lines
  base_data <- price2 %>% 
    group_by(taskabb) %>% 
    dplyr::summarise(start=min(id), end=max(id) - empty_bar) %>% 
    rowwise() %>% 
    dplyr::mutate(title=mean(c(start, end)))
  # price2pare a data frame for grid (scales)
  grid_data <- base_data
  grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
  grid_data$start <- grid_data$start - 1
  grid_data <- grid_data[-1,]
  alpha_vector <- c("pretrain"=1,"finetune"=0.65,"inference"=0.3)
  #memory is in 4:13, taskabb: 8
  p1 <- ggplot(price2, aes(x=as.factor(id), y=ln_price)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_price, alpha=process), stat="identity") +
    #specific colors
    scale_fill_manual(values = c("black"),guide="none" ) +
    scale_alpha_manual(values = alpha_vector ,breaks=c("pretrain","finetune","inference"),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 17, xend = start, yend = 17), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 14, xend = start, yend = 14), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 11, xend = start, yend = 11), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 5, xend = start, yend = 5), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(price2$id),5), y = c( 5, 8,11,14,17), label = c( "5", "8","11","14","17") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=ln_price, fill=taskabb, alpha=process), stat="identity") +
    ylim(-23,28) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1.3,4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_price+1, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -1, xend = end, yend = -1), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -3.3, label=taskabb), hjust=c(1,1,1,1,0,0,0,0), colour = "black", alpha=1, size=3, fontface="bold", inherit.aes = FALSE)
  p1 <- gridExtra::grid.arrange(p1, bottom="GPU price")
  return(p1)
}
p_price <- plot_price()
p_price


alpha_vector <- c("pretrain"=1,"finetune"=0.65,"inference"=0.3)
tdp2$id <- seq(1, nrow(tdp2))
#memory is in 4:13, taskabb: 8
p9 <- ggplot(tdp2, aes(x=as.factor(id), y=ln_TDP)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar(aes(x=as.factor(id),y=ln_TDP,fill=taskabb), stat="identity") +
  #specific colors
  scale_fill_manual(values = c("black","black","black","black","black","black","black","black"),name="Tasks of LLMs in clinical settings"
                    ,labels=c("A. Disease diagnosis","B. Disease prediction","C. Information extraction","D. Medical image processing",
                              "E. Textual question answering","F. Multimodal question answering","G. Text generation","H. Text summarization" ) ) +
  #scale_alpha_manual(values = alpha_vector, breaks=c("pretrain","finetune","inference"), name="Process") +
  theme(legend.key.size = unit(0.6, 'cm'), #change legend key size
        legend.key.height = unit(0.5, 'cm'), #change legend key height
        legend.key.width = unit(0, 'cm'), #change legend key width
        legend.title = element_text(size=11), #change legend title font size
        legend.text = element_text(size=8))
p9
p10 <- ggplot(tdp2, aes(x=as.factor(id), y=ln_TDP)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar(aes(x=as.factor(id),y=ln_TDP,fill=taskabb, alpha=process), stat="identity") +
  #specific colors
  scale_fill_manual(values = c("black","black","black","black","black","black","black","black"),name="Tasks of LLMs in clinical settings"
                    ,labels=c("A. Disease diagnosis","B. Disease prediction","C. Information extraction","D. Medical image processing",
                              "E. Textual question answering","F. Multimodal question answering","G. Text generation","H. Text summarization" ),guide="none" ) +
  scale_alpha_manual(values = alpha_vector, breaks=c("pretrain","finetune","inference"), name="Process") +
  theme(legend.key.size = unit(0.6, 'cm'), #change legend key size
        legend.key.height = unit(0.6, 'cm'), #change legend key height
        legend.key.width = unit(0.6, 'cm'), #change legend key width
        legend.title = element_text(size=12), #change legend title font size
        legend.text = element_text(size=8))
p10
leg <-  ggpubr::get_legend(p9)
legend <- as_ggplot(leg)
leg2 <-  ggpubr::get_legend(p10)
legend2 <- as_ggplot(leg2)

pl <- list(p_gpu,p_tdp,p_price)
custom_labels <- letters[1:length(pl)]
# Create the plot grid with labels
mycolumn <- max(1,round(length(pl)/2))
plots <- cowplot::plot_grid(plotlist = pl, labels = custom_labels,
                            rel_heights = c(1.25, rep(1, length(pl) - 1)),label_size = 20,vjust = 1.0, nrow = 1)
plots2 <- cowplot::ggdraw() +
  cowplot::draw_plot(plots, x = 0, y = 0, width = 0.73, height = 1,scale=1) + 
  cowplot::draw_plot(legend, x = 0.65, y = .15, width = .4, height = .3,scale=1) + 
  cowplot::draw_plot(legend2, x = 0.54, y = .65, width = 0.5, height = 0.3,scale=1)
#plots2 <- cowplot::plot_grid(plots, legend, ncol = 2, rel_widths = c(1, .4))
myh <- mycolumn+3-1
myw <- mycolumn*6+2
# save as pdf
#ggsave(plot=plots, file=paste0(output_file,".pdf"), width = myw, height = myh)
ggsave(plot=plots2, file="plots/figure7.pdf", width = myw, height = myh)
ggsave(plot=plots2, file="plots/figure7.png", width = myw, height = myh, bg = "white")