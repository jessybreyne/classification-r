# Chargement du modèle et des sources
vocab <- readRDS("vocab.rds")
model <- readRDS("Mstr.rds")
source("nettoyage.R",encoding = "UTF-8")

library("tm")
library("e1071")

######### Classification

classer = function(fichier) {
  #prepare fichier for classification
  dataImpure <- URISource(fichier, encoding = "UTF-8", mode = "text")
  corpusImpure <- VCorpus(dataImpure, readerControl = list(reader = reader(dataImpure), language="en"))
  corpusPure = nettoyage(corpusImpure)
  matImpure = DocumentTermMatrix(corpusPure,list(dictionary=vocab))
  #add the new text as the first line to the matrix, also add the last element as the class (value does not matter)
  matPure <- as.matrix(matImpure)
  #on retourne la prediction du SVM
  as.character(predict(model,matPure))
}