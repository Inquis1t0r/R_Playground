#Poniøszy kod przedstawia drzewo decyzyjne, stworzone na podstawie bazy danych "cats" z biblioteki MASS.
#Drzewo ma na celu odrÛønienie plci kota na podstawie jego wagi i wagi serca
#Do testowania klasyfikatora zastosowano metodÍ podzia≥u (ang. hold-out) przyjmujπc lambda = 2/3
#Wykorzystano package rpart oraz MASS (baza danych "cats" pochodzi z MASS)
library(AMORE)
#wczytujemy biblioteke i baze danych
library(MASS)
data(cats, package="MASS") #zaladowanie zbioru danych "cats" z biblioteki MASS
tk <- table(cats["Sex"]) #podsumowanie ile mamy samic oraz samcow w tabeli
set.seed(12345) #ustawienie poczπtkowe generatora liczb pseudolosowych
l.d <- nrow(cats) #liczba danych
test <- sample(1:l.d, round(l.d/3), replace=FALSE) #generowanie losowo numerÛw przyk≥adÛw testowych
cats.tr <- cats[-test,]  #zbiÛr danych trenujπcych
cats.test <- cats[test,] #zbiÛr danych testowych
#-------- tworzymy i przycinamy drzewo decyzyjne --------------------- 
library(rpart) #za≥adowanie pakietu umoøliwiajπcego wykorzystanie drzew decyzyjnych
#install.packages("rpart.plot") #instalujemy pakiet do wizualizacji
library(rpart.plot) #≥adujemy pakiet do wizualizacji
drzewo <- rpart(Sex~., data=cats.tr, method="class", control=rpart.control(cp=0, minsplit=2, minbucket=1))
print(drzewo)
prp(drzewo, type=2, extra=1) #reprezentacja graficzna drzewa klasyfikujπcego dane
printcp(drzewo) #odczytujemy wskaünik cp (okreúla wielkoúÊ drzewa w zaleønoúci od b≥Ídu)
plotcp(drzewo)
drzewo.p <- prune(drzewo, cp=drzewo$cptable[2]) #przyciÍcie pe≥nego drzewa
prp(drzewo.p, type=2, extra=1) #reprezentacja graficzna przyciÍtego drzewa, 
#b≥πd klasyfikacji
y.pred <- predict(drzewo.p, newdata=cats.test, type="class") #zastosowanie drzewa do nowych danych
blad <- 1-sum(y.pred==cats.test$Sex)/nrow(cats.test)
print(blad)
#Blad klasyfikacji wynosi 16,(6)%. 
#Ten wynik pokazuje, ze nasze drzewo decyzyjne myli sie przy okolo 17% przypadkow jesli chodzi o odroznianie plci kotow na podstawie ich wagi
#Nie jest to najlepszej jakosci klasyfikator jednak w wiekszosci przypadkow potrafi poprawnie zaklasyfikowac plec
