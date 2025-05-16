################################################################################
################################################################################

#install/load relevant packages
list.of.packages <- c("plyr","tidyverse","ggplot2","ggpubr","dplyr","ggpattern")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages,repos = "http://cran.us.r-project.org")
lapply(list.of.packages, library, character.only = TRUE)

################################################################################
################################################################################

#Data loading and pre-processing
orig <- read.csv("data/appear.csv") #the times of LLMs appear in the clinical tasks
r <- nrow(orig)-5 #number of model
c <- ncol(orig)-2 #number of subtask with different input-output
data <- data.frame( matrix(NA, r*c, 32) ) #create target table
colnames(data) <- c("model","submodel","stage","task","subtask"
                    ,"input1","input2","output","appear","best"
                    ,"pre_num","pre_gpu","TDP1","pre_TDP","fin_num","fin_gpu"
                    ,"TDP2","fin_TDP","infe_num","infe_gpu","TDP3","infe_TDP"
                    ,"pre_m","fin_m","infe_m","access","price1","pre_price"
                    ,"price2","fin_price","price3","infe_price")
#fill the column model and submodel
model <- orig[6:nrow(orig),1:2]
data[,1:2] <- rep(model,times=(c))
#fill the column appear
for( i in seq(1:c)){
  n1 <- (i-1)*r+1
  n2 <- i*r
  data$appear[n1:n2] <- orig[6:nrow(orig),i+2]
}
#fill the column from task to output
lab <- orig[1:5,0:c+2]
lab2 <- t(lab)
lab3 <- data.frame(lab2)
lab4 <- lab3[1,]
for (i in seq(1:c)){
  for (j in seq(1:r)){
    lab4 <- rbind(lab4,lab3[i+1,])
  }
}
data[,4:8] <- lab4[2:nrow(lab4),]

orig2 <- read.csv("data/best.csv") #the times of LLMs perform best in the clinical tasks
#fill the column: best
for( i in seq(1:c)){
  n1 <- (i-1)*r+1
  n2 <- i*r
  data$best[n1:n2] <- orig2[6:nrow(orig),i+2]
}

orig3 <- read.csv("data/detail.csv") #resource and other details
#fill the column:pre_num to access
res <- orig3[6:nrow(orig2),3:24]
data[,11:32] <- rep(res,times=c)

#fill the column:stage
data$stage[1:330] <- rep('I',times=330)
data$stage[331:7260] <- rep('II',times=6930) # 21
data$stage[7261:13200] <- rep('III',times=5940) # 18
data$stage[13201:18810] <- rep('IV',times=5610) # 17
data$stage[18811:22110] <- rep('V',times=3300) # 10

################################################################################
################################################################################

#codes for plot Figure4
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
    ylim(-2,3) +
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
                    labels=c("Outpatient registration recommending","Clinical histories generation","Clinical triage classification","ECG report generation","Image caption","Image classfication",
                             "Image segmentation","Imaging protocol generation","Open question answering",
                             "Report error check","Report extraction","Report generation","Report reprocessing","Report simplification",
                             "Report standardization","Report summarization","Text classification",
                             "Clinical decision support improving suggestions","Clinical letters generation","Diagnosis conclusion generation","Disease classification",
                             "Disease feature extraction","Disease phenotypes extraction","Image segmentation","Medical question summarization","Multi-choice question answering","Open question answering","Respiratory health prediction",
                             "Treatment plan recommendations","Visual question answering","Clinical letters generation","Clinical named entity recognition","Dialogue summarization","Disease feature recognition","Handoff notes generation","ICD codes assignment",
                             "Informed consent document generation","Multi-choice question answering","Open question answering","Postoperative complications extraction","Risk prediction","Surgical consent forms simplification","Survival Prediction","Video question anwsering",
                             "Visual question answering","Voice conversations","Diagnosis-related Group prediction","Discharge letters generation","Discharge summaries generation","Discharge summaries simplification","Disease feature recognition",
                             "Disease phenotypes recognition","Disease recurrence prediction","Open question answering","Social determinants of health extraction","Text de-Identification")) +
  theme(legend.key.size = unit(0.6, 'cm'), #change legend key size
        legend.key.height = unit(0.6, 'cm'), #change legend key height
        legend.key.width = unit(0.6, 'cm'), #change legend key width
        legend.title = element_text(size=14), #change legend title font size
        legend.text = element_text(size=8)) +
  guides(fill=guide_legend(ncol=2))#change legend text font size

