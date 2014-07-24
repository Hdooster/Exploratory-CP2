library("plyr")
library("ggplot2")

#reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#split data by year, sum up all the emissions, recombine
data<-transform(NEI,type=factor(type),year=factor(year))

plot3data <- ddply(data[data$fips== "24510",], .(year,type),summarize,totalEM = sum(Emissions))


png("plot3.png")
plot3 <- ggplot(plot3data,aes(year,totalEM,group=type))
plot3+geom_point(aes(color=type))+geom_line(aes(color=type))+labs(title="PM25 Emission in Baltimore",
                                                                   y="total PM25 emission each year")

dev.off()