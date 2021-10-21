# Analysis

## Read networks, relabel

First, we read all 6 network matrices into a list SL. For easier description of manual reorderings we change the country labels by adding indices.
```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> library(gplots)
> setwd("D:/vlado/docs/papers/2021/normNet/natalija/julij/res")
> CorEu <- function(W,p=1){
+    D <- W; diag(D) <- 0; n = nrow(D)
+    for(u in 1:(n-1)) for(v in (u+1):n) D[v,u] <- D[u,v] <- 
+       sqrt(sum((W[u,]-W[v,])**2) -
+       (W[u,u]-W[v,u])**2 - (W[u,v]-W[v,v])**2 +
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
## Logarithmic deviations

I searched on Google for this measure. It turned out that it is known in economics as "Balassa index" (1965) or "Revealed comparative advantage". See

* https://en.wikipedia.org/wiki/Revealed_comparative_advantage
* https://wits.worldbank.org/wits/wits/witshelp/Content/Utilities/e1.trade_indicators.htm
   
Also, the logarithmic transformation was already proposed by Vollrath (1991)

* https://link.springer.com/article/10.1007%2FBF02707986
* https://www.researchgate.net/publication/314570988_Net_Comparative_Advantage_Index_Overcoming_the_Drawbacks_of_the_Existing_Indices

When applying the approach to one-mode network it is important to use a corrected dissimilarity measure - for example corrected Euclidean.

Display network matrices reordered according to the corrsponding dendrogram for all six years.
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
>    ans <- readline(paste(i,". Press Enter to continue >",sep=""))
> #   dev.off()
> }
```
I used the log2 transformation - easy interpretation. 

I tried to save the produced pictures using `pdf / dev.off` but the results were not as expected - problems with the sizes of text, etc. So, I decided to stop after the display of each picture, manually save it, and continue to the next. Finally I combined the obtained pictures into a single picture using `Inkscape`. See

https://github.com/bavla/NormNet/blob/main/data/natalija/logdev.pdf

I also tried to combine all six pictures on the same page using R ( `par(mfrow=c(2,3))` and `layout(matrix(c(1,2,3,4,5,6),2,3,byrow=TRUE))` ). It does not work because the procedure heatmap.2 is based in the library `gplots`. See

https://stackoverflow.com/questions/13081310/combining-multiple-complex-plots-as-panels-in-a-single-figure

Maybe once, when I will have too much time.

## Stochastic (Markov, Output) normalization

```
> for(i in 1:6){
+    Z <- P <- SL[[i]]; diag(Z) <- 0
+    D <- rowSums(Z); n <- nrow(Z)
+    for(u in 1:n) Z[u,] <- Z[u,]/D[u]
+    X <- Z 
+    X[Z == 0] <- NA 
+    t <- hclust(as.dist(CorEu(Z)),method="ward.D")
+    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,trace="none",density.info="none",
+       col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
+       main=paste("USSR ",Y[i]," / stochastic / Ward",sep=""))
+    ans <- readline(paste(i,". Press Enter to continue >",sep=""))
+ }
```

https://github.com/bavla/NormNet/blob/main/data/natalija/stoch.pdf

