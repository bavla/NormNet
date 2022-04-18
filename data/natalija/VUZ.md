# VUZ

* https://github.com/bavla/NormNet/tree/main/data/natalija
* http://vladowiki.fmf.uni-lj.si/doku.php?id=notes:clu:cluster
* https://github.com/bavla/Rnet/blob/master/R/Pajek.R

```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/NormNet/main/R/reorder.R")
> setwd("C:/Users/vlado/docs/papers/2022/natalija/data")
> C <- read.csv2("Vuz_2010.csv",header=TRUE,row.names=1)

> names <- c(
+  "Moscow_I_PhysTech",        "NRNU MEPhI",               "Novosibirsk_SU",          
+  "Peter_the_Great_PU",       "Tomsk_SU",                 "Altai_SU",                
+  "Baikal_SU",                "Bashkir_SU",               "Bashkir_SU_Med",          
+  "Bauman_Moscow_STU",        "Belgorod_STU",             "Belgorod_SU",             
+  "Bryansk_STU",              "Don_STU",                  "Dubna_SU",                
+  "StPetersburg_EuU",         "FarEastern_FU",            "UGRF_Fin",                
+  "Gubkin_RSU_OilGas",        "Herzen_RSPU",              "ImmanuelKant_BFU",        
+  "Irkutsk_NRTU",             "Irkutsk_SU",               "ITMO University",         
+  "Ivanovo_SU",               "Ivanovo_SU_ChemTech",      "Kadyrov_CSU",             
+  "Kazan_FU",                 "Kazan_NRTU",               "Krasnoyarsk_SU_Med",      
+  "Kuban_SU",                 "Lobachevsky_SU_NN",        "Mari_SU",                 
+  "Mendeleev_RUT_Chem",       "Minin_SU_Ped_NN",          "Mordovian_SU",            
+  "Moscow_AI",                "Moscow_IET",               "Moscow_PEI",              
+  "Moscow_STU_Stankin",       "Moscow_SU_CivEng",         "Moscow_SU_Edu",           
+  "Moscow_SU_IE.CS",          "Moscow_SU_MechEng",        "Moscow_SU_MedDent",       
+  "Moscow_SU_PsyEdu",         "NRU.HSE",                  "NU_SciTech",              
+  "New_Economic_School",      "NE_FU_Yakutsk",            "Mechnikov_NW_SU_Med",     
+  "NCaucasus_FU",             "NArctic_FU",               "Nosov_Magnitogorsk_STU",  
+  "Novosibirsk_SU_Med",       "Novosibirsk_SU_Ped",       "Novosibirsk_STU",         
+  "Omsk_STU",                 "Orel_SU",                  "Pavlov_SPetersburg_SU_Med",
+  "Penza_SU",                 "Peoples_Friendship_RU",    "Perm_NRPU",               
+  "Perm_SU",                  "Pirogov_RNRU_Med",         "Platov_SRSPU",            
+  "Plekhanov_RU_Econ",        "Polzunov_Altai_STU",       "Reshetnev_SSU_SciTech",   
+  "Russian_I_Theat",          "Russian_New_University",   "Russian_PA_NatEcon.PubAdm",
+  "Russian_SSU",              "Russian_SU_Hum",           "Ryazan_SU_Med",           
+  "SPetersburg_Mining_U",     "SPetersburg_SU_Elect",     "SPetersburg_SI_Tech",     
+  "SPetersburg_SU_CivAvi",    "Samara_NRU",               "Samara_SU_Med",           
+  "Saratov_SU",               "Sechenov_Moscow_SU_Med",   "Siberian_FU",             
+  "Skolkovo_I_SciTech",       "SUral_SU",                 "SW_RSUniversity",         
+  "SPetersburg_Academic_U",   "Stavropol_SU",             "Tambov_STU",              
+  "Togliatti_SU",             "Tomsk_PU",                 "Tomsk_SU_ContSys.RadEl",  
+  "Tver_STU",                 "Tver_SU",                  "Tyumen_SU",               
+  "Ufa_STU_Avi",              "Ufa_STU_Petro",            "Ulyanovsk_SU",            
+  "Ural_FU",                  "Volga_STU",                "Volgograd_STU",           
+  "Volgograd_SU",             "Voronezh_STU",             "Voronezh_SU",             
+  "Vyatka_SU",                "Yaroslavl_SU"                                      )    
> 

> colnames(C) <- rownames(C) <- names
> S1 <- as.matrix(C)
> matrix2net(S1,Net="Vuz_2010.net")

> C <- read.csv2("Vuz_2015.csv",header=TRUE,row.names=1)
> colnames(C) <- rownames(C) <- names
> S2 <- as.matrix(C)
> matrix2net(S2,Net="Vuz_2015.net")

> C <- read.csv2("Vuz_2020.csv",header=TRUE,row.names=1)
> colnames(C) <- rownames(C) <- names
> S3 <- as.matrix(C)
> matrix2net(S3,Net="Vuz_2020.net")

> save(S1,S2,S3,names,file="VUZ.RData")
```


