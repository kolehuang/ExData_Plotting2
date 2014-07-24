
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Use Base System

total <- aggregate(cbind(Emissions) ~ Pollutant + year, sum, data = NEI)
total <- xtabs(Emissions ~ year, data = total)

png(file = "plot1.png",  width = 600)
barplot(total, axes = FALSE, xlab = "Year", ylab = expression("Emissions from PM"[2.5]),  main = expression("Total Emissions from PM"[2.5]* " in the United States from 1999-2008"))
par(yaxt = "s")
lablist.y<-as.vector(c("0", "1000000", "2000000", "3000000","4000000", "5000000", "6000000", "7000000"))
axis(2, at=seq(0, 7000000, by=1000000), labels = FALSE)
text(y = seq(0, 7000000, by=1000000), par("usr")[1], labels = lablist.y, srt = 45, pos = 2, xpd = TRUE)

dev.off()