# Analysis

```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> setwd("D:/vlado/docs/papers/2021/normNet/natalija/julij/res")
> CorEu <- function(W,p=1){
+    D <- W; diag(D) <- 0; n = nrow(D)
+    for(u in 1:(n-1)) for(v in (u+1):n) D[v,u] <- D[u,v] <- 
+       sqrt(sum((W[u,]-W[v,])**2) -
+       (W[u,u]-W[u,v])**2 - (W[v,u]-W[v,v])**2 +
+       p*((W[u,u]-W[v,v])**2 + (W[u,v]-W[v,u])**2)) 
+    return(D)
+ }

> N <- c("01-AZE", "02-ARM", "03-BLR", "04-EST", "05-GEO",
+        "06-KAZ", "07-KGZ", "08-LVA", "09-LTU", "10-MDA",
+        "11-RUS", "12-TJK", "13-TKM", "14-UKR", "15-UZB")
> Y <- c(1993,1998,2003,2008,2013,2018)
> SL <- vector("list",6)
> y <- paste("y",Y,sep="")
> names(SL) <- y

> for(i in 1:6){
+    fn <- paste("UssrX",Y[i],".csv",sep="")
+    C <- read.csv2(fn,header=FALSE,nrows=15,row.names=1)
+    colnames(C) <- rownames(C) <- N
+    SL[[i]] <- as.matrix(C)
+ }
```

```
> for(i in 1:6){
>    P <- SL[[i]]; diag(P) <- 0
>    D <- rowSums(P); T <- sum(D); n <- nrow(P)
>    for(u in 1:(n-1)) for(v in (u+1):n) P[u,v] <- P[v,u] <- P[u,v]*T/D[u]/D[v]
>    X <- Z <- log2(P)
>    Z[Z == -Inf] <- 0; X[X == -Inf] <- NA 
>    t <- hclust(as.dist(CorEu(Z)),method="ward.D")
> #   pdf(file=paste("test",Y[i],".pdf",sep=""),width=4,height=4)
>    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,col = bluered(100),na.color="yellow",
+       trace = "none", density.info = "none",
+       main=paste("USSR ",Y[i]," / log deviation / Ward",sep=""))
>    ans <- readline("Press Enter to continue >")
> #   dev.off()
> }
```

https://stackoverflow.com/questions/13081310/combining-multiple-complex-plots-as-panels-in-a-single-figure


```

```
