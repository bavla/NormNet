# Jester joke ratings 100 (2001)
From https://icon.colorado.edu/networks

Two bipartite networks of users (U) and jokes (J), extracted from the online joke recommender system Jester. A user connects to all jokes for which that user entered a rating. Edge weights give the rating score,
scaled from -10 to +10. The two files differ by how many joke nodes are included, 100 or 150.

K. Goldberg et al. "Eigentaste: A constant time collaborative filtering algorithm." Information Retrieval 4(2), 133-151 (2001)

Converted to Pajek format by Vladimir Batagelj - uvFac2Pajek Wed Sep 30 20:08:48 2026

```
> setwd("C:/data/2-mode/jester/jester1")
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> T <- read.table("out.jester1",skip=2)
> dim(T)
> head(T)
> u <- T$V1; v <- T$V2; w <- T$V3
> levels(u) <- paste0("U",1:max(u))
> levels(v) <- paste0("J",1:max(v))
> uvFac2net(u,v,w,Net="jester.net",twomode=TRUE)
```
