#Convergence ################################
#############################################

setwd("C:/Users/Mehdi/Desktop/PR3")


### Données de 83 pays GDP par tête
X1 <- read.csv("PIB.csv",head = T,sep = ";",dec = ",")
str(X1)
head(X1)
X <- X1[,-1]
View(X)
#### Test de multimodalité #####
###############################

# Chargement du fichier contenant les fonctions nécessaire au test

source("multimodality_src.R")


## Application de la distribution des revenus par habitants des pays de la cop 27 #####
##################

X<-read.csv("PIB.csv",head=T,sep=";",dec=",")
###  En 1980   ###
X<-read.csv("PIB.csv",head=T,sep=";",dec=",")
X=X[,-1]
M<-matrix(0,nrow=nrow(X),ncol=ncol(X))# PIB rapporte a la moyenne(comparaison entre le PIB d'un pays et le PIB moyen de l'ensemble des pays#
for(i in 1:ncol(X)){
  M[,i]<-X[,i]/colMeans(X)[i]
}
colnames(M)<-colnames(X)
head(M)
M<-data.frame(M)
gdp50 <- M[,"X1950"]
gdp70 <- M[,"X1970"]
gdp80 <-M[,"X1980"]
gdp90 <-M[,"X1990"]
gdp02 <- M[,"X2000"]
gdp10 <- M[,"X2010"]
silversignif(gdp50,1,nboot=100) #
silversignif(gdp50,2,nboot=100) # nombre optimal de modalite est 2#
silversignif(gdp50,3,nboot=100)
#plot(density(gdp80,from=0))  #densite des pays 1980#
silversignif(gdp02,1,nboot=100) #
silversignif(gdp02,2,nboot=100) # nombre optimal de modalite est 2#
silversignif(gdp02,3,nboot=100)
silversignif(gdp80,1,nboot=100) #
silversignif(gdp80,2,nboot=100) # nombre optimal de modalite est 2#
silversignif(gdp80,3,nboot=100) #
silversignif(gdp10,1,nboot=100) #
silversignif(gdp10,2,nboot=100) # nombre optimal de modalite est 2#
silversignif(gdp10,3,nboot=100)
silversignif(gdp70,1,nboot=100)
silversignif(gdp70,2,nboot=100)
silversignif(gdp70,3,nboot=100)
silversignif(gdp90,1,nboot=100)
silversignif(gdp90,2,nboot=100)
silversignif(gdp90,3,nboot=100)



plot(density(gdp70,from=0,bw=hcrit(gdp70,2)),lwd=2,main="Densité empirique des PIB par habitant rapportés à la moyenne",xlab="PIB par habitant",ylab="Densité")
lines(density(gdp50,bw=hcrit(gdp50,1)),lwd=2,col="red")
lines(density(gdp80,bw=hcrit(gdp80,2)),lwd=2,col="purple")
lines(density(gdp90,bw=hcrit(gdp90,1)),lwd=2,col="blue")
lines(density(gdp02, bw=hcrit(gdp02,1)), lwd=2,col="green")
lines(density(gdp10, bw=hcrit(gdp10,1)),col="grey",lwd=2)
legend("topright",legend = c("1970","1950","1980","1990","2000","2010"),col=c("black","red","purple","blue","green","grey"),lty=1)


h3_80<-hcrit(gdp80,2)
m3_80<-valpic_creux(gdp80,h3_80)#pic PIB#
m3_80$valcreux #creux PIB#
m3_80$valmodes #les deux modes#

plot(density(gdp80,from=0,bw=hcrit(gdp80,2)),lwd=3,col="black",main="Densité empirique du PIB par habitant rapporté à la moyenne",xlab="PIB par habitant",ylab="Densité")
abline(v=m3_80$valcreux,lwd=1,lty=3)
abline(v=m3_80$valmodes,lwd=2,lty=3)
text(locator(3),c(paste(round(m3_80$valmodes[1],0)),paste(round(m3_80$valmodes[2],0)),paste(round(m3_80$valmodes[3],0))))

