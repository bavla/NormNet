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

![Matrix / Log Deviations / Countries](https://github.com/bavla/NormNet/blob/main/data/WTO/WTOdevlogC.png)

![Matrix / Log Deviations / Sectors](https://github.com/bavla/NormNet/blob/main/data/WTO/WTOdevlogS.png)


In Pajek we read the network and both permutations. We fuse the permutations and display the network as a matrix.

![Matrix / Log Deviations / Matrix](https://github.com/bavla/NormNet/blob/main/data/WTO/WTOdevMat.pdf)
{{notes:net:pics:wtodevmat.pdf}}

## Example: WTO annual marchandise export by product group (Million US dollar) 

The data are available at https://data.wto.org/ .   Select: Indicators -> ''International trade statistics'',  Reporting economies -> ''all'', Product / Sectors - Tariffs -> ''all'', Partner economies -> ''World'', Years -> 2015. Download the data as a CSV file (ZIPed).


```
> wdir <- "D:/vlado/docs/papers/2021/sunbelt/weighted/exp"
> setwd(wdir)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> b <- function(A,cut=0){ return(matrix(as.numeric(A>cut),nrow=nrow(A),dimnames=dimnames(A))) }
> T <- read.csv("WtoData_2015exp.csv")
> dim(T)
[1] 79348    24
> str(T)
'data.frame':   79348 obs. of  24 variables:
 $ Indicator.Category                : Factor w/ 3 levels "Merchandise trade - indices and prices",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Indicator.Code                    : Factor w/ 38 levels "ITS_CS_AM6","ITS_CS_AX6",..: 11 11 11 11 11 11 11 11 11 11 ...
 $ Indicator                         : Factor w/ 38 levels "Commercial services exports by main sector ...",..: 27 27 27 27 27 27 27 27 27 27 ...
 $ Reporting.Economy.Code            : Factor w/ 262 levels "000","004","008",..: 1 2 3 4 5 7 8 9 10 11 ...
 $ Reporting.Economy.ISO3A.Code      : Factor w/ 216 levels "","ABW","AFG",..: 1 3 6 59 11 4 12 15 9 13 ...
 $ Reporting.Economy                 : Factor w/ 262 levels "Afghanistan",..: 257 1 5 6 7 10 12 22 13 19 ...
 $ Partner.Economy.Code              : int  0 0 0 0 0 0 0 0 0 0 ...
 $ Partner.Economy.ISO3A.Code        : logi  NA NA NA NA NA NA ...
 $ Partner.Economy                   : Factor w/ 1 level "World": 1 1 1 1 1 1 1 1 1 1 ...
 $ Product.Sector.Classification.Code: Factor w/ 2 levels "BOP6","SITC3": 2 2 2 2 2 2 2 2 2 2 ...
 $ Product.Sector.Classification     : Factor w/ 2 levels "Merchandise - SITC Revision 3 (aggregates)",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Product.Sector.Code               : Factor w/ 187 levels "AG","AGFO","GS",..: 187 187 187 187 187 187 187 187 187 187 ...
 $ Product.Sector                    : Factor w/ 180 levels "Accommodation services",..: 170 170 170 170 170 170 170 170 170 170 ...
 $ Period.Code                       : Factor w/ 17 levels "A","M01","M02",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Period                            : Factor w/ 17 levels "Annual","April",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Frequency.Code                    : Factor w/ 3 levels "A","M","Q": 1 1 1 1 1 1 1 1 1 1 ...
 $ Frequency                         : Factor w/ 3 levels "Annual","Monthly",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Unit.Code                         : Factor w/ 8 levels "APC","ID0501",..: 5 5 5 5 5 5 5 5 5 5 ...
 $ Unit                              : Factor w/ 8 levels "% change over previous month",..: 8 8 8 8 8 8 8 8 8 8 ...
 $ Year                              : int  2015 2015 2015 2015 2015 2015 2015 2015 2015 2015 ...
 $ Value.Flag.Code                   : Factor w/ 2 levels "","E": 1 1 1 1 1 1 1 1 1 1 ...
 $ Value.Flag                        : Factor w/ 2 levels "","Estimate": 1 1 1 1 1 1 1 1 1 1 ...
 $ Text.Value                        : logi  NA NA NA NA NA NA ...
 $ Value                             : num  87.6 99.9 82.4 88.3 110.5 ...
> select <- c("Reporting.Economy.ISO3A.Code","Reporting.Economy","Product.Sector.Code","Product.Sector","Value")
> D <- T[,select]
> dim(D)
[1] 79348     5
> N <- D[,c("Reporting.Economy.ISO3A.Code","Product.Sector","Value")]
> colnames(N) <- c("country","sector","value")
> nr <- length(levels(N$country)); nc<- length(levels(N$sector))
> nr
[1] 216
> nc
[1] 180
> B <- matrix(data=0,nrow=nr,ncol=nc,dimnames=list(levels(N$country),levels(N$sector)))
> for(i in 1:nrow(N)) B[as.integer(N$country[i]),as.integer(N$sector[i])] <- N$value[i]
> names15 <- substr(levels(N$sector),1,15)
> names <- levels(N$sector)
> names15
  [1] "Accommodation s" "Accounting, aud" "Acquisition of " "Advertising ser" "Advertising, ma"
  [6] "Agricultural pr" "Air transport"   "Architectural s" "Architectural, " "Artistic relate"
 [11] "Audio-visual se" "Audiovisual and" "Audiovisual pro" "Automotive prod" "Auxiliary insur"
...
[171] "Tourism-related" "Trade-related s" "Trademarks"      "Transport"       "Transport equip"
[176] "Travel"          "Underwriting an" "Waste treatment" "Waste treatment" "Work undertaken"
> C <- colSums(B)
> sum(C>0)
[1] 180
> names[60:64]
[1] "Goods for processing abroad - Goods sent , Goods r" "Goods for processing in reporting economy – Goods "
[3] "Gross freight insurance claims receivable (credits" "Gross freight insurance premiums receivable (credi"
[5] "Gross life insurance claims receivable (credits) a"
> names15[60] <- "Goods 4 abroad"
> names15[61] <- "Goods 4 inside"
> names15[62] <- "GFI claims"
> names15[63] <- "GFI premiums"
> names15[64] <- "GLI claims"
> names15[65] <- "GLI premiums"
> names15[66] <- "GODI claims"
> names15[67] <- "GODI premiums"
> names15[80] <- "LRD audio-vis"
> names15[81] <- "LRD computer"
> names15[82] <- "LRD other"
> names[105:107]
[1] "Of which: payable by border, seasonal, and other s" "Of which: Payable by border, seasonal, and other s"
> names15[111] <- "Other -postal"
> names15[120] <- "Other BS"
> names15[121] <- "Other BS n.i.e."
> names15[123] <- "Other CS"
> names15[124] <- "Other CS -CC"
> names15[128] <- "Other PS"
> names15[129] <- "Other PCRS"
> names15[160] <- "Serv agricultur"
> names15[161] <- "Serv mining"
> names15[166] <- "Tele equipment"
> names15[167] <- "Tele services"
> names15[168] <- "Tele computer"
> names15[179] <- "Waste agricult"
> colnames(B) <- names15
> dim(B)
[1] 216 180
> bimatrix2net(B,Net="WTO_2015exp.net")
```

```
> CS <- B
> rs <- rowSums(CS)
> cs <- colSums(CS)
> Q <- CS
> T <- sum(CS)
> for(u in 1:nrow(CS)) for(v in 1:ncol(CS)) Q[u,v] <- a <- CS[u,v]*T/rs[u]/cs[v] 
> Z <- log(Q)
Warning message: In log(Q) : NaNs produced
> Z[Z == -Inf] <- 0
> Z[is.nan(Z)] <- 0
> t <- hclust(dist(Z),method="ward.D")
> plot(t,hang=-1,cex=0.3,main="WTO countries export / log-deviation / Ward")
> f <- hclust(dist(t(Z)),method="ward.D")
> plot(f,hang=-1,cex=0.3,main="WTO sectors export / log-deviation / Ward")
> 
> bimatrix2net(t(Z),Net="WTOexplogdev.net")
> pC <- cutree(t,4)
> vector2clu(t$order,Clu="WTOexplogdevC.per")
> vector2clu(pC,Clu="WTOexplogdevC.clu")
> pS <- cutree(f,4)
> vector2clu(f$order,Clu="WTOexplogdevS.per")
> vector2clu(pS,Clu="WTOexplogdevS.clu") 
```
