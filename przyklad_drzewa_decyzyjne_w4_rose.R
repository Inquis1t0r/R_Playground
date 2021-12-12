#Przyk?ad tworzenia drzewa decyzyjnego.
#Identyfikacja gatunku irysa (klasyfikacja) b?dzie dokonywana na podstawie 
#znajomo?ci wymiar?w jego p?atka i kielicha.
#Do testowania klasyfikatora zastosowano metod? podzia?u (ang. hold-out) przyjmuj?c lambda = 2/3,

#--------------przygotowujemy zbi?r danych ------------------------
#dzielimy dane na dwa roz??czne zbiory: zbi?r ucz?cy i zbi?r testowy,
#spr?bujemy oceni? jako?? utworzonego klasyfikatora

#data(roze) #?adujemy zestaw danych roze do pami?ci, mo?emy z tych danych ju? korzysta?
roze=read.csv(file.choose())
#tk <- table(roze["gatunek"]) #wygenerowanie podsumowania liczno?ci dost?pnych gatunk?w irys?w
#print(tk)
set.seed(12345) #ustawienie pocz?tkowe generatora liczb pseudolosowych
l.d <- nrow(roze) #liczba danych
test <- sample(1:l.d, round(l.d/3), replace=FALSE) #genarowanie losowo numer?w przyk?ad?w testowych
roze.tr <- roze[-test,]  #zbi?r danych trenuj?cych
roze.test <- roze[test,] #zbi?r danych testowych


#-------- tworzymy i przycinamy drzewo decyzyjne --------------------- 
library(rpart) #za?adowanie pakietu umo?liwiaj?cego wykorzystanie drzew decyzyjnych
#install.packages("rpart.plot") #instalujemy pakiet do wizualizacji
library(rpart.plot) #?adujemy pakiet do wizualizacji

#tworzymy drzewo decyzyjne
drzewo <- rpart(gatunek~., data=roze.tr, method="class", control=rpart.control(cp=0, minsplit=3, minbucket=1))
#gatunek~. - formu?a, symboliczny opis modelu; 
#  zale?no?? zmiennych okre?la symbol tyldy (~), 
#    zmienne po lewej stronie tego znaku to zmienne zale?ne, 
#    po prawej - niezale?ne; 
#  kropka oznacza, ?e stosowane s? wszystkie pozosta?e zmienne, 
#  natomiast wybrane zmienne uwzgl?dniane w modelu podaje si? stosuj?c ich nazwy 
#    oraz oddzielaj?c je symbolem +

#data=roze.tr - dane typu data.frame, kt?re b?d? stosowane do tworzenia modelu, 
#  nazwy kolumn s? jednocze?nie nazwami zmiennych stosowanymi w modelu,

#method metoda tworzenia drzewa, w przypadku tworzenia drzew klasyfikacyjnych nale?y wpisa? method="class",

#control=rpart.control(cp=0, minsplit=2, minbucket=1) - okre?lenie parametr?w 
#  kontrolnych procesu tworzenia drzewa, m.in.:
#    cp - parametr okre?laj?cy wielko?? drzewa,
#    minsplit - najmniejsza liczba przyk?ad?w jaka mo?e podlega? jeszcze dalszemu podzia?owi,
#    minbucket - minimalna liczba przyk?ad?w w li?ciu drzewa.

print(drzewo)
prp(drzewo, type=3, extra=1) #reprezentacja graficzna drzewa klasyfikuj?cego dane roze
printcp(drzewo) #odczytujemy wska?nik cp (okre?la wielko?? drzewa w zale?no?ci od b??du)
plotcp(drzewo)  #graficzna prezentacja parametru cp


drzewo.p <- prune(drzewo, cp=drzewo$cptable[3]) #przyci?cie pe?nego drzewa
#  cp warto?? okre?laj?ca po??dan? wielko?? drzewa po przyci?ciu.
prp(drzewo.p, type=3, extra=1) #reprezentacja graficzna przyci?tego drzewa

#------------ okre?lenie b??du klasyfikacji ------------------
#b??d klasyfikacji
y.pred <- predict(drzewo.p, newdata=roze.test, type="class") #zastosowanie drzewa do nowych danych
blad <- 1-sum(y.pred==roze.test$gatunek)/nrow(roze.test)
print(blad)
