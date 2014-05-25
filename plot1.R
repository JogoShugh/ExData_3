NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sums <- aggregate(Emissions ~ year, data=NEI, FUN=sum)
sums$Emissions = round(sums$Emissions / 1000, digits=2)

png(filename = "plot1.png", width = 640, height = 640, units = "px")

plot(x=sums$year, y=sums$Emissions, type="n", xaxt="n", 
	ylab=bquote(PM[2.5] ~ "Emission levels in kilotons"), 
	xlab="Year", main=bquote(PM[2.5] ~ " Emission Levels in the United States: 1999 - 2008"),
	col.main="blue", font.axis=4, font.lab=2)
labels <- c(1999,2002,2005,2008)
axis(1, at=labels, labels=labels)
lines(x=sums$year, y=sums$Emissions, lty="dashed", pch=23, lwd=3)
points(x=sums$year, y=sums$Emissions, pch=23)

dev.off()