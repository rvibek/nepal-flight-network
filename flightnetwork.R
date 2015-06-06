library('maps')  
library('geosphere')  
library('mapdata')

airports <- read.csv("airports.csv", header=TRUE)  
flights <- read.csv("flights.csv", header=TRUE, as.is=TRUE)

xlim<-c(80.3,88.2)  
ylim<-c(26,30.3)

pal <- colorRampPalette(c("#f2f2f2", "black"))  
colors <- pal(100)

#map("world", regions = "nepal", col="#f2f2f2", fill=T, bg="white", lwd=0.05, xlim=xlim, ylim=ylim)
map('worldHires', 'Nepal', col="#f2f2f2", fill=T)

fsub <- flights[flights$airline == "ALL",]  
fsub <- fsub[order(fsub$cnt),]  
maxcnt <- max(fsub$cnt)  
for (j in 1:length(fsub$airline)) {  
  air1 <- airports[airports$iata == fsub[j,]$airport1,]
  air2 <- airports[airports$iata == fsub[j,]$airport2,]

  inter <- gcIntermediate(c(air1[1,]$long, air1[1,]$lat), c(air2[1,]$long, air2[1,]$lat), n=100, addStartEnd=TRUE)
  colindex <- round( (fsub[j,]$cnt / maxcnt) * length(colors) )

  lines(inter, col=colors[colindex], lwd=0.8)
}