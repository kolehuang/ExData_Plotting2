NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Base system

NEI.Bal <- NEI[NEI$fips == "24510", c("Emissions", "year")]
total <- aggregate(cbind(Emissions) ~ year, sum, data = NEI.Bal)
total <- xtabs(Emissions ~ year, data = total)

png(file = "plot2.png")
barplot(total, xlab = "Year", ylab = expression("Emissions from PM"[2.5]),  main = expression("Total Emissions from PM"[2.5]*" in Baltimore City from 1999-2008"))

dev.off()