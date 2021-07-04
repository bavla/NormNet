# International trade

## Example: WTO bilateral imports

### Markov / fractional normalization 

The data are available at https://data.wto.org/ .   Select: Indicators -> ''bilateral imports'' / ''by MTN product category'',  Reporting economies -> ''all'', Product / Sectors - Tariffs -> ''all'', Partner economies -> ''World'', Years -> 2015. Download the data as a CSV file (ZIPed).

```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> wdir <- "D:/vlado/docs/papers/2021/sunbelt/weighted/WTO"
> setwd(wdir)
> T <- read.csv("WtoData_2015.csv")
> head(T)
> dim(T)
[1] 12953    24
> select <- c("Reporting.Economy.Code","Reporting.Economy.ISO3A.Code","Reporting.Economy", 
+   "Product.Sector.Classification.Code","Product.Sector.Code","Product.Sector","Value")
> D <- T[,select]
> dim(D)
[1] 12953     7
> str(D)
'data.frame':   12953 obs. of  7 variables:
 $ Reporting.Economy.Code            : int  8 8 8 8 8 8 8 8 8 8 ...
 $ Reporting.Economy.ISO3A.Code      : Factor w/ 98 levels "AGO","ALB","ARG",..: 2 2 2 2 2 2 2 2 2 2 ...
 $ Reporting.Economy                 : Factor w/ 98 levels "Albania","Angola",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Product.Sector.Classification.Code: Factor w/ 2 levels "HS","MT2": 1 1 1 1 1 1 1 1 1 1 ...
 $ Product.Sector.Code               : int  1 102 10221 10229 103 10391 10392 104 10410 10420 ...
 $ Product.Sector                    : Factor w/ 144 levels "Aircraft, spacecraft, and parts thereof",..: 60 61 110 89 65 138 137 64 118 50 ...
 $ Value                             : num  28244292 7782188 1877 7780312 14451918 ...
> N <- D[D$Product.Sector.Classification.Code=="MT2",c("Reporting.Economy.ISO3A.Code","Product.Sector","Value")]
> dim(N)
[1] 2152    3 
> colnames(N) <- c("country","sector","value")
> head(N)
      country                     sector     value
10802     ALB            Animal products  94582547
10803     ALB             Dairy products  21316659
10804     ALB Fruits, vegetables, plants  89555265
10805     ALB                Coffee, tea  49130172
10806     ALB   Cereals and preparations 216237019
10807     ALB    Oilseeds, fats and oils  61945166
> nr <- length(levels(N$country)); nc<- length(levels(N$sector))
> nr
[1] 98
> nc
[1] 144
> B <- matrix(data=0,nrow=nr,ncol=nc,dimnames=list(levels(N$country),levels(N$sector)))
> for(i in 1:nrow(N)) B[as.integer(N$country[i]),as.integer(N$sector[i])] <- N$value[i]
> names <- levels(N$sector)
> names15 <- substr(names,1,15)
> colnames(B) <- names15
> C <- colSums(B)
> WT <- B[,C>0]
> head(WT)
> bimatrix2net(WT,Net="WTO.net")
```


### Logarithmic deviations 


```
> CS <- WT
> rc <- rowSums(CS)
> rs <- rowSums(CS)
> cs <- colSums(CS)
> Q <- CS
> T <- sum(CS)
> for(u in 1:nrow(CS)) for(v in 1:ncol(CS)) Q[u,v] <- a <- CS[u,v]*T/rs[u]/cs[v] 
> Q[1:10,1:6]
    Animal products Beverages and t Cereals and pre Chemicals   Clothing Coffee, tea
AGO      6.19495428       3.1551967       3.3830434 0.7592324 0.38627905  0.42462396
ALB      2.99177435       3.7933562       3.8066441 1.0521971 1.97721242  2.27520449
ARG      0.13749162       0.2837566       0.2627098 1.6878943 0.20946993  1.08378672
ARM      2.96630896       4.6968978       3.3916155 0.9958021 1.03770820  4.32938632
ATG      6.88000972       7.9406983       4.3178424 0.8335923 0.71457033  1.13616357
AUS      0.47035018       1.4343147       1.1952879 0.9546026 1.26319528  1.49425220
BDI      0.87589047       1.7722846       4.9828198 1.1981267 0.74819160  0.05355209
BEN     12.69107801       1.1871147      16.3540829 0.5793474 0.09022592  0.25625992
BFA      0.03680242       2.9665814       5.4862357 1.1746951 0.14761939  1.79271036
BHR      3.73243718       3.4220076       2.0807951 1.2472182 0.94455363  0.94500007
> Z <- log(Q)
> Z[Z == -Inf] <- 0
> t <- hclust(dist(Z),method="ward.D")
> plot(t,hang=-1,cex=0.5,main="WTO countries / deviation-log / Ward")
> f <- hclust(dist(t(Z)),method="ward.D")
> plot(f,hang=-1,cex=1,main="WTO sectors / deviation-log / Ward")
> 
> bimatrix2net(t(Z),Net="WTOlogdev.net")
> pC <- cutree(t,4)
> vector2clu(t$order,Clu="WTOlogdevC.per")
> vector2clu(pC,Clu="WTOlogdevC.clu")
> pS <- cutree(f,4)
> vector2clu(f$order,Clu="WTOlogdevS.per")
> vector2clu(pS,Clu="WTOlogdevS.clu")
> rownames(SC)
 [1] "Animal products" "Beverages and t" "Cereals and pre" "Chemicals"       "Clothing"       
 [6] "Coffee, tea"     "Cotton"          "Dairy products"  "Electrical mach" "Fish and fish p"
[11] "Fruits, vegetab" "Leather, footwe" "Manufactures n." "Minerals and me" "Non-electrical "
[16] "Oilseeds, fats " "Other agricultu" "Petroleum"       "Sugars and conf" "Textiles"       
[21] "Transport equip" "Wood, paper, et"
> cot <- SC[7,]
> scot <- sort(cot)
> head(scot)
     CAF      LAO      MAC      SLE      SUR      UGA 
  0.0000   0.0000   0.0000   0.0000  62.4901 770.1000 
> tail(scot,10)
       CHT        MEX        EEC        IND        KOR        PAK        THA        IDN        TUR 
 307219500  343451321  377776544  394102448  485391882  546190127  549158614 1088290181 1241859599 
       CHN 
2653891735 
>
```

{{notes:net:pics:wtodevlogc.png}}

{{notes:net:pics:wtodevlogs.png}}

In Pajek we read the network and both permutations. We fuse the permutations and display the network as a matrix.

{{notes:net:pics:wtodevmat.pdf}}

