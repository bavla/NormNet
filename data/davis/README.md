# Davis Southern Women network

![Davis SW net 1](https://github.com/bavla/NormNet/blob/main/data/davis/DGG1.png)

![Davis SW net 1](https://github.com/bavla/NormNet/blob/main/data/davis/DGG2.png)

```
> wdir <- "C:/Users/batagelj/Documents/papers/2021/twoMode/data/davis"
> setwd(wdir)
> D <- net2matrix("davis.net")
> D
> DT <- t(D)
> DT
> S <- rowSums(DT)
> N <- rowNorms(DT,type='other',scale=ifelse(S>0,S,1))
> dim(N)
[1] 14 18
> P <- crossprod(N)
> P
> matrix2net(P,Net="ladies.net")
> B <- N %*% t(b(N))
> J <- 1/(1/B + 1/t(B) - 1)
> dim(J)
[1] 14 14
> matrix2net(J,Net="events.net")

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



```