```
> load("VUZ.RData")
```
## Draw network matrices / Jaccard

```
> P <- S3
> diag(P) <- 0
> diag(P) <- rowSums(P)
> J <- P; diag(J) <- 1
> n = nrow(J)
> for(u in 1:(n-1)) for(v in (u+1):n) J[v,u] <- J[u,v] <- P[u,v]/(P[u,u]+P[v,v]-P[u,v])
> # matrix2net(J,Net="Jaccard2018.net")
> Ce <- CorEu(J)
> t <- hclust(as.dist(Ce),method="ward.D")
> plot(t,hang=-1,cex=0.5,main="VUZ Jaccard / corrEuclid / Ward")

X <- S3 
diag(X) <- 0
X[X == 0] <- NA 
t <- hclust(as.dist(Ce),method="ward.D")
pdf(file = "VUZtest.pdf",width=16,height=18)
heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
  scale="none",revC=TRUE,trace="none",density.info="none",
  col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
  main=paste("VUZ ",2020," / Jaccard / Ward",sep=""),key=FALSE,keysize=1)
dev.off()

pdf(file = "VUZtest.pdf",width=18,height=18)
heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
  scale="none",revC=TRUE,trace="none",density.info="none",
  col=colorpanel(30,low="grey60",high="black"),na.color="white",      
  main=paste("VUZ ",2020," / Jaccard / Ward",sep=""),key=FALSE,keysize=1)
dev.off()

pdf(file = "VUZtest.pdf",width=20,height=20)
heatmap.2(Q,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
  scale="none",revC=TRUE,trace="none",density.info="none",
  col=colorpanel(4,low="grey60",high="black"),na.color="white",      
  main=paste("VUZ ",2020," / Jaccard / Ward",sep=""),key=FALSE,keysize=1)
dev.off()
```
## Recoded matrices

