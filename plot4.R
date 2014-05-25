NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Note: defined as being related to coal or lignite, as this seemed like the most sensible grouping of sources
# upon analysis.
SCC_coal_comb <- SCC[grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) | grepl("Lignite", SCC$SCC.Level.Three, ignore.case=TRUE),]
NEI_coal_comb <- subset(NEI, SCC %in% SCC_coal_comb$SCC)
NEI_coal_comb$year <- factor(NEI_coal_comb$year)
NEI_coal_sums <- aggregate(Emissions ~ year, data=NEI_coal_comb, FUN=sum)
NEI_coal_sums$Emissions <- round(NEI_coal_sums$Emissions / 1000, digits=2)

png(filename = "plot4.png", width = 640, height = 640, units = "px")

title <- bquote(PM[2.5] ~ " Coal Combustion Related Emissions in the USA: 1999 - 2008")
ylabel <- bquote(PM[2.5] ~ " Emissions levels in kilotons")
xlabel <- "Year"

ggplot(NEI_coal_sums, aes(x=year, y=Emissions, color="red", label=Emissions, group=1)) +
	geom_line(linetype="dashed", size=1.25) +
	labs(title=title, y=ylabel, x=xlabel) +
	theme(legend.position="none", plot.title = element_text(color="blue", size=rel(1.25))) +
	geom_point(shape=23, size=4) + 
  	geom_text(aes(label=Emissions),hjust=1, vjust=2, color="black")

dev.off()