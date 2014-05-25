NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Note: We define motor vehicles as falling under the type of ON-ROAD, for simplicity sake and 
# because this is consistent with the general notion of motor vehicle.
baltMotorVeh <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]
baltMotorVehSums <- aggregate(Emissions ~ year + type, data=baltMotorVeh, FUN=sum)
baltMotorVehSums$Emissions <- round(baltMotorVehSums$Emissions, digits=2)
baltMotorVehSums$year <- factor(baltMotorVehSums$year)
baltMotorVehSums$type <- factor(baltMotorVehSums$type)

title <- bquote(PM[2.5] ~ " Motor Vehicle Emissions in Baltimore City, MD: 1999 - 2008")
ylabel <- bquote(PM[2.5] ~ " Emissions levels in tons")
xlabel <- "Year"

png(filename = "plot5.png", width = 640, height = 640, units = "px")

ggplot(baltMotorVehSums, aes(x=year, y=Emissions, color="red", label=Emissions, group=1))	+ 
	geom_line(linetype="dotted", color="red", size=1.25) +
	geom_point(shape=23, size=4) +	
	labs(title=title, y=ylabel, x=xlabel) +
	theme(legend.position="none", 
		strip.text.x = element_text(colour = "red", angle = 45, size = 10, hjust = 0.5, vjust = 0.5),
		plot.title = element_text(color="blue", size=rel(1.25))) +
  	geom_text(aes(label=Emissions),hjust=1, vjust=2, color="black")	+
	geom_smooth(method="lm")

dev.off()