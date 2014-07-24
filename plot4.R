NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

CoalCodes <- SCC$SCC[grep("coal", SCC$EI.Sector, ignore.case=TRUE)]
NEI.Coal <- subset(NEI, SCC %in% CoalCodes)
total <- aggregate(cbind(Emissions) ~ year, sum, data = NEI.Coal)
total <- xtabs(Emissions ~ year, data = total)

png(file = "plot4.png", width = 720, height = 600)
barplot(total, axes = FALSE, xlab = "Year", ylab = "Emissions from Coal Combustion-related Sources", main = "Total Emissions from Coal Combustion-related Sources from 1999-2008")
par(yaxt = "s")
lablist.y<-as.vector(c("0", "100000", "200000", "300000","400000", "500000"))
axis(2, at=seq(0, 500000, by=10000), labels = FALSE)
text(y = seq(0, 500000, by=100000), par("usr")[1], labels = lablist.y, srt = 45, pos = 2, xpd = TRUE)
dev.off()