h3_70<-hcrit(gdp70,2)
m3_70<-valpic_creux(gdp70,h3_70)#pic PIB#
m3_70$valcreux #creux PIB#
m3_70$valmodes #les deux modes#

plot(density(gdp70,from=0,bw=hcrit(gdp80,2)),lwd=3,col="black",main="Densité empirique du PIB par habitant rapporté à la moyenne",xlab="PIB par habitant",ylab="Densité")
abline(v=m3_70$valcreux,lwd=1,lty=3)
abline(v=m3_70$valmodes,lwd=2,lty=3)
text(locator(3),c(paste(round(m3_80$valmodes[1],0)),paste(round(m3_80$valmodes[2],0)),paste(round(m3_80$valmodes[3],0))))




#On a deux pic et un creu#

########################################################################################
#####  Autres Outils : Beta et Sigm convergence et Matrice de mobilité #################

#### Calcul des rapport ? la moyenne
X<-read.csv("PIB.csv",head=T,sep=";",dec=",")
X=X[,-1]
M<-matrix(0,nrow=nrow(X),ncol=ncol(X))# PIB rapporte a la moyenne(comparaison entre le PIB d'un pays et le PIB moyen de l'ensemble des pays#
for(i in 1:ncol(X)){
  M[,i]<-X[,i]/colMeans(X)[i]
}
colnames(M)<-colnames(X)
head(M)
M<-data.frame(M)

attach(M)



### Beta convergence et sigma convergence# #ca nous permet de voir si il y aura un rattrapage ou non#

#Beta coonvergence avec ann?es de r?f?rence 1950

tx50<-numeric(0)
for(i in 1:nrow(M)){
  mult<-M[i,ncol(M)]/M[i,1]
  periode<-ncol(M)-1
  tx<-(mult^(1/periode)-1)*100
  tx50<-append(tx50,tx)
}

tx50 #taux de croissance annuel moyen de l'annee de reference 1950#

plot(M[,1],tx50,xlab="PIB par tête 1950",ylab="taux de croissance annuel moyen 1950-2018",type="p",pch=1) # pente negative=existance d'un beta convergence#
abline(lm(tx50~M[,1]),col="red")

summary(lm(tx50~M[,1]))


#si on enl?ve le Quatar 
X<-read.csv("PIB.csv",head=T,sep=";",dec=",")

which(M[,1]>6)
X[18,1]
M1<-M[-18,]
tx50_1<-tx50[-18]

plot(M1[,1],tx50_1,xlab="PIB par tête 1950",ylab="taux de croissance annuel moyen 1950-2018",type="p",pch=1)
abline(lm(tx50_1~M1[,1]),col="red")

summary(lm(tx50_1~M1[,1])) #beta convergent=-0.4274, n'est pas significatif, car p-value=0.1844 est superieur a 0,05#
confint(lm(tx50_1~M1[,1]))# on a deux IC qui on des signes differents, ca confirme l'hypothese de non significativite du beta convergence, c de la statistic elementaire#

## Acces au minimum

which(tx50_1==min(tx50_1))
X[1,1] #Argentine a le taux de croissance de pib moyen le plus faible dans le grp#



#Beta coonvergence avec ann?es de reference 1970

tx70<-numeric(0)
for(i in 1:nrow(M)){
  mult<-M[i,ncol(M)]/M[i,21]
  periode<-ncol(M)-21
  tx<-(mult^(1/periode)-1)*100
  tx70<-append(tx70,tx)
}


plot(M[,21],tx70,xlab="PIB par tête 1970",ylab="taux de croissance annuel moyen 1970-2018",type="p",pch=1)
abline(lm(tx70~M[,21]),col="red")#il est tjr convergent#
summary(lm(tx70~M[,21]))

which(M[,21]>3.5)
X[18,1]# PIB de catar est largement superireur a celui du grp#

## Sans quatar

plot(M[-18,21],tx70[-18],xlab="PIB par tête 1970",ylab="taux de croissance annuel moyen 1970-2018",type="p",pch=1)
abline(lm(tx70[-18]~M[-18,21]),col="red")

