# Nataliya

We read in R the data from the file `UssrX2018.csv` and export it as Pajek net file `UssrX2018.net`
```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> setwd("C:/Users/batagelj/Documents/papers/2021/normNet/natalija")
> C <- read.csv2("UssrX2018.csv",header=FALSE,nrows=15,row.names=1)
> colnames(C) <- rownames(C)
> S <- as.matrix(C)
> matrix2net(S,Net="UssrX2018.net")
```

We also compute in R the Jaccard normalization of the data. Here we have two possibilities:
* to consider the original diagonal (loop) weights - they count all collaborations (also internal). The diagonal weight for Russia (diag = 23928; rSum = 3770) is very large and most collaborations are inside Russia.
* to replace the diagonal weight with the row-sum of outdiagonal weights - it measures the collaboration with others. 
We selected the second option.

Last time we used Pajek to make this transformation (delete loops, vector/weighted outdegree, set diagonal). Here it is done in R:

```
> P <- S
> diag(P) <- 0
> diag(P) <- rowSums(P)
> matrix2net(P,Net="UssrX2018rsum.net")
```
The corrected network is saved as Pajek file `UssrX2018rsum.net`.

We compute in R also the Jaccard similarity weights J and save the network as Pajek file `Jaccard2018.net`.
```
> J <- P
> n = nrow(J)
> for(u in 1:n) for(v in 1:n) J[u,v] <- P[u,v]/(P[u,u]+P[v,v]-P[u,v])
> matrix2net(J,Net="Jaccard2018.net")
```
Using the Jaccard similarity we can now cluster the countries. For clustering we have to select a dissimilarity D between countries. There are different options. The simplest one is to convert Jaccard similarity to a dissimilarity (Jaccard distance) using the transformation D = 1 - J.
```
> D <- as.dist(1-J)
> t <- hclust(D,method="ward.D")
> plot(t,hang=-1,cex=1,main="USSR 2018 / Ward")
```
we get

![Ward clustering Jaccard](https://github.com/bavla/NormNet/blob/main/data/natalija/UssrX2018JacWard.png)

Another option is to read `Jaccard2018.net` in Pajek, compute corrected Euclidean distance for its nodes and make a clustering.

## Minimum normalization

Instead of Jaccard normalization we could use some other normalization - for example the geometric G[u,v] = P[u,v]/sqrt(P[u,u] * P[v,v]). Here we will look at the results for the minimum normalization M[u,v] = P[u,v]/min(P[u,u],P[v,v]). 
```
> M <- P
> n = nrow(M)
> for(u in 1:n) for(v in 1:n) M[u,v] <- P[u,v]/min(P[u,u],P[v,v])
> matrix2net(M,Net="Min2018.net")
> t <- hclust(as.dist(1-M),method="ward.D")
> plot(t,hang=-1,cex=1,main="USSR 2018 min / Ward")
```
![Ward clustering Minimum](https://github.com/bavla/NormNet/blob/main/data/natalija/UssrX2018minWard.png)

## Corrected Euclidean distance

We can also compare countries using rows of Jaccard matrix as their description and measure their dissimilarity using corrected Euclidean distance.

```
> CorEu <- function(W,p=1){
+    D <- W
+    n = nrow(D)
+    for(u in 1:n) for(v in 1:n) D[u,v] <- sqrt(sum((W[u,]-W[v,])**2) -
+       (W[u,u]-W[u,v])**2 - (W[v,u]-W[v,v])**2 +
+       p*((W[u,u]-W[v,v])**2 + (W[u,v]-W[v,u])**2)) 
+    return(D)
+ }
> Ce <- CorEu(J)
> t <- hclust(as.dist(Ce),method="ward.D")
> plot(t,hang=-1,cex=1,main="USSR 2018 corrEuclid / Ward")
```
![Ward clustering CorrEuclidean / Jaccard](https://github.com/bavla/NormNet/blob/main/data/natalija/UssrX2018CeJacWard.png)


## Mail

Based on Vlado code I try to create Jacard network in R (see the code below) and than I create dendrogram in Pajek with dissimillarity p=0 (Jacard.eps) and p=1 (Jacard1.eps).
Both dendro slightly different from your example (https://github.com/bavla/NormNet/blob/main/data/natalija/dendroJeu.pdf). In my case Kazakhstan and Azerbaijan are together, in your — are’t. 
Could you please look on my network? What have I done incorrect? 
 
I have also prepared nets for another years, but I concern about it due to divergence with your dendroJeu for 2018.

```
source("S:/natalija/Pajek.R")
setwd("S:/natalija")
C <- read.csv2("UssrX2018.csv",header=FALSE,nrows=15,row.names=1)
colnames(C) <- rownames(C)
S <- as.matrix(C)
matrix2net(S,Net="UssrX2018.net")
# replaced in Pajek diagonals with out-diagonal sums
#Z <- net2matrix("UssrX2018S.net")
Z <- C
n = nrow(Z)
for (k in 1:n) {
  Z[n,n] <- 0
  Z[n,n] <- sum(Z[n,])
}  
J <- Z
n = nrow(Z)
for(u in 1:n) for(v in u:n) J[u,v] <- Z[u,v]/(Z[u,u]+Z[v,v]-Z[u,v])
matrix2net(J,Net="Jaccard2018.net")
```
