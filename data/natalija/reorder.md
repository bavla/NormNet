# Reordering matrices considering clustering

```
> hm <- function(){
+    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,col = bluered(100),na.color="yellow",
+       trace = "none", density.info = "none",
+       main=paste("USSR ",Y[i]," / log deviation / Ward",sep=""))
+ }
> 
> i <- 3
> P <- SL[[i]]; diag(P) <- 0
> D <- rowSums(P); T <- sum(D); n <- nrow(P)
> for(u in 1:(n-1)) for(v in (u+1):n) P[u,v] <- P[v,u] <- P[u,v]*T/D[u]/D[v]
> X <- Z <- log2(P)
> Z[Z == -Inf] <- 0; X[X == -Inf] <- NA 
> h <- t <- hclust(as.dist(CorEu(Z)),method="ward.D")
> hm()
> t$merge
      [,1] [,2]
 [1,]  -12  -13
 [2,]   -1   -5
 [3,]  -10    1
 [4,]   -4   -8
 [5,]   -7  -15
 [6,]   -9    4
 [7,]    2    3
 [8,]    5    7
 [9,]   -3  -14
[10,]   -2   -6
[11,]  -11    8
[12,]    9   10
[13,]   11   12
[14,]    6   13
```
![Initial ordering](https://github.com/bavla/NormNet/blob/main/data/natalija/logdev1.png)
```
> flip <- function(k,T) {t <- T[k,1]; T[k,1] <- T[k,2]; T[k,2] <- t; return(T)}
> s <- t; t$merge <- flip(13,t$merge); hm()
```
![After flip ordering](https://github.com/bavla/NormNet/blob/main/data/natalija/logdev2.png)

```

```

```

```

```

```
