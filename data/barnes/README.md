# Barnes-Burkett elite affiliations (1962)

From https://icon.colorado.edu/

A small bipartite network of the affiliations among elite individuals (P) and the corporate, museum, university boards, or social clubs to which they belonged (C), from 1962.

R. Barnes and T. Burkett, "Structural redundancy and multiplicity in corporate networks." INSNA, Connections 30(2), 4-20 (2010)

Converted to Pajek format by Vladimir Batagelj - uvFac2Pajek Wed Sep 30 19:28:38 2026

```
> setwd("C:/data/2-mode/barnes/brunson_corporate-leadership")
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> T <- read.table("out.brunson_corporate-leadership_corporate-leadership",skip=2)
> dim(T)
[1] 99  2
> head(T)
  V1 V2
1  1  1
2  1  2
3  1  3
4  1  4
5  1  5
6  2  1
> u <- T$V1; v <- T$V2
> levels(u) <- paste0("P",1:max(u)) 
> levels(v) <- paste0("C",1:max(v))
> uvFac2net(u,v,Net="barnes.net",twomode=TRUE)
```