### Weights distribution
```

```
### Recoding
```
> P <- S3
> diag(P) <- 0
> table(P)
> Q <- P
> Q[P>=50] <- 4
> Q[(P>=10)&(P<50)] <- 3
> Q[(P>=5)&(P<10)] <- 2
> Q[(P>=1)&(P<5)] <- 1
> Q[Q == 0] <- NA 
> table(Q)
> pdf(file = "VUZ20heat.pdf",width=20,height=20)
> heatmap.2(Q,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+   scale="none",revC=TRUE,trace="none",density.info="none",
+   col=colorpanel(4,low="grey60",high="black"),na.color="white",      
+   main=paste("VUZ ",2020," / Jaccard / Ward",sep=""),key=FALSE,keysize=1)
> dev.off()

> P <- S2
> diag(P) <- 0
> table(P)
> Q <- P
> Q[P>=50] <- 4
> Q[(P>=10)&(P<50)] <- 3
> Q[(P>=5)&(P<10)] <- 2
> Q[(P>=1)&(P<5)] <- 1
> Q[Q == 0] <- NA 
> table(Q)
> pdf(file = "VUZ15heat.pdf",width=20,height=20)
> heatmap.2(Q,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+   scale="none",revC=TRUE,trace="none",density.info="none",
+   col=colorpanel(4,low="grey60",high="black"),na.color="white",      
+   main=paste("VUZ ",2015," / Jaccard / Ward",sep=""),key=FALSE,keysize=1)
> dev.off()

> P <- S1
> diag(P) <- 0
> table(P)
> Q <- P
> Q[P>=50] <- 4
> Q[(P>=10)&(P<50)] <- 3
> Q[(P>=5)&(P<10)] <- 2
> Q[(P>=1)&(P<5)] <- 1
> Q[Q == 0] <- NA 
> table(Q)
> pdf(file = "VUZ10heat.pdf",width=20,height=20)
> heatmap.2(Q,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+   scale="none",revC=TRUE,trace="none",density.info="none",
+   col=colorpanel(4,low="grey60",high="black"),na.color="white",      
+   main=paste("VUZ ",2010," / Jaccard / Ward",sep=""),key=FALSE,keysize=1)
> dev.off()
```
### Reordering

https://github.com/bavla/NormNet/blob/main/data/natalija/reorder.md#flipping-in-large-hierarhies

```
> source("./reorder.R")
> hm <- function(){
+   heatmap.2(Q,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+     scale="none",revC=TRUE,trace="none",density.info="none",
+     col=colorpanel(4,low="grey60",high="black"),na.color="white",      
+     main=paste("VUZ ",2020," / recoded / Ward",sep=""),key=FALSE,keysize=1)
+ }


> P <- S3
> diag(P) <- 0
> table(P)
> Q <- P
> Q[P>=50] <- 4
> Q[(P>=10)&(P<50)] <- 3
> Q[(P>=5)&(P<10)] <- 2
> Q[(P>=1)&(P<5)] <- 1
> Ce <- CorEu(Q)
> t <- hclust(as.dist(Ce),method="ward.D")
> plot(t,hang=-1,cex=0.5,main="VUZ recoded / corrEuclid / Ward")

> Q[Q == 0] <- NA 
> table(Q)
> # pdf(file = "VUZ20heatR.pdf",width=20,height=20)
> hm()
> # dev.off()

> T <- toFather(t$merge)
> n <- nrow(t$merge)+1
> s <- t; t$merge <- flip(minCl(89,94,T)-n,t$merge); hm()
> s <- t; t$merge <- flip(minCl(65,100,T)-n,t$merge); hm()
> s <- t; t$merge <- flip(minCl(77,6,T)-n,t$merge); hm()
> s <- t; t$merge <- flip(minCl(95,15,T)-n,t$merge); hm()
> s <- t; t$merge <- flip(minCl(43,7,T)-n,t$merge); hm()
> s <- t; t$order <- orDendro(t$merge,n-1)
> plot(t,hang=-1,cex=0.5,main="VUZ recoded / corrEuclid / Ward")
> s <- t; t$merge <- flip(minCl(97,107,T)-n,t$merge); hm()
> s <- t; t$merge <- flip(minCl(94,61,T)-n,t$merge); hm()

> pdf(file = "VUZ20heatRe.pdf",width=20,height=20)
> hm()
> dev.off()

> pdf(file = "VUZ20dendRe.pdf",width=18,height=10)
> s <- t; t$order <- orDendro(t$merge,n-1)
> plot(t,hang=-1,cex=0.5,main="VUZ recoded / corrEuclid / Ward")
> dev.off()

```

```

```

```

```

```

```
# To do

* Let v(C) be a property of a cluster C. For example, v(C) = average of row-sums for units from C. Reorder clusters according to v(C).
*  
