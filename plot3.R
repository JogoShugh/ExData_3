NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

balt <- NEI[NEI$fips == "24510", ]
baltTypeSums <- aggregate(Emissions ~ year + type, data=balt, FUN=sum)
baltTypeSums$Emissions <- round(baltTypeSums$Emissions / 1000, digits=2)
baltTypeSums$year <- factor(baltTypeSums$year)
baltTypeSums$type <- factor(baltTypeSums$type)

png(filename = "plot3.png", width = 640, height = 640, units = "px")

title <- bquote(PM[2.5] ~ " Emission Levels by Type in Baltimore City, MD: 1999 - 2008")
ylabel <- bquote(PM[2.5] ~ " Emissions levels in kilotons")
xlabel <- "Year"

ggplot(baltTypeSums, aes(year, Emissions, group=1)) + 
	geom_histogram(binwidth = 1, stat="identity", color="white", fill="darkgreen") +
	labs(title=title, y=ylabel, x=xlabel) +
	theme(strip.text.x = element_text(colour = "red", angle = 45, size = 10, hjust = 0.5, vjust = 0.5), 
		plot.title = element_text(color="blue", size=rel(1.25))) +
	geom_smooth(method="lm") + 
	facet_grid(. ~ type)

dev.off()