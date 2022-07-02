# The Periplus of the Erythraean Sea
https://bora.uib.no/bora-xmlui/handle/1956/11470

Dataset for network analysis extracted from the ancient Greek text known as «The Periplus of the Erythraean Sea», containing lists of commodities and places (with geographical positions) mentioned in the text, and connections between them.

Compiled December 2014 by Eivind Heldaas Seland, Department of archaeology, history, cultural studies and religion,  University of Bergen, eivind.seland@uib.no

Greek text following Frisk, H. (1927). Le Périple de la Mer Érythrée - Suivi d'une étyde sur la tradition et la langue. Göteborgs Högskolas Årsskrift, 33(1), 1-145.

(Available also from http://stephanus.tlg.uci.edu/inst/asearch?uid=&mode=c_search&GreekFont=Unicode_All&aname=71 (subject to subscription))

English translations of commodities following Casson, Lionel. (1989). The Periplus Maris Erythraei. Princeton: Princeton University Press.

File created Feb. 9, 2016; format: CSV (comma separated values)

Columns contain id and labels for a two mode network of ports (id 1001-)  commodities (id 2001-) as well as for  directed edges between them  (columns labeled ‘source’ and ‘target’) and a set of nodes representing groups of commodities (2101-)

Dataset published under Creative Commons license 4.0: http://creativecommons.org/licenses/by/4.0



## Conversion into Pajek files

I copied the data from a given Dataset.csv into some files: places.csv, commod.csv, D.csv. Using R I created some auxiliary files 
```
> wdir <- "C:/Users/vlado/DL/data/2-mode/Periplus/periplus"
> setwd(wdir)
> P <- read.csv("places.csv",head=FALSE,sep=";")
> dim(P)
[1] 57  6
> head(P)
    V1               V2 V3         V4    V5    V6
1 1001      Myos Hormos NA   Emporion 34.14 26.90
2 1002         Berenike NA   Emporion 35.28 23.54
3 1003 Ptolemais Theron NA   Emporion 37.45 18.41
4 1004            Koloe NA      Polis 39.25 14.54
5 1005            Aksum NA Metropolis 38.43 14.08
6 1006           Adulis NA   Emporion 39.41 15.16
> C <- read.csv("commod.csv",head=FALSE,sep=";")
> dim(C)
[1] 112   6
> head(C)
    V1                                 V2    V3             V4                           V5   V6
1 2001                     Tortoise shell 3,4,6 Animal-product                              2001
2 2002                              Ivory   4,6 Animal-product                              2002
3 2003 Egyptian clothing for the Barbaroi     6        Textile Antagelig en samlebetegnelse 2111
4 2004                 Wraps from Arsinoe     6        Textile                              2111
5 2005           Colored cloaks (abollai)     6        Textile                              2111
6 2006                             Linens     6        Textile                              2111
> D <- read.csv("D.csv",head=FALSE,sep=";")
> dim(D)
[1] 31  2
> head(D)
    V1              V2
1 2111        Clothing
2 2112 Cotton-clothing
3 2113           Cloth
4 2114    Cotton-cloth
5 2115   Silk-products
6 2131           Glass
> N <- c(P$V1,C$V1)
> L <- c(P$V2,C$V2)
> length(N)
[1] 169
> nam <- file("periplus.nam","w")
> for(v in 1:length(N)) cat(N[v],' "',L[v],'"\n',sep='',file=nam)
> close(nam)
> xy <- file("xy.vec","w")
> for(v in 1:nrow(P)) cat(P$V5[v],' ',P$V6[v],'\n',sep='',file=xy)
> close(xy)
> K <- rep(0,2132)
> length(K)
[1] 2130
> g <- c(2001, 2002, 2028, 2030, 2032, 2044, 2054, 2055, 2070, 2072, 2079)
> g
 [1] 2001 2002 2028 2030 2032 2044 2054 2055 2070 2072 2079
> K[1001:1057] <- 1 # place
> K[2001:2110] <- 2 # commodity
> K[2111:2132] <- 4 # group
> K[g] <- 3 # commodity and group
> table(K)
K
   0    1    2    3    4 
1943   57   99   11   20 
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> vector2clu(K,Clu="modes.clu")
```
that I finally combined using Textpad into Pajek files:
* periplus.net - all networks combined as multirelational network
* xy.vec - positions of places
* modes.clu - modes of nodes
  * 0 - not in the Periplus network
  * 1 - places 1001:1057
  * 2 - commodities 2001:2110 
  * 3 - single commodity groups 2001, 2002, 2028, 2030, 2032, 2044, 2054, 2055, 2070, 2072, 2079
  * 4 - commodity groups 2111:2132