p9
leg <-  ggpubr::get_legend(p9)
legend <- as_ggplot(leg)
pl <- list(p1,p7,p2,p3,p4,p6,p5,p8)
custom_labels <- letters[1:length(pl)]
# Create the plot grid with labels
mycolumn <- max(1,round(length(pl)/2))
plots <- cowplot::plot_grid(plotlist = pl, labels = custom_labels,
                            rel_widths = c(rep(1, length(pl))),label_size = 18,align = "hv", nrow=2)
plots2 <- cowplot::plot_grid(plots, legend, ncol = 2, rel_widths = c(1, .47))
myh <- mycolumn+4
myw <- mycolumn*5-1
ggsave(plot=plots2, file="plots/figure4.pdf", width = myw, height = myh)
ggsave(plot=plots2, file="plots/figure4.png", width = myw, height = myh, bg = "white")

################################################################################
################################################################################

##codes for plot Figure5
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
f4 <- aggregate(best~model+stage+task+subtask,data=f2,sum)
#delete best=0
f4[f4==0] <- NA
f4 <- na.omit(f4)

f4 <- f4[order(f4$stage),]
f4_sub <- aggregate(best~stage+subtask,data=f4,sum)
f4_sub <- f4_sub[order(f4_sub$stage),]
f4_sub$seq <- NA
stage_num <- aggregate(best~stage,data=f4,sum)[,-2]
b <- 1
for (i in seq(1:length(stage_num))){
  a <- seq(1:length(which(f4_sub$stage==stage_num[i])))
  f4_sub$seq[b:(b+length(a)-1)] <- a
  b <- b+length(a)
}
f4_sub$tran <- NA
#stage1
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
#Task1: Disease diagnosis best is in 1:3 stage: 1,2
s1 <- f4[which(f4$task=="Disease diagnosis"),]
s1 <- s1[,-3]
s1$ln_best <- log(s1$best)+1
plot11 <- function(tt){
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
  #best is in 1:3 stage: 1,2
  p1 <- ggplot(s1, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    #specific colors
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s1$subtask_abb))),guide="none") +
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s1$id),4), y = c(1, 2,3,4), label = c("1","2","3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    ylim(-4,4.5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_best+0.6, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.8, label=stage), hjust=c(1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p1 <- gridExtra::grid.arrange(p1, bottom="Disease diagnosis")
  return(p1)
}
p11 <- plot11()
p11
#Task2: Text generation best is in 1:2 stage:1,2,3,4,5
s2 <- f4[which(f4$task=="Text generation"),]
s2 <- s2[,-3]
s2$ln_best <- log(s2$best)+1
plot12 <- function(tt){
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
  #best is in 1:3 stage: 2,3,4,5
  p2 <- ggplot(s2, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s2$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s2$id),4), y = c(1, 2,3,4), label = c("1", "2","3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-3,4.5) +
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
    geom_text(data=label_data, aes(x=id, y=ln_best+0.6, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.6, label=stage), hjust=c(1,0,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p2 <- gridExtra::grid.arrange(p2, bottom="Text generation")
  return(p2)
}
p12 <- plot12()
p12
#Task3: Text summarization best is in 1:2 stage:2,3,4
s3 <- f4[which(f4$task=="Text summarization"),]
s3 <- s3[,-3]
s3$ln_best <- log(s3$best)+1
plot13 <- function(tt){
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
  alpha_vector <- tapply(unique(s3$fill_alpha), unique(s3$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s3$subtask_abb)]
  #best is in 1:2 stage:2,4
  p3 <- ggplot(s3, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s3$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s3$id),3), y = c(1, 2,3), label = c("1", "2","3") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-3,3.5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-0.9,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_best+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.5, label=stage), hjust=c(1,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p3 <- gridExtra::grid.arrange(p3, bottom="Text summarization")
  return(p3)
}
p13 <- plot13()
p13
#Task4: Information extraction best is in 1:2 stage:2,3,4,5
s4 <- f4[which(f4$task=="Information extraction"),]
s4 <- s4[,-3]
s4$ln_best <- log(s4$best)+1
plot14 <- function(tt){
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
  alpha_vector <- tapply(unique(s4$fill_alpha), unique(s4$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s4$subtask_abb)]
  #best is in 1:4 stage:2,4,5
  p4 <- ggplot(s4, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s4$subtask_abb))),guide="none") +
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s4$id),3), y = c(1, 2,3), label = c("1", "2","3") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-3,3.5) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-0.9,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_best+0.6, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.25, xend = end, yend = -0.25), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.8, label=stage), hjust=c(1,1,0,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p4 <- gridExtra::grid.arrange(p4, bottom="Information extraction")
  return(p4)
}
p14 <- plot14()
p14
#Task5: Multi-choice question answering best is in 1:13 stage:1,2,3,4
s5 <- f4[which(f4$task=="Textual question answering"),]
s5 <- s5[,-3]
s5$ln_best <- log(s5$best)+1
plot15 <- function(tt){
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
  alpha_vector <- tapply(unique(s5$fill_alpha), unique(s5$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s5$subtask_abb)]
  #best is in 1:10 stage:2,3,4,5
  p5 <- ggplot(s5, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s5$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 13, xend = start, yend = 13), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s5$id),4), y = c(1, 2, 3,4), label = c("1", "2", "3","4") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-3,4.5) +
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
    geom_text(data=label_data, aes(x=id, y=ln_best+0.6, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -1, label=stage), hjust=c(0,0,0,1,1), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p5 <- gridExtra::grid.arrange(p5, bottom="Textual question answering")
  return(p5)
}
p15 <- plot15()
p15
#Task6: Medical image processing best is in 1:2 stage:2,3
s6 <- f4[which(f4$task=="Medical image processing"),]
s6 <- s6[,-3]
s6$ln_best <- log(s6$best)+1
plot16 <- function(tt){
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
  alpha_vector <- tapply(unique(s6$fill_alpha), unique(s6$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s6$subtask_abb)]
  #best is in 1:3 stage:2,3
  p6 <- ggplot(s6, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s6$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s6$id),2), y = c(1, 2), label = c("1", "2") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-2,3) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-0.9,4), "cm")
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm") 
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_best+0.5, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.5, label=stage), hjust=c(1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p6 <- gridExtra::grid.arrange(p6, bottom="Medical image processing")
  return(p6)
}
p16 <- plot16()
p16
#Task7: Disease prediction best is in 1:2 stage:4, 5
s7 <- f4[which(f4$task=="Disease prediction"),]
s7 <- s7[,-3]
s7$ln_best <- log(s7$best)+1
plot17 <- function(tt){
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
  #best is in 1:2 stage:4, 5
  p7 <- ggplot(s7, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s7$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 8, xend = start, yend = 8), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    #geom_segment(data=grid_data, aes(x = end, y = 6, xend = start, yend = 6), colour = "grey", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s7$id),2), y = c(1, 2), label = c("1", "2") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-2,3) +
    theme_minimal() +
    theme(
      legend.key.size = unit(0.15, "cm"),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-0.8,4), "cm") 
      #plot.margin = unit(c(-0.5,-4,-0.5,-4), "cm")
    ) +
    coord_polar() + 
    geom_text(data=label_data, aes(x=id, y=ln_best+0.3, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.15, xend = end, yend = -0.15), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -0.4, label=stage), hjust=c(0,1,0), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p7 <- gridExtra::grid.arrange(p7, bottom="Disease prediction")
  return(p7)
}
p17 <- plot17()
p17
#Task8: Open question answering best is in 1:6 stage:3,4
s8 <- f4[which(f4$task=="Multimodal question answering"),]
s8 <- s8[,-3]
s8$ln_best <- log(s8$best)+1
plot18 <- function(tt){
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
  alpha_vector <- tapply(unique(s8$fill_alpha), unique(s8$subtask_abb), FUN = function(x) x[1])
  alpha_vector <- alpha_vector[unique(s8$subtask_abb)]
  #best is in 1:10 stage:2,3,4,5
  p8 <- ggplot(s8, aes(x=as.factor(id), y=ln_best)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id),y=ln_best, fill=subtask_abb), stat="identity") +
    scale_fill_manual(values =  alpha_vector,breaks = na.omit(c(unique(s8$subtask_abb))),guide="none") +
    
    # Add a val=8/6/4/2 lines. I do it at the beginning to make sur barplots are OVER it.
    #geom_segment(data=grid_data, aes(x = end, y = 4, xend = start, yend = 4), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 3, xend = start, yend = 3), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 2, xend = start, yend = 2), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    geom_segment(data=grid_data, aes(x = end, y = 1, xend = start, yend = 1), colour = "gray60", alpha=1, linewidth=0.3 , inherit.aes = FALSE ) +
    
    # Add text showing the value of each 3/2/1 lines
    annotate("text", x = rep(max(s8$id),3), y = c(1,2,3), label = c("1","2","3") , color="gray60", size=3 , angle=0, fontface="bold", hjust=1) +
    
    #geom_bar(aes(x=as.factor(id), y=best, fill=stage, alpha=subtask), stat="identity") +
    ylim(-2,3.5) +
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
    geom_text(data=label_data, aes(x=id, y=ln_best+0.6, label=model, hjust=hjust), color="black", fontface="bold",alpha=1, size=1.5, angle= label_data$angle, inherit.aes = FALSE ) +
    
    # Add base line information
    geom_segment(data=base_data, aes(x = start, y = -0.2, xend = end, yend = -0.2), colour = "black", alpha=1, linewidth=0.6 , inherit.aes = FALSE )  +
    geom_text(data=base_data, aes(x = title, y = -1, label=stage), hjust=c(0,1), colour = "black", alpha=1, size=4, fontface="bold", inherit.aes = FALSE)
  p8 <- gridExtra::grid.arrange(p8, bottom="Multimodal question answering")
  return(p8)
}
p18 <- plot18()
p18

