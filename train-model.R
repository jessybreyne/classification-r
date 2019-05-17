library(tm)
source("nettoyage.R")

###############################################################
# Chargement et vectorisation
###############################################################

data<-VCorpus(DirSource("../training2016",recursive=TRUE))

dataN<-nettoyage(data)

mat<-DocumentTermMatrix(dataN)
#<<DocumentTermMatrix (documents: 1050, terms: 49094)>>
#Non-/sparse entries: 327254/51221446
#Sparsity           : 99%
#Maximal term length: 708
#Weighting          : term frequency (tf)

#nouvelle représentation avec seulement les mots qui apparaissent au moins 300 fois dans le corpus
vocab<-findFreqTerms(mat,300)
mat<-DocumentTermMatrix(dataN,list(dictionary=vocab))

#préparation de la matrice R pour la classification, 7 clases * 150 docs chacun
Mstr<-cbind(as.matrix(mat),c(rep("accueil",150),rep("blog",150),rep("commerce",150),rep("FAQ",150),rep("home",150),rep("liste",150),rep("recherche",150)))

#sauvegarde du modèle
saveRDS(vocab, "vocab.rds")
saveRDS(Mstr, "Mstr.rds")


###############################################################
# Test erreur du classifieur K-PPV
###############################################################

source("fonctions-kppv.R")

erreurKPPV(k=1,data=Mstr)
#[1] 0.2342857 for Mstr freqTerm 300

#bonneClassifKPPV(k=1, data=Mstr)
#[1] 0.7657143






