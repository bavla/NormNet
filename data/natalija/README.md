# Nataliya

We read in R the data from the file `UssrX2018.csv` and export it as Pajek net file `UssrX2018.net`
```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> setwd("C:/Users/batagelj/Documents/papers/2021/normNet/natalija")
> C <- read.csv2("UssrX2018.csv",header=FALSE,nrows=15,row.names=1)
> colnames(C) <- rownames(C)
> S <- as.matrix(C)
> matrix2net(S,Net="UssrX2018.net")
> S
           Azer Armen Belorus Estonia Georgia Kazah Kirgiz Latv Litva Moldav Russia Tadjik Turkmen Ukraina Uzbekistan
Azer        255   148     123       4     121    13      3    3     2      7    216      1       0      47          3
Armen       148   245     256     157     274    12     11  146   146      5    375      1       0     199         26
Belorus     123   256     269     167     269    19      1  158   191     10    642      2       0     211         25
Estonia       4   157     167     587     163    16     13  255   238      6    290      0       0     188         23
Georgia     121   274     269     163     114    12      7  150   151     10    302      2       0     175         29
Kazah        13    12      19      16      12   357     30    5    10      3    277      5       1      41         15
Kirgiz        3    11       1      13       7    30     17    3     6      2     40      3       1      13          6
Latv          3   146     158     255     150     5      3  242   342      4    302      0       0     289         23
Litva         2   146     191     238     151    10      6  342  1143      5    329      0       0     328         23
Moldav        7     5      10       6      10     3      2    4     5     37     44      2       0      11          3
Russia      216   375     642     290     302   277     40  302   329     44  23928     21       0     867         65
Tadjik        1     1       2       0       2     5      3    0     0      2     21     13       0       2          4
Turkmen       0     0       0       0       0     1      1    0     0      0      0      0       1       0          1
Ukraina      47   199     211     188     175    41     13  289   328     11    867      2       0    1649         32
Uzbekistan    3    26      25      23      29    15      6   23    23      3     65      4       1      32         72
```

We also compute in R the Jaccard normalization of the data. Here we have two possibilities:
* to consider the original diagonal (loop) weights - it seems that they count all internal collaborations (the diagonal entry in t(PC) * PC counts all collaborations). The diagonal weight for Russia (diag = 23928; rSum = 3770) is very large and most collaborations are inside Russia.
* to replace the diagonal weight with the row-sum of outdiagonal weights - it measures the collaboration with others. 
We selected the second option.

Last time we used Pajek to make this transformation (delete loops, vector/weighted outdegree, set diagonal). Here it is done in R:

```
> P <- S
> diag(P) <- 0
> diag(P) <- rowSums(P)
> matrix2net(P,Net="UssrX2018rsum.net")
> T <- cbind(diag(S),diag(P))
> colnames(T) <- c("S", "P")
> T
               S    P
Azer         255  691
Armen        245 1756
Belorus      269 2074
Estonia      587 1520
Georgia      114 1665
Kazah        357  459
Kirgiz        17  139
Latv         242 1680
Litva       1143 1771
Moldav        37  112
Russia     23928 3770
Tadjik        13   43
Turkmen        1    3
Ukraina     1649 2403
Uzbekistan    72  278
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

Applying the corrected Euclidean distance to Minimum matrix M
```
> Cm <- CorEu(M)
> t <- hclust(as.dist(Cm),method="ward.D")
> plot(t,hang=-1,cex=1,main="USSR 2018 corrEuclid min / Ward")
```
we obtain the clustering

![Ward clustering CorrEuclidean / Minimum](https://github.com/bavla/NormNet/blob/main/data/natalija/UssrX2018CeMinWard.png)


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
