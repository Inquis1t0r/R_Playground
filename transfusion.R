#install.packages("AMORE")
library(AMORE)

transfusion=read.csv(file.choose())

set.seed(224)
ile=nrow(transfusion)
idxTren<-sample(1:ile,2*ile/3)  
idxTest<-setdiff(1:ile,idxTren) 

target<-function(x)
{
  n<-length(x)
  wartosci<-levels(x)
  l<-length(wartosci)
  T<-matrix(0,nrow=n,ncol=l)
  for(i in 1:l)
    T[,i]<-(x==wartosci[i])
  colnames(T)<-wartosci
  return(T)
}

wZadane<-target(transfusion$whetherheshedonatedbloodinMarch20)
wZadane

set.seed(200)

siec<-newff(n.neurons=c(4,6,2),
            learning.rate.global=0.01,
            momentum.global=0.5,
            hidden.layer="sigmoid",
            output.layer="purelin",
            method="ADAPTgdwm",
            error.criterium="LMS")

#trenujemy sie?
wynik<-train(siec,
             transfusion[idxTren,1:5],
             wZadane[idxTren,],
             error.criterium="LMS",
             report=TRUE,
             show.step=5,
             n.shows=1000)

plot(wynik$Merror,type="l",xlab="Ileracja (x10)",
     ylab="Błąd", col="darkred")

y<-sim(wynik$net,transfusion[idxTest, 1:4])
y

testKlasyfikacji<-function(zad,wy)
{
  zadane<-max.col(zad)
  rozpoznane<-max.col(wy)
  print(table(zadane,rozpoznane))
}
wynik<-testKlasyfikacji(wZadane[idxTest,],y)

cat("Dokładność klasyfikacji:",
    sum(diag(wynik))/sum(wynik)*100, "%\n")
