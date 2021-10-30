#plot(sin, -pi, 2*pi) 
#plot(5,4) #rysuje punkt x,y; 2 parametry to opisy osi, zakresy ustawiają się
#plot(5,4, type="p") #type: param opcjonalny, działa jak wyżej
#plot(5,4, type="h") #wykres słupkowy



x <- seq(-pi,pi,0.01) #params: x, y, przeskok
plot(x, sin(x), main = "sinus")

#mandaty <- c(235, 138, 42, 28, 16, 1)
#partie <- c("PIS", "PO", "Kukiz'15", "Nowoczesna", "PSL", "mniejszość niemiecka")
#pie(mandaty, labels = partie, col = rainbow(length(partie)), main = "Sejm RP listopad 2015") #Main: nagłowek
