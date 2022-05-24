# Some datasets from Manly and Alberto 

Manly, Bryan F. J.,  Navarro Alberto, Jorge A.: Multivariate statistical methods: a primer. 4e, CRC Press, 2017. 

## EuProtein

22 Eu countries and 18 industry groups

EuProtein: [CSV](https://github.com/bavla/NormNet/blob/main/data/Manly%26Alberto/EuProtein.csv), [Pajek MAT](https://github.com/bavla/NormNet/blob/main/data/Manly%26Alberto/EuProtein.mat), [picture](https://github.com/bavla/NormNet/blob/main/data/Manly%26Alberto/EuProtein.pdf)

```
dataF <- "https://raw.githubusercontent.com/bavla/NormNet/main/data/Manly%26Alberto/EuProtein.csv"
P <- read.csv(dataF,sep=",",skip=5,head=TRUE)
```

page 198 / Table 10.4 Sources of protein and percentages employed in different industry groups for countries in Europe

estimates of the average protein consumption from different food sources for the inhabitants of 22 European countries from:
Weber, A. (1973). Agrarpolitik im Spannungsfeld der Internationalen Ernährungspolitik. Kiel: Institut für Agrapolitik und Marktlehre.

RM, red meat; WM, white meat; EGG, eggs; MLK, milk; FSH, fish; CLR, cereals; SCH, starchy foods; 
PNO, pulses, nuts, and oilseed; F&V, fruit and vegetables; AGR, agriculture, forestry, and fishing; 
MIN, mining and quarrying; MAN, manufacturing; PS, power and water supplies; CON, construction;
SER, services; FIN, finance; SPS, social and personal services; TC, transport and communications.

## Plants Steneryd Reserve

25 plant species and 17 plots

PlantsStenerydReserve: [CSV](https://github.com/bavla/NormNet/blob/main/data/Manly%26Alberto/PlantsStenerydReserve.csv), [Pajek MAT](https://github.com/bavla/NormNet/blob/main/data/Manly%26Alberto/PlantsStenerydReserve.mat), [picture](https://github.com/bavla/NormNet/blob/main/data/Manly%26Alberto/PlantsStenerydReserve.pdf)

```
dataF <- "https://raw.githubusercontent.com/bavla/NormNet/main/data/Manly%26Alberto/PlantsStenerydReserve.csv"
R <- read.csv(dataF,sep=",",skip=15,head=TRUE)
```

page 174 / Table 9.7 Abundance measures for 25 plant species on 17 plots in Steneryd Nature Reserve, Sweden

Table 9.7 shows the abundances of the 25 most abundant plant species on 17 plots from a grazed 
meadow in Steneryd Nature Reserve in Sweden, as measured by Persson (1981) and used for an 
example by Digby and Kempton (1987). Each value in the table is the sum of cover values in a 
range from 0 to 5 for nine sample quadrats, so that a value of 45 corresponds to complete cover
by the species being considered. Note that the species are in order from the most abundant (1) 
to the least abundant (25), and the plots are in the order given by Digby and Kempton (1987, 
table 3.2), which corresponds to variation in certain environmental factors such as light and moisture.

- Persson, S. (1981). Ecological indicator values as an aid in the interpretation of ordination diagrams. Journal of Ecology 69: 71–84.
- Digby, P.G.N. and Kempton, R.A. (1987). Multivariate Analysis of Ecological Communities. London: Chapman and Hall.
