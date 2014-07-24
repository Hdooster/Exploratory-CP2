
#for using ddply
library(plyr)

#reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#split data by year, sum up all the emissions, recombine
plot1data <- ddply(NEI, .(year),summarize,totalEM = sum(Emissions))


png("plot1.png")
plot(plot1data$year,plot1data$totalEM,type="b",pch=2,bg = "transparent",xlab="Year",ylab="Total PM25 Emission")
dev.off()