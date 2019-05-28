library("tm")
library("e1071")
source("nettoyage.R")

###############################################################
# Chargement et vectorisation
###############################################################

dataImpure <- DirSource("training2016/", recursive=TRUE, encoding="UTF-8")
corpusImpure <- VCorpus(dataImpure, readerControl = list(reader = reader(dataImpure), language="en"))
matImpure = nettoyage(corpusImpure)
matPure = DocumentTermMatrix(matImpure)

#<<DocumentTermMatrix (documents: 1050, terms: 49094)>>
#Non-/sparse entries: 327254/51221446
#Sparsity           : 99%
#Maximal term length: 708
#Weighting          : term frequency (tf)

#nouvelle représentation avec seulement les mots qui apparaissent au moins 300 fois dans le corpus

#préparation de la matrice R pour la classification, 7 clases * 150 docs chacun
#Ajout de sclasse accueil pou les 150 premier ect

mat <- as.matrix(matPure)
lesRescapes = findFreqTerms(matPure, lowfreq = 125)

saveRDS(lesRescapes, file = "vocab.rds")

matPure = matPure[, lesRescapes]
mat = as.matrix(matPure)
listePure <- c(rep("accueil",150),rep("blog",150),rep("commerce",150),rep("FAQ",150),rep("home",150),rep("liste",150),rep("recherche",150))
model <- svm(x=mat,y=listePure,type='C',kernel='linear')

saveRDS(model, file = "Mstr.rds")

###############################################################
# Test erreur du classifieur SVM
###############################################################