NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"), 
## Which city has seen greater changes over time in motor vehicle emissions?

MotorCodes <- SCC$SCC[grep("vehicle", SCC$EI.Sector, ignore.case=TRUE)]
NEI.Motor <- subset(NEI, SCC %in% MotorCodes)
NEI.Motor.BalCal <- NEI.Motor[NEI.Motor$fips == "24510" | NEI.Motor$fips == "06037", c("fips", "Emissions", "year")]
total <- aggregate(cbind(Emissions) ~ year + fips, sum, data = NEI.Motor.BalCal)

city.names <- list("24510" = "Los Angeles County", "06037" = "Baltimore City")
city_labeller <- function(variable, value){
  return(city.names[value])
}

library(ggplot2)
ggplot(total, aes(x = factor(year), y = Emissions)) + geom_bar(fill="#FF9999", colour="black", stat = "identity") + facet_grid(. ~ fips, labeller = city_labeller) + xlab("Years") + ylab("Emissions from Motor Vehicle Sources") + ggtitle("Total Emissions from Motor Vehicle in Baltimore City and Los Angels County from 1999-2008")
ggsave(file = "plot6.png", width = 9.6, height = 4.8, units = "in")