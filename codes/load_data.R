orig <- read.csv("data/appear3.csv")
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

orig2 <- read.csv("data/best3.csv")
#fill the column: best
for( i in seq(1:c)){
  n1 <- (i-1)*r+1
  n2 <- i*r
  data$best[n1:n2] <- orig2[6:nrow(orig),i+2]
}

orig3 <- read.csv("data/detail.csv")
#fill the column:pre_num to access
res <- orig3[6:nrow(orig2),3:24]
data[,11:32] <- rep(res,times=c)

#fill the column:stage
data$stage[1:330] <- rep('1',times=330)
data$stage[331:7260] <- rep('2',times=6930) # 21
data$stage[7261:13200] <- rep('3',times=5940) # 18
data$stage[13201:18810] <- rep('4',times=5610) # 17
data$stage[18811:22110] <- rep('5',times=3300) # 10


