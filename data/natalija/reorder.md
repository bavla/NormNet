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
Cluster 1 contains units 12 and 13. Cluster 3 contains unit 10 and cluster 1. ...

![Initial ordering](https://github.com/bavla/NormNet/blob/main/data/natalija/logdev1.png)

The function `flip` interchanges subtrees in the cluster `k`. The left subtree becomes the right subtree, and the right subtree becomes the left subtree. Using  flips we can reorder the rows and columns of network matrix preserving the hierarchical clustering structure.
```
> flip <- function(k,T) {t <- T[k,1]; T[k,1] <- T[k,2]; T[k,2] <- t; return(T)}
> s <- t; t$merge <- flip(13,t$merge); hm()
```
The variable `s` is used to recover after a wrong flip.

![After flip ordering](https://github.com/bavla/NormNet/blob/main/data/natalija/logdev2.png)

## Logarithmic deviations

```
> i <- 1
> t$merge <- flip(6,flip(8,flip(7,flip(12,flip(13,flip(14,t$merge))))))
> t$merge <- flip(1,flip(4,flip(10,flip(9,flip(5,t$merge)))))
> i <- 2
> t$merge <- flip(7,flip(8,flip(12,flip(14,t$merge))))
> i <- 3
> t$merge <- flip(9,flip(10,flip(12,flip(2,flip(11,flip(14,t$merge))))))
> i <- 4
> t$merge <- flip(4,flip(6,flip(2,flip(8,t$merge))))
> t$merge <- flip(1,flip(6,flip(2,flip(10,flip(11,flip(13,t$merge))))))
> i <- 5
> t$merge <- flip(7,flip(9,t$merge))
> t$merge <- flip(6,flip(10,flip(2,flip(8,t$merge))))
> i <- 6
> t$merge <- flip(12,flip(8,flip(10,t$merge)))
> t$merge <- flip(5,flip(6,flip(12,flip(13,t$merge))))
```

## Stochastic normalization

```
> hm <- function(){
+    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,trace="none",density.info="none",
+       col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
+       main=paste("USSR ",Y[i]," / stochastic / Ward",sep=""))
+ }
> i <- 6
> Z <- SL[[i]]; diag(Z) <- 0
> D <- rowSums(Z); n <- nrow(Z)
> for(u in 1:n) Z[u,] <- Z[u,]/D[u]
> X <- Z 
> X[Z == 0] <- NA 
> t <- h <- hclust(as.dist(CorEu(Z)),method="ward.D")
> hm()
> t$merge

> s <- t; t$merge <- flip(13,t$merge); hm()

> i <- 1
> t$merge <- flip(3,flip(5,flip(1,flip(8,flip(11,flip(14,t$merge))))))
> i <- 2
> t$merge <- flip(6,flip(8,flip(11,flip(7,flip(12,t$merge)))))
> i <- 3
> t$merge <- flip(5,flip(2,flip(4,flip(7,t$merge))))
> t$merge <- flip(8,flip(11,flip(12,t$merge)))
> i <- 4
> t$merge <- flip(12,t$merge)
> i <- 5
> t$merge <- flip(2,flip(5,flip(6,flip(11,flip(14,flip(8,t$merge))))))
> i <- 6
> t$merge <- flip(6,flip(11,flip(13,t$merge)))
```

```

```
