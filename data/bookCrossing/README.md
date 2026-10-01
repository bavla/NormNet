# bookCrossing ratings (2005)

From https://icon.colorado.edu/

Two bipartite networks representing people and the books they have interacted with, from the BookCrossing website. Nodes represent users and books, and an edge connects
a user to a book they have interacted with. The file book_implicit is unweighted; edge weights in book_ratings give the rating a user assigned to a book.

C. Ziegler et al. "Improving recommendation lists through topic diversification."  Proc. 14th Internat. Conf. on World Wide Web (WWW 2005).

Converted to Pajek format by Vladimir Batagelj - uvFac2Pajek Thu Oct  1 03:06:17 2026

```
> setwd("C:/data/2-mode/bookCrossing/bookcrossing_full-rating")
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> T <- read.table("out.bookcrossing_full-rating_full-rating",skip=2)
> dim(T)
> head(T)
> u <- T$V1; v <- T$V2
> levels(u) <- paste0("U",1:max(u))
> levels(v) <- paste0("B",1:max(v))
> date()
[1] "Thu Oct  1 03:06:16 2026"
> uvFac2net(u,v,Net="bookCrossing.net",twomode=TRUE)
> date()
[1] "Thu Oct  1 03:07:00 2026"
```