summary(lm(tx70[-18]~M[-18,21]))#le significative est a 5%, il est significatif#
confint(lm(tx70[-18]~M[-18,21]))#on a le meme signe du coup c significative##il est negatif et significatif, y aura rattrapage, les pays les plus pauvres vont raattrape les pays les plus riche#
#tant que le test est significatif on a pas besoin du locator#

#Beta coonvergence avec années de reference 1980

tx80<-numeric(0)
for(i in 1:nrow(M)){
  mult<-M[i,ncol(M)]/M[i,31]
  periode<-ncol(M)-31
  tx<-(mult^(1/periode)-1)*100
  tx80<-append(tx80,tx)
}


plot(M[,31],tx80,xlab="PIB par tête 1980",ylab="taux de croissance annuel moyen 1970-2018",type="p",pch=1)
abline(lm(tx80~M[,31]),col="red")#il est tjr convergent#
summary(lm(tx80~M[,31]))

which(M[,31]>3.5)
X[18,1]# PIB de catar est largement superireur a celui du grp#



#Beta coonvergence avec ann?es de reference 1990
tx90<-numeric(0)
for(i in 1:nrow(M)){
  mult<-M[i,ncol(M)]/M[i,41]
  periode<-ncol(M)-41
  tx<-(mult^(1/periode)-1)*100
  tx90<-append(tx90,tx)
}


plot(M[,41],tx90,xlab="PIB par tête 1990",ylab="taux de croissance annuel moyen 1990-2018",type="p",pch=1)
abline(lm(tx90~M[,41]),col="red")#il est tjr convergent#
summary(lm(tx90~M[,41]))

which(M[,41]>3.5)
X[18,1]# PIB de catar est largement superireur a celui du grp#



#Beta convergence avec années de reference 2000

tx02<-numeric(0)
for(i in 1:nrow(M)){
  mult<-M[i,ncol(M)]/M[i,51]
  periode<-ncol(M)-51
  tx<-(mult^(1/periode)-1)*100
  tx02<-append(tx02,tx)
}


plot(M[,51],tx02,xlab="PIB par tête 2000",ylab="taux de croissance annuel moyen 2000-2018",type="p",pch=1)
abline(lm(tx02~M[,51]),col="red")#il est tjr convergent#
summary(lm(tx02~M[,51]))

which(M[,51]>3.5)
X[18,1]# PIB de catar est largement superireur a celui du grp#




#Beta convergence avec années de reference 2010

tx10<-numeric(0)
for(i in 1:nrow(M)){
  mult<-M[i,ncol(M)]/M[i,61]
  periode<-ncol(M)-61
  tx<-(mult^(1/periode)-1)*100
  tx10<-append(tx10,tx)
}


plot(M[,61],tx10,xlab="PIB par tête 2010",ylab="taux de croissance annuel moyen 2010-2018",type="p",pch=1)
abline(lm(tx10~M[,61]),col="red")#il est tjr convergent#
summary(lm(tx10~M[,61]))

which(M[,61]>3.5)
X[18,1]# PIB de qatar est largement superireur a celui du grp#


#Sigma convergence avec le coefficient de variation# # il permet de voir si y a une dispersion entre les pays par rapport de la moyen du PIB du grp#

# Avec Q

coefvar<-numeric(0)#calcul de coefficient de variation du PIB pour le grp#

for(i in 1:ncol(M)){
  v<-sd(M[,i])
  coefvar<-append(coefvar,v)
  
}
coefvar<-ts(coefvar,start=1950, end=2018)
plot(coefvar)

# Sans le qatar

coefvar1<-numeric(0)
for(i in 1:ncol(M)){
  v1<-sd(M[-c(78,81),i])
  coefvar1<-append(coefvar1,v1)
}

coefvar1<-ts(coefvar1,start=1950, end=2018)
plot(coefvar1) #de 1950 a 2000 y a pas de disperssion car sigma diminue, de 2000 a 2018 ya disperssion car sigma augmente#