alpha_vector <- tapply(unique(f4$fill_alpha), unique(f4$subtask_abb), FUN = function(x) x[1])
alpha_vector <- alpha_vector[unique(f4$subtask_abb)]
f4$id <- seq(1, nrow(f4))
p9 <- ggplot(f4, aes(x=as.factor(id), y=best, fill=subtask_abb)) + 
  geom_bar(aes(x=as.factor(id),y=best, fill=subtask_abb), stat="identity") +
  scale_fill_manual(name="Subtasks of LLMs in clinical settings",values =alpha_vector,breaks = na.omit(c(unique(f4$subtask_abb))),
                    labels=c("Outpatient registration recommending","Clinical histories generation","Clinical triage classification","ECG report generation","Image caption","Image classfication",
                             "Image segmentation","Imaging protocol generation","Open question answering",
                             "Report error check","Report extraction","Report generation","Report reprocessing","Report simplification",
                             "Report standardization","Report summarization","Text classification",
                             "Clinical decision support improving suggestions","Clinical letters generation","Diagnosis conclusion generation","Disease classification",
                             "Disease feature extraction","Disease phenotypes extraction","Image segmentation","Medical question summarization","Multi-choice question answering","Open question answering","Respiratory health prediction",
                             "Treatment plan recommendations","Visual question answering","Clinical letters generation","Clinical named entity recognition","Dialogue summarization","Disease feature recognition","Handoff notes generation","ICD codes assignment",
                             "Informed consent document generation","Multi-choice question answering","Open question answering","Postoperative complications extraction","Risk prediction","Surgical consent forms simplification","Survival Prediction","Video question anwsering",
                             "Visual question answering","Voice conversations","Diagnosis-related Group prediction","Discharge letters generation","Discharge summaries generation","Discharge summaries simplification","Disease feature recognition",
                             "Disease phenotypes recognition","Disease recurrence prediction","Open question answering","Social determinants of health extraction","Text de-Identification")) +
  theme(legend.key.size = unit(0.6, 'cm'), #change legend key size
        legend.key.height = unit(0.6, 'cm'), #change legend key height
        legend.key.width = unit(0.6, 'cm'), #change legend key width
        legend.title = element_text(size=14), #change legend title font size
        legend.text = element_text(size=8)) +
  guides(fill=guide_legend(ncol=2))#change legend text font size
