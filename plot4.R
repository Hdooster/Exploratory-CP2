library("plyr")
library("ggplot2")

#reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#split data by year, sum up all the emissions, recombine
data<-transform(NEI,type=factor(type),year=factor(year))

combustionSCC <- as.data.frame(SCC[grepl("combustion",SCC$SCC.Level.One,ignore.case=T) & grepl("coal",SCC$SCC.Level.Three,ignore.case=T),1])
colnames(combustionSCC) <- "SCC"

data <- merge(combustionSCC,data,by="SCC")
plot4data <- ddply(data, .(year),summarize,totalEM = sum(Emissions))


png("plot4.png")
plot4 <- ggplot(plot4data,aes(year,totalEM))
plot4+geom_point(size=5)+geom_line()+labs(title="Coal combustion emissions in the USA",
                                                                  y="total coal PM25 emission each year")

dev.off()