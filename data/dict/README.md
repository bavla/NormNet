# Dictionary

## English dictionary


[EngDict](engdict.zip)

Two-mode network ''EngDict.net'' with 85973 + 94441 = 180414 nodes and 660758 arcs and the edge list ''Dict.csv''.

### Description 

English dictionary network JSON from [Kaggle](https://www.kaggle.com/datasets/bfbarry/dictionary-graph). 
```
{
"DIPLOBLASTIC":["CHARACTERIZING","THE","OVUM","WHEN","IT","HAS","TWO","PRIMARY","GERMINALLAYERS"],
"DEFIGURE":["TO","DELINEATE","[OBS","]THESE","TWO","STONES","AS","THEY","ARE","HERE","DEFIGURED","WEEVER"],
"LOMBARD":["OF","OR","PERTAINING","TO","LOMBARDY","OR","THE","INHABITANTS","OF","LOMBARDY"],
"BAHAISM":["THE","RELIGIOUS","TENETS","OR","PRACTICES","OF","THE","BAHAIS"],
"FUMERELL":["SEE","FEMERELL"],
"ROYALET":["A","PETTY","OR","POWERLESS","KING",[R","]THERE","WERE","AT","THIS","TIME","TWO","OTHER",
"ROYALETS","AS","ONLY","KINGS","BY","HISLEAVE","FULLER"],
"TROPHIED":["ADORNED","WITH","TROPHIES","THE","TROPHIED","ARCHES","STORIED","HALLS","INVADE","POPE"],
"ZEQUIN":["SEE","SEQUIN"],
"MILLWRIGHT":["A","MECHANIC","WHOSE","OCCUPATION","IS","TO","BUILD","MILLS","OR","TO","SET","UPTHEIR","MACHINERY"],
...
```
It has some deficiencies: 
  * words such as: "[OBS", "]"; "[R","]"; "[WRITTEN","ALSOBETTEE","]THE"; "[BRAIDED]"; "[SLANG]", etc.  
  * phrases such as "TRUNK STEAMER", "BLACK FRIAR", "FLINT GLASS", "CHAIN TIE", etc. appear only as source nodes
  * target nodes include also stopwords
  * some target nodes consist of "duble" words: germinallayers, hisleave, platesemployed, theatlantic, fewspecies, etc.
  * lines containing "see WORD"

#### Converting into an edge list 

I decided to lemmatize the target words. I first re-joined the words from the entry list into the "original" description string and removed all []-enclosed substrings. Afterward, I lemmatized the words from the description and removed the stopwords.
```
version = "Dict to Pajek 0.1"
# by Vladimir Batagelj, May 29, 2022
wdir = "C:/Users/vlado/DL/data/kaggle"
import sys, os, re, datetime, csv, json, shutil, time
os.chdir(wdir)
import nltk
from nltk.stem import WordNetLemmatizer
from nltk.corpus import wordnet
from nltk.corpus import stopwords

def get_wordnet_pos(word):
   """Map POS tag to first character lemmatize() accepts"""
   tag = nltk.pos_tag([word])[0][1][0].upper()
   tag_dict = {"J": wordnet.ADJ,
               "N": wordnet.NOUN,
               "V": wordnet.VERB,
               "R": wordnet.ADV}
   return tag_dict.get(tag, wordnet.NOUN)

print(version)
ts = datetime.datetime.now()
print('{0}: {1}\n'.format("START",ts))

lemmatizer = WordNetLemmatizer()
stopWords = set(stopwords.words('english'))

fDict = open('dict_graph.json')
D = json.load(fDict)
net = open(wdir+'/dict.csv','w',encoding="utf-8")

for k in D:
   S = D[k]
   if len(S)==0: print(k); continue
   if S[0]=='SEE': S = S[1:]
   # join words into text and remove [ ... ] substrings
   s = re.sub(r"\[[\w|\s]*\]", "", ' '.join(S).lower())
   L = [lemmatizer.lemmatize(w,get_wordnet_pos(w)) for w in nltk.word_tokenize(s)]
   K = set([w for w in L if (not w in stopWords) and (len(w)>1)])
   for w in K: net.write(k.lower()+','+w+'\n')
net.close()

print('{0} {1}\n'.format("keys",len(D)))
tf = datetime.datetime.now()
print('{0}: {1}\n'.format("END",tf))      
```

The execution of the program prints a list of source words with an empty description. It takes around 4 mins.
```
============= RESTART: C:\Users\vlado\DL\data\kaggle\dict2pajek.pyw ============
Dict to Pajek 0.1
START: 2022-05-29 19:56:13.505569

COMBATIVE
DIS-
DRUM MAJOR
-ER
BOW NET
HAEMIC
F
HORSE POWER
BOW OAR
CONSONANTAL
CLUNCH
keys 86024

END: 2022-05-29 20:00:38.079762
</code>
and produces an edge list on the file ''dict.csv'':
<code>
diploblastic,germinallayers
diploblastic,two
diploblastic,primary
diploblastic,characterize
diploblastic,ovum
defigure,stone
defigure,two
defigure,defigured
defigure,weever
defigure,delineate
lombard,pertain
lombard,lombardy
lombard,inhabitant
bahaism,bahai
bahaism,religious
...
```


#### Converting the edge list into Pajek network 

It is very easy to do it in R.
```
> wdir <- "C:/Users/vlado/DL/data/kaggle"
> setwd(wdir)
> D <- read.csv("dict.csv",head=FALSE)
> dim(D)
[1] 660758      2
> head(D)
            V1             V2
1 diploblastic germinallayers
2 diploblastic            two
3 diploblastic        primary
4 diploblastic   characterize
5 diploblastic           ovum
6     defigure          stone
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> uvFac2net(factor(D$V1),factor(D$V2),Net="EngDict.net",twomode=TRUE)
```

We get a Pajek two-mode network ''EngDict.net'' with 85973 + 94441 = 180414 nodes and 660758 arcs.

