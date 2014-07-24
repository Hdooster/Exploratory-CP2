library("plyr")
library("ggplot2")

#reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#split data by year, sum up all the emissions, recombine
data<-transform(NEI,type=factor(type),year=factor(year))
data <- data[data$fips== "24510"|data$fips=="06037",]


vehiclesSCC <- as.data.frame(SCC[grepl("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
colnames(vehiclesSCC) <- "SCC"

data <- merge(vehiclesSCC,data,by="SCC")
data$fips[data$fips=="24510"]<-"Baltimore"
data$fips[data$fips=="06037"]<-"LA"

n<- c(names(data))
n<- gsub("fips","city",n)
names(data) <- n
plot6data <- ddply(data, .(year,city),summarize,totalEM = sum(Emissions))


png("plot6.png")
plot6 <- ggplot(plot6data,aes(year,totalEM))
plot6+geom_point(size=5,aes(color=city))+labs(title="Vehicle emissions in Baltimore and LA",
                                          y="total coal PM25 emission each year")

dev.off()