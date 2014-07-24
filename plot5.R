library("plyr")
library("ggplot2")

#reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#split data by year, sum up all the emissions, recombine
data<-transform(NEI,type=factor(type),year=factor(year))
data <- data[data$fips== "24510",]


vehiclesSCC <- as.data.frame(SCC[grepl("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
colnames(vehiclesSCC) <- "SCC"

data <- merge(vehiclesSCC,data,by="SCC")

plot5data <- ddply(data, .(year),summarize,totalEM = sum(Emissions))


png("plot5.png")
plot5 <- ggplot(plot5data,aes(year,totalEM))
plot5+geom_point(size=5)+geom_line()+labs(title="Vehicle emissions in Baltimore",
                                          y="total coal PM25 emission each year")

dev.off()