coefvar1<-numeric(0)
for(i in 1:ncol(M)){
  v1<-sd(M[-c(78,81),i])
  coefvar1<-append(coefvar1,v1)
}

coefvar1<-ts(coefvar1,start=1950, end=2008)








# Sigma convergence avec l'?cart type

# Sans Q

coefvar3<-numeric(0)

for(i in 1:ncol(X[,-1])){
  v1<-sd(X[-18,i])
  coefvar3<-append(coefvar3,v1)
}

coefvar3<-ts(coefvar3,start=1950, end=2018)
plot(coefvar3) # sans le Quatar y a une disperssion de 1950 a 2018#





###### Matrice de mobilit? ########
##################################

source("matmob.r")

ncol(M)


##### Matrice de mobilit? ? 5 ans

## Avec Q

a<-seq(1,64,1)
M5_1<-as.matrix(M[,a])
head(M5_1)

b<-seq(6,69,1)
M5_2<-as.matrix(M[,b])
head(M5_2)

v5_1<-matrix(M5_1,ncol=1)       ##### On met toute les valeurs en une colonne
v5_2<-matrix(M5_2,ncol=1)     #### Pareil ici, mais 5 ans apr?s


# Cr?ation d'une grille pour la d?termination des valeurs seuils

v<-cbind(v5_1,v5_2)
head(v)

g<-c(min(v)-0.001, quantile(v,0.25),quantile(v,0.5),quantile(v,0.75),max(v)+0.0001)
g

# Estimation de la matrice de Mobiblit?

M5<-trans(v,g)
M5

MC5<-Mcond(M5)#Matrice de mobilite# #collone annee t, ligne au plus tard#
MC5


#### Sans le Qatar

a<-seq(1,64,1)
M5_11<-as.matrix(M[-18,a])

b<-seq(6,69,1)
M5_21<-as.matrix(M[-18,b])

v5_11<-matrix(M5_11,ncol=1)
v5_21<-matrix(M5_21,ncol=1)

v<-cbind(v5_11,v5_21)
g<-c(min(v)-0.001, quantile(v,0.25),quantile(v,0.5),quantile(v,0.75),max(v)+0.0001)
g

M5<-trans(v,g)
M5

MC5<-Mcond(M5)
MC5

###### A dix ans

# Avec Q

a<-seq(1,59,1)
M10_1<-as.matrix(M[,a])

b<-seq(11,69,1)
M10_2<-as.matrix(M[,b])

v10_1<-matrix(M10_1,ncol=1)
v10_2<-matrix(M10_2,ncol=1)


v<-cbind(v10_1,v10_2)
g<-c(min(v)-0.001, quantile(v,0.25),quantile(v,0.5),quantile(v,0.75),max(v)+0.001)
g

M10<-trans(v,g)
M10

MC10<-Mcond(M10)#crise de 2008#

MC10

## Sans le quatar

a<-seq(1,59,1)
M10_11<-as.matrix(M[-18,a])

b<-seq(11,69,1)
M10_21<-as.matrix(M[-18,b])

v10_11<-matrix(M10_11,ncol=1)
v10_21<-matrix(M10_21,ncol=1)


v<-cbind(v10_11,v10_21)
g<-c(min(v)-0.001, quantile(v,0.25),quantile(v,0.5),quantile(v,0.75),max(v)+0.001)
g

M10<-trans(v,g)
M10

MC10<-Mcond(M10)
MC10




### Distribution joint et conditionnelle ? 10 ans

#install.packages("hdrcde")
library("hdrcde")


# Sans Q

## A cinq ans

xcde<-cde(v5_11,v5_21,nxmargin=15)
plot(xcde)
title(main="Densité condtionnelle à 5 ans")

plot(xcde,plot.fn="hdr")
abline(a=0,b=1)


### A dix ans

xcde<-cde(v10_11,v10_21,nxmargin=15)
plot(xcde)
title(main="Densité condtionnelle à 10 ans")

plot(xcde,plot.fn="hdr")
abline(a=0,b=1)

