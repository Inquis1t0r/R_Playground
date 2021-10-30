#plot(sin, -pi, 2*pi) 
#plot(5,4) #rysuje punkt x,y; 2 parametry to opisy osi, zakresy ustawiają się
#plot(5,4, type="p") #type: param opcjonalny, działa jak wyżej
#plot(5,4, type="h") #wykres słupkowy



#x <- seq(-pi,pi,0.2) #params: x, y, przeskok między rysowanymi punktami
#plot(x, sin(x), main = "sinus")
#plot(x, sin(x), main = "sinus", type="h")

#boxplot(Temp~Month, #wykres pudełkowy
#        data=airquality,
#        main="Different boxplots for each month",
#        xlab="Month Number",
#        ylab="Degree Fahrenheit",
#        col="orange",
#        border="black" #wpływa też na kolor linii mediany + wąsy
#)
#"" -> komentarz na kilka linii, ale średnio działa ze stringami w parametrach

ceny <- c(5.93, 5.97, 5.96, 5.94, 5.97, 5.95)
woj <- c("dolnośląskie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "łódzkie", "małopolskie")
pie(ceny, labels = ceny, col = rainbow(length(woj)), main = "Średnie ceny paliw w Polsce") #Main: nagłowek
legend("topright", woj, cex = 0.8, fill = rainbow(length(woj))) #legenda, bo labels moze tylko jeden vektor mieć
