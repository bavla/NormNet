# Natalija

We read in R the data from the file
´
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> setwd("C:/Users/batagelj/Documents/papers/2021/normNet/natalija")
> C <- read.csv2("UssrX2018.csv",header=FALSE,nrows=15,row.names=1)
> colnames(C) <- rownames(C)
> S <- as.matrix(C)
> matrix2net(S,Net="UssrX2018.net")
´
