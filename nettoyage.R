######### Nettoyage 

splash=function(x){
    res=NULL
    for (i in x) res=paste(res, i)
    res
}

#Suppression des script s(<script .... </script>)
removeScript=function(t){
    #decoupage de la chaine en utilisant "<split"
    #sp=strsplit(splash(t), "<script")
    sp=strsplit(t, "<script")
    #pour chaque partie du split, le debut (jusqu'a </script> est supprime
    vec=sapply(sp[[1]], gsub, pattern=".*</script>", replace=" ")
    #les elements du split nottoyes sont concatenes
    PlainTextDocument(splash(vec))
}

#Suppression de toutes les balises
removeBalises=function(x){
    t1=gsub("<[^>]*>", " ", x)
    #suppression des occurrences multiples d'espaces (ou de tabulations)
    PlainTextDocument(gsub("[ \t]+"," ",t1))
}

#nettoyage du corpus, selon les "notes-preparaton" sur Celene
nettoyage<-function(corpus){
    corpus<-tm_map(corpus,content_transformer(tolower))
		corpus<-tm_map(corpus,content_transformer(splash))
    corpus<-tm_map(corpus,content_transformer(removeScript))
		corpus<-tm_map(corpus,content_transformer(removeBalises))
    corpus<-tm_map(corpus,removeWords,words=stopwords('en'))
    corpus<-tm_map(corpus,removePunctuation)
    corpus<-tm_map(corpus,removeNumbers)
    corpus<-tm_map(corpus,stemDocument)
}

