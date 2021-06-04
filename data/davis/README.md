# Davis Southern Women network

<img src="https://github.com/bavla/NormNet/blob/main/data/davis/DGG1.png" width="600">

<img src="https://github.com/bavla/NormNet/blob/main/data/davis/DGG2.png" width="600">

```
> wdir <- "C:/Users/batagelj/Documents/papers/2021/twoMode/data/davis"
> setwd(wdir)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> library(ExPosition)
> b <- function(A,cut=0){ return(matrix(as.numeric(A>cut),nrow=nrow(A),dimnames=dimnames(A))) }
> D <- net2matrix("davis1.net")
> D
> DT <- t(D)
> DT
> S <- rowSums(DT)
> N <- rowNorms(DT,type='other',scale=ifelse(S>0,S,1))
> dim(N)
[1] 14 18
> P <- crossprod(N)
> P
> matrix2net(P,Net="ladies1.net")
> B <- N %*% t(b(N))
> J <- 1/(1/B + 1/t(B) - 1)
> dim(J)
[1] 14 14
> matrix2net(J,Net="events1.net")

> SP <- rowSums(D)
> SP
   Evelyn     Laura   Theresa    Brenda Charlotte   Frances   Eleanor 
        8         7         8         7         4         4         4 
    Pearl      Ruth     Verne     Myrna Katherine    Sylvia      Nora 
        3         4         4         4         6         7         8 
    Helen   Dorothy    Olivia     Flora 
        7         4         2         2 
> NP <- rowNorms(D,type='other',scale=ifelse(SP>0,SP,1))
> EE <- crossprod(NP)
> matrix2net(EE,Net="events2.net")

> Ne <- rowNorms(DT,type='other',scale=ifelse(S>1,S-1,1))
> dim(Ne)
[1] 14 18
> Pc <- t(N) %*% Ne
> diag(Pc) <- 0
> sum(Pc)
[1] 14
> matrix2net(Pc,Net="newman.net")
> E <- crossprod(t(N))
> matrix2net(E,Net="events3.net")

> BB <- NP %*% t(b(NP))
> JJ <- 1/(1/BB + 1/t(BB) - 1)
> dim(JJ)
> matrix2net(JJ,Net="Jwomen.net")


> help(hclust)
> 
> disJ <- as.dist(J,diag=FALSE,upper=FALSE)
> disP <- as.dist(1/P,diag=FALSE,upper=FALSE)
> Q <- as.vector(P)
> 1/min(Q[Q>0])
[1] 196
> disP[disP>220] <-220
> h <-hclust(disP,method="complete")
> h <-hclust(disP,method="single")
> t <-hclust(1-disJ,method="single")
> plot(t,hang=-1,cex=1,main="Southern women: events / Jaccard / single")
> plot(h,hang=-1,cex=1,main="Southern women: women / fractional / single")
> t <-hclust(1-disJ,method="complete")
> plot(t,hang=-1,cex=1,main="Southern women: events / Jaccard / complete")

> t <-hclust(1-disJ,method="ward")
> plot(t,hang=-1,cex=1,main="Southern women: events / Jaccard / Ward")
> h <-hclust(disP,method="ward.D")
> plot(h,hang=-1,cex=1,main="Southern women: women / fractional / Ward")
> 

> h$order
 [1]  6  5  4  3  1  2  7  9 17 18 10 12 13 14 11 15  8 16
> cbind(1:18,rownames(P))
      [,1] [,2]       
 [1,] "1"  "Evelyn"   
 [2,] "2"  "Laura"    
 [3,] "3"  "Theresa"  
 [4,] "4"  "Brenda"   
 [5,] "5"  "Charlotte"
 [6,] "6"  "Frances"  
 [7,] "7"  "Eleanor"  
 [8,] "8"  "Pearl"    
 [9,] "9"  "Ruth"     
[10,] "10" "Verne"    
[11,] "11" "Myrna"    
[12,] "12" "Katherine"
[13,] "13" "Sylvia"   
[14,] "14" "Nora"     
[15,] "15" "Helen"    
[16,] "16" "Dorothy"  
[17,] "17" "Olivia"   
[18,] "18" "Flora"    
> h$order
 [1]  6  5  4  3  1  2  7  9 17 18 10 12 13 14 11 15  8 16
> o <- c(6,5,4,3,1,2,7,9,17,18,8,16,10,12,13,14,11,15) 
> ho <- h$order
> h$order <- o
> plot(h,hang=-1,cex=1,main="Southern women: women / fractional / Ward")
> # Women complete ---------------------------
> m <- hclust(disP,method="complete")
> plot(m,hang=-1,cex=1,main="Southern women: women / fractional / complete")
> m$order
 [1]  5  6  4  3  1  2  7  9 10 15 11 12 13 14 17 18  8 16
> mo <- m$order
> # oo <- c(5,6,4,3,1,2,7,9,8,16,17,18,10,15,11,12,13,14)
> oo <- c(2,1,3,4,6,5,7,9,8,16,17,18,10,15,11,12,13,14)
> m$order <- oo
> plot(m,hang=-1,cex=1,main="Southern women: women / fractional / complete")
> # Events complete ---------------------------
> t <-hclust(1-disJ,method="complete")
> plot(t,hang=-1,cex=1,main="Southern women: events / Jaccard / complete")
> to <- t$order
> to
 [1] 11 13 14 10 12  6  3  5  4  1  2  7  8  9
> ot <- c(4,1,2,3,5,6,7,8,9,11,10,12,13,14)
> t$order <- ot
> plot(t,hang=-1,cex=1,main="Southern women: events / Jaccard / complete")
> # Partitions and permutations
> ph <- cutree(m,4)
> ph
   Evelyn     Laura   Theresa    Brenda Charlotte   Frances   Eleanor     Pearl      Ruth     Verne 
        1         1         1         1         1         1         1         2         1         3 
    Myrna Katherine    Sylvia      Nora     Helen   Dorothy    Olivia     Flora 
        3         3         3         3         3         2         4         4 
> pt <- cutree(t,3)
> pt
 E1  E2  E3  E4  E5  E6  E7  E8  E9 E10 E11 E12 E13 E14 
  1   1   1   1   1   1   2   2   2   3   3   3   3   3 
> r <- c(1,2,4,3)
> pm <- r[ph]
> pm
 [1] 1 1 1 1 1 1 1 2 1 4 4 4 4 4 4 2 3 3
> vector2clu(t$order,Clu="Events1.per")
> vector2clu(pt,Clu="Events1.clu")
> vector2clu(m$order,Clu="Ladies1.per")
> vector2clu(pm,Clu="Ladies1.clu")
> m$order
 [1]  2  1  3  4  6  5  7  9  8 16 17 18 10 15 11 12 13 14
> mt <- c(m$order,18+t$order) 
> mt
 [1]  2  1  3  4  6  5  7  9  8 16 17 18 10 15 11 12 13 14 22 19 20 21 23 24 25 26 27 29 28 30 31 32
> pmt <- c(pm,4+pt) 
> pmt
                                                                         E1  E2  E3  E4  E5  E6  E7 
  1   1   1   1   1   1   1   2   1   4   4   4   4   4   4   2   3   3   5   5   5   5   5   5   6 
 E8  E9 E10 E11 E12 E13 E14 
  6   6   7   7   7   7   7 
> vector2clu(mt,Clu="Davis1.per")
> vector2clu(pmt,Clu="Davis1.clu")
> 
> oM <- c(11,16,10,12,13,14,15,17,18,3,1,4,5,2,7,6,8,9) 
> pM <- c(2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1)
> oE <- c(4,1,2,3,5,6,7,8,9,12,10,13,14,11)
> pE <- c(1,1,1,1,1,1,2,2,2,3,3,3,3,3)
> pPE <- c(pM,2+pE) 
> oPE <- c(oM,18+oE) 
> pPE
 [1] 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 3 3 3 3 3 3 4 4 4 5 5 5 5 5
> oPE
 [1] 11 16 10 12 13 14 15 17 18  3  1  4  5  2  7  6  8  9 22 19 20 21 23 24 25 26 27 30 28 31 32 29
> vector2clu(oPE,Clu="DavisReg.per")
> vector2clu(pPE,Clu="DavisReg.clu")
> 


```