p9
leg <-  ggpubr::get_legend(p9)
legend <- as_ggplot(leg)
pl <- list(p11,p17,p12,p13,p14,p16,p15,p18)
custom_labels <- letters[1:length(pl)]
# Create the plot grid with labels
mycolumn <- max(1,round(length(pl)/2))
plots <- cowplot::plot_grid(plotlist = pl, labels = custom_labels,
                            rel_widths = c(rep(1, length(pl))),label_size = 20,align = "hv", nrow=2)
plots2 <- cowplot::plot_grid(plots, legend, ncol = 2, rel_widths = c(1, .45))
myh <- mycolumn+4
myw <- mycolumn*5
ggsave(plot=plots2, file="plots/figure5.pdf", width = myw, height = myh)
ggsave(plot=plots2, file="plots/figure5.png", width = myw, height = myh, bg = "white")

################################################################################
################################################################################

#codes for plot Figure6
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

#################################################################################
#################################################################################

#codes for plot Figure7
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

ggsave(plot=plots2, file="plots/figure7.pdf", width = myw, height = myh)
ggsave(plot=plots2, file="plots/figure7.png", width = myw, height = myh, bg = "white")

################################################################################
################################################################################

#codes for plot figure8
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
label$modal[which(label$modal!=0)] <- "multi"
label$modal[which(label$modal==0)] <- "single"

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
colnames(f2)[10] <- "access"
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
f4 <- aggregate(best~model+access,data=f4,sum)

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
ff <- ff %>% arrange(access, ln_best)
plot_io <- function(tt){
  empty_bar <- 3
  to_add <- data.frame( matrix(NA, empty_bar*nlevels(as.factor(ff$modal)), ncol(ff)) )
  colnames(to_add) <- colnames(ff)
  to_add$modal <- rep(levels(as.factor(ff$modal)), each=empty_bar)
  to_add$access <- rep(levels(as.factor(ff$access)), each=2)
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
  alpha_vector <- c("open"=1,"api"=0.7,"restricted"=0.4)
  #ln_best is in 1:4 modal:1,2
  p1 <- ggplot(ff, aes(x=as.factor(id), y=ln_best,pattern=access)) +       #, fill=modal Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar_pattern(aes(x=as.factor(id),y=ln_best,fill=modal), stat="identity", pattern_fill = "black", colour = "black", pattern_spacing = 0.0075,
                     pattern_frequency = 5, pattern_angle = 45)+ #,fill="white"
    #specific colors
    scale_fill_manual(values = c("white","white"),name="modal"
                      ,labels=c("single","multi"),guide="none")+ 
    #scale_alpha_manual(values = alpha_vector ,breaks=c("open","api","restricted")) +
    scale_pattern_manual(values = c("open" = "none", "api" = "stripe", "restricted" = "circle"))+
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
p10 <- ggplot(ff, aes(x=as.factor(id), y=ln_best,pattern=access)) +       #, fill=modal Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar_pattern(aes(x=as.factor(id),y=ln_best), stat="identity", pattern_fill = "black",
                   fill = "white", colour = "black", pattern_spacing = 0.02,
                   pattern_frequency = 5, pattern_angle = 45) +
  scale_pattern_manual(values = c("open" = "none", "api" = "stripe", "restricted" = "circle"))

leg2 <-  ggpubr::get_legend(p10)
legend2 <- as_ggplot(leg2)

#plots <- cowplot::plot_grid(p_io, legend2, ncol = 2, rel_widths = c(1, .001))
plots <- cowplot::ggdraw() +
  cowplot::draw_plot(p_io, x = 0, y = 0, width = 0.93, height = 1,scale=1.3) + 
  cowplot::draw_plot(legend2, x = 0.87, y = .35, width = .1, height = .35,scale=1)

#plots <- gridExtra::grid.arrange(p_io, gridExtra::arrangeGrob(legend, legend2), ncol = 2)
ggsave(plot=plots, file="plots/figure8.pdf", width = 8.5, height = 6.5)
ggsave(plot=plots, file="plots/figure8.png", width = 8.5, height = 6.5, bg = "white")


################################################################################
################################################################################



