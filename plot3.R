NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008?
## ggplot2

NEI.Baltype <- NEI[NEI$fips == "24510", c("Emissions", "type", "year")]
total <- aggregate(cbind(Emissions) ~ type + year, sum, data = NEI.Baltype)

library(ggplot2)
plot3 <- ggplot(total, aes(x = factor(year), y = Emissions)) + geom_bar(fill="#FF9999", colour="black", stat = "identity") + facet_grid(. ~ type) + xlab("Year") + ylab(expression("Emissions from PM"[2.5])) + ggtitle(expression("Total Emissions from PM"[2.5]*" by Four Types of Sources")) 
plot3 + theme_bw(base_family = "Times")
ggsave(file = "plot3.png", dpi = 72)
