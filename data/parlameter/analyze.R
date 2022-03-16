> wdir <- "D:/vlado/data/signed/parlament"
> setwd(wdir)
> library(gplots)

> recode <- function(T,p,n,a,r,z){
+   A <- matrix(NA,nrow=nrow(T),ncol=ncol(T))
+   dimnames(A) <- list(rownames(T),colnames(T))
+   A[T=="p"] <- p; A[T=="n"] <- n; A[T=="a"] <- a; A[T=="r"] <- r; A[T=="z"] <- z
+   return(A)
+ }

> M <- read.table('votes.mat',row.names=NULL)
> ZI <- read.csv(file="zakoni.csv")

> T <- as.matrix(M[,2:108])
> As <- recode(T,1,-1,0,0,0)
> Cs <- crossprod(As)

# Salton

> d <- sqrt(diag(Cs))
> Cos <- diag(1/d) %*% Cs %*% diag(1/d)
> colnames(Cos) <- rownames(Cos) <- colnames(As)
> Dcos <- (1-Cos)/2
> diag(Dcos) <- 0
> disDc <- as.dist(Dcos,diag=FALSE,upper=FALSE)
> t <-hclust(disDc,method="complete")
> plot(t,hang=-1,cex=0.7,main="Slovenian parliament - Salton / Complete")
> heatmap.2(Cos,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,col = bluered(100),na.color="yellow",
+       trace = "none", density.info = "none",
+       main="Slovenian parliament - Salton / Complete",cexRow=0.5,cexCol=0.5)

> # Jaccard
> Ap <- recode(T,1,0,0,0,0) 
> An <- recode(T,0,1,0,0,0) 
> U <- crossprod(Ap)+crossprod(An)
> # sort(diag(U))
> m <- nrow(U)
> E <- matrix(1,nrow=m,ncol=m)
> J <- U / (diag(diag(U)) %*% E + E %*% diag(diag(U)) - U)
> matrix2net(J,Net="Jaccard.net")
> disJ <- as.dist(1-J,diag=FALSE,upper=FALSE)
> g <-hclust(disJ,method="complete")
> plot(g,hang=-1,cex=1,main="Slovenian parliament - Jaccard / Complete")

# Manhattan-Jaccard

> n <- ncol(As); m <- nrow(As)
> D <- matrix(1,nrow=n,ncol=n)
> colnames(D) <- rownames(D) <- colnames(As)
> w <- rep(1,m); P <- As
> MJ <- function(x,y) sum(w*abs(x-y))/sum(abs(x)+abs(y)>0)
> for(i in 1:(n-1)) for(j in (i+1):n) D[i,j] <- D[j,i] <- MJ(P[,i],P[,j])
> diag(D) <- 0
> disD <- as.dist(D,diag=FALSE,upper=FALSE)
> tm <-hclust(disD,method="complete")
> plot(tm,hang=-1,cex=0.7,main="Slovenian parliament - Manhattan-Jaccard / weighted / Complete")
