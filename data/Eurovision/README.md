# Eurovision 2022

https://eurovisionworld.com/eurovision/2022

```
> wdir <- "C:/Users/vlado/docs/papers/2022/sreda/1322/data"; setwd(wdir)
> R <- read.delim("Eurovision2022.csv",skip=1,row.names=1)
> dim(R)
> SC <- as.matrix(R[,2:41])
> SC[is.na(SC)] <- 0; m <- ncol(SC)
> rn <- rownames(SC); cn <- colnames(SC)
> # Corrected Euclidean distance 
> Ce <- matrix(0,nrow=m,ncol=m)
> rownames(Ce) <- colnames(Ce) <- cn
> for(v in 1:(m-1)) for(z in (v+1):m) {
+    ss <- sum((SC[,v]-SC[,z])**2) 
+    if((cn[v] %in% rn)&&(cn[z] %in% rn)) ss <- ss - 2*SC[cn[z],v]*SC[cn[v],z] 
+    Ce[v,z] <- Ce[z,v] <- sqrt(ss) 
+ }
> Dce <- as.dist(Ce)
> te <- hclust(Dce,method="ward.D")
> plot(te,hang=-1,cex=1,main="Eurovision 2022 / Corrected Euclidean / Ward")
> # Corrected Salton
> Co <- crossprod(SC)
> for(v in 1:(m-1)) for(z in (v+1):m) {
+    if((cn[v] %in% rn)&&(cn[z] %in% rn)) Co[v,z] <- Co[z,v] <- Co[z,v] + SC[cn[z],v]*SC[cn[v],z]
+ }
> S <- Co; diag(S) <- 1
> for(v in 1:(m-1)) for(z in (v+1):m) S[v,z] <- S[z,v] <- Co[v,z]/sqrt(Co[v,v]*Co[z,z])
> Dcs <- as.dist(1-S)
> ts <- hclust(Dcs,method="ward.D")
> plot(ts,hang=-1,cex=1,main="Eurovision 2022 / Salton / Ward")
> # export Salton to Pajek
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> matrix2net(S,Net="Salton.net")
```
