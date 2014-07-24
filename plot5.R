NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

MotorCodes <- SCC$SCC[grep("vehicle", SCC$EI.Sector, ignore.case=TRUE)]
NEI.Motor <- subset(NEI, SCC %in% MotorCodes)
NEI.Motor.Bal <- NEI.Motor[NEI.Motor$fips == "24510", c("Emissions", "year")]
total <- aggregate(cbind(Emissions) ~ year, sum, data = NEI.Motor.Bal)

library(ggplot2)
plot5 <- ggplot(total, aes(x = factor(year), y = Emissions)) + geom_bar(stat = "identity")
plot5 + xlab("Year") + ylab("Emissions from Motor Vehicle Sources") + ggtitle("Total Emissions from Motor Vehicle Sources from 1999-2008 in Baltimore City")
ggsave(file = "plot5.png", dpi = 72)
 