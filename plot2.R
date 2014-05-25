NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sumsBalt <- aggregate(Emissions ~ year, data=NEI[NEI$fips == "24510", ], FUN=sum)
sumsBalt$Emissions = round(sumsBalt$Emissions / 1000, digits=2)

png(filename = "plot2.png", width = 640, height = 640, units = "px")

plot(x=sumsBalt$year, y=sumsBalt$Emissions, xaxt="n",
	ylab=bquote(PM[2.5] ~ " Emission levels in kilotons"), 
	xlab="Year", main=bquote(PM[2.5] ~ " Emission Levels in Baltimore City, MD: 1999 - 2008"),
	col.main="blue", font.axis=4, font.lab=2)
labels <- c(1999,2002,2005,2008)
axis(1, at=labels, labels=labels)
lines(x=sumsBalt$year, y=sumsBalt$Emissions, lty="dashed", pch=23, lwd=3)

dev.off()