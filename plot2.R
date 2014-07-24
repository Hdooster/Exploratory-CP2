#for using ddply
library(plyr)

#reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#split data by year, sum up all the emissions, recombine
plot2data <- ddply(NEI[NEI$fips== "24510",], .(year),summarize,totalEM = sum(Emissions))


png("plot2.png")
plot(plot2data$year,plot2data$totalEM,type="b",pch=2,bg = "transparent",xlab="Year",ylab="Total PM25 Emission in Baltimore")
dev.off()