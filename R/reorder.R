> #  https://github.com/bavla/NormNet/blob/main/data/natalija/reorder.md
> #

> CorEu <- function(W,p=1){
+    D <- W; diag(D) <- 0; n = nrow(D)
+    for(u in 1:(n-1)) for(v in (u+1):n) D[v,u] <- D[u,v] <- 
+       sqrt(sum((W[u,]-W[v,])**2) -
+       (W[u,u]-W[v,u])**2 - (W[u,v]-W[v,v])**2 +
+       p*((W[u,u]-W[v,v])**2 + (W[u,v]-W[v,u])**2)) 
+    return(D)
+ }

> minCl <- function(u,v,T){
+   if(min(u,v)==0) return(T[max(u,v)])
+   # cat(u," ",v,":",T[u]," ",T[v],"\n")
+   if(u==v) return(u)
+   return( if(T[u]<T[v]) minCl(T[u],v,T) else minCl(u,T[v],T) ) 
+ }

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

> flip <- function(k,T) {t <- T[k,1]; T[k,1] <- T[k,2]; T[k,2] <- t; return(T)}


> # T <- toFather(t$merge)
> # n <- nrow(t$merge)+1
> # s <- t; t$merge <- flip(minCl(8,2,T)-n,t$merge); hm()



