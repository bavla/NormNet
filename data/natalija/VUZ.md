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

```

```

```

```

```

```

```

```
