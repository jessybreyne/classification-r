#distance euclidienne entre deux vecteurs 
distance<-function(x,y){
    return(sqrt(sum((as.numeric(x)-as.numeric(y))^2)))
}


#distance aux voisins
dist.voisins<-function(vecteur,data){
    return(apply(data,1,distance,x=vecteur))
}


#indices des k-ppv
kppv<-function(vecteur,k,data){
    v<-dist.voisins(vecteur,data)
    return(order(v)[2:(k+1)])
}


#classifieur
classerKPPV<-function(vecteur,k,data){
		x<-kppv(vecteur[1:(length(vecteur)-1)],k,data[,-ncol(data)])
    c<-table(data[x,ncol(data)])
    ind<-names(c)[which.max(c)]
    return(ind)
}


#erreur d'apprentissage
erreurKPPV<-function(k,data){
    res<-sapply(1:nrow(data),function(i) return(classerKPPV(data[i,],k,data)))
    sum(res!=data[,ncol(data)])/nrow(data)
}


#taux de bonne classification
bonneClassifKPPV<-function(k,data){
    res<-sapply(1:nrow(data),function(i) return(classerKPPV(data[i,],k,data)))
    sum(res==data[,ncol(data)])/nrow(data)
}
