# Reordering matrices considering clustering

July 2021
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
## Jaccard

```
> hm <- function(){
+    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,trace="none",density.info="none",
+       col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
+       main=paste("USSR ",Y[i]," / Jaccard / Ward",sep=""))
+ }

> i <- 6
> P <- SL[[i]]; diag(P) <- 0; diag(P) <- rowSums(P)
> J <- P; diag(J) <- 1; n = nrow(J)
> for(u in 1:(n-1)) for(v in (u+1):n) J[v,u] <- J[u,v] <- P[u,v]/(P[u,u]+P[v,v]-P[u,v])
> X <- J; X[P == 0] <- NA; diag(X) <- NA
> t <- hclust(as.dist(CorEu(J)),method="ward.D")
> hm()
> t$merge
> s <- t; t$merge <- flip(14,t$merge); hm()

> i <- 1
> t$merge <- flip(9,t$merge)
> i <- 2
> t$merge <- flip(9,t$merge)
> i <- 3
> t$merge <- flip(8,flip(9,flip(5,flip(12,t$merge))))
> i <- 4
> t$merge <- flip(6,flip(7,t$merge))
> i <- 5
> t$merge <- flip(5,flip(14,t$merge))
> i <- 6
> t$merge <- flip(5,flip(4,flip(7,flip(11,flip(6,flip(13,flip(12,flip(14,t$merge))))))))
```

# Flipping in large hierarhies

April 17, 2022

## transforming t$merge into sun2father tree vector

T[u] is the father of node u. T[root] = 0.
```
> toFather <- function(tm){
+   n <- nrow(tm); T <- rep(0,2*n+1)
+   for(i in 1:n){
+     for(j in 1:2){
+       p <- tm[i,j]
+       if(p<0) T[-p] <- i+n+1 else T[n+1+p] <- i+n+1
+     }
+   }
+   return(T)
+ }
```
For the t$merge from our example we get
```
> T <- toFather(t$merge)
> cbind(1:(2*n+1),T)
          T
 [1,]  1 27
 [2,]  2 17
 [3,]  3 21
 [4,]  4 18
 [5,]  5 17
 [6,]  6 22
 [7,]  7 22
 [8,]  8 16
 [9,]  9 16
[10,] 10 19
[11,] 11 19
[12,] 12 23
[13,] 13 23
[14,] 14 20
[15,] 15 24
[16,] 16 18
[17,] 17 20
[18,] 18 28
[19,] 19 25
[20,] 20 21
[21,] 21 27
[22,] 22 24
[23,] 23 25
[24,] 24 26
[25,] 25 26
[26,] 26 29
[27,] 27 28
[28,] 28 29
[29,] 29  0
```
## Minimum common cluster of nodes u and v
```
> minCl <- function(u,v,T){
+   if(min(u,v)==0) return(T[max(u,v)])
+   cat(u," ",v,":",T[u]," ",T[v],"\n")
+   if(u==v) return(u)
+   return( if(T[u]<T[v]) minCl(T[u],v,T) else minCl(u,T[v],T) ) 
+ }
```
For our example hierarchy we get
```
> minCl(8,2,T)
8   2 : 16   17 
16   2 : 18   17 
16   17 : 18   20 
18   17 : 28   20 
18   20 : 28   21 
18   21 : 28   27 
18   27 : 28   28 
18   28 : 28   29 
28   28 : 29   29 
[1] 28
```
and
```
> minCl(8,6,T)
8   6 : 16   22 
16   6 : 18   22 
18   6 : 28   22 
18   22 : 28   24 
18   24 : 28   26 
18   26 : 28   29 
28   26 : 29   29 
28   29 : 29   0 
[1] 29
```
