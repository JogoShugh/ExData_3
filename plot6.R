NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Note: We define motor vehicles as falling under the type of ON-ROAD, for simplicity sake and 
# because this is consistent with the general notion of motor vehicle.
baltAndLAMotorVeh <- NEI[NEI$fips %in% c("24510", "06037") & NEI$type == "ON-ROAD", ]
# Rename fips to City to make the legend look better
colnames(baltAndLAMotorVeh)[which(names(baltAndLAMotorVeh) == "fips")] <- "City"
baltAndLAMotorVehSums <- aggregate(Emissions ~ year + type + City, data=baltAndLAMotorVeh, FUN=sum)
baltAndLAMotorVehSums$Emissions <- round(baltAndLAMotorVehSums$Emissions, digits=2)
baltAndLAMotorVehSums$year <- factor(baltAndLAMotorVehSums$year)
baltAndLAMotorVehSums$type <- factor(baltAndLAMotorVehSums$type)
# Also turn City into a factor to give better labels on the legend
baltAndLAMotorVehSums$City <- factor(baltAndLAMotorVehSums$City, levels=c("06037", "24510"), labels=c("Los Angeles", "Baltimore"))

title <- bquote(PM[2.5] ~ " Motor Vehicle Emissions in Baltimore City, MD vs. Los Angeles, CA: 1999 - 2008")
ylabel <- bquote(PM[2.5] ~ " Emissions levels in tons")
xlabel <- "Year"

png(filename = "plot6.png", width = 640, height = 640, units = "px")

ggplot(baltAndLAMotorVehSums, aes(x=year, y=Emissions, group=City, colour=City))	+ 
	geom_line(linetype="dotted", size=1.25) +
	geom_point(shape=23, size=4) +	
	labs(title=title, y=ylabel, x=xlabel) +
	theme(strip.text.x = element_text(colour = "red", angle = 45, size = 10, hjust = 0.5, vjust = 0.5), 
		plot.title = element_text(color="blue", size=rel(1.25))) +
  	geom_text(aes(label=Emissions),hjust=1, vjust=2, color="black")	+
	geom_smooth(method="lm")

dev.off()