#2+2
# tworzę wektor danych:
(wektor = c(2.97, 2.09, 1.75, 1.99, 2.65))

plot(wektor, ylim= c(1,4), pch = 16, cex = 1.6)
abline(h=mean(wektor), lwd = 3)
var(wektor)
