library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset df using baltimore fips
NEI_baltimore <- subset(NEI,fips == "24510")
# Summarizing emissions per year and type + Creating Data Frame
emissionYearTypeDF <- with(NEI_baltimore, aggregate(Emissions,list(year,type),sum))
names(emissionYearTypeDF) <- c("Year","Type","Emission")
emissionYearTypeDF$Year <- factor(emissionYearTypeDF$Year)
#Opening png device
png("plot3.png")

g<- ggplot(emissionYearTypeDF, aes(Year,Emission)) + 
  facet_grid(.~Type) + aes(fill = Type) +
  geom_bar(stat="identity",show.legend = FALSE) +
  labs(title=expression("PM"[2.5]*" Emissions from 1999 to 2008 in Baltimore City by source")) +
  labs(y=expression("PM"[2.5]* "[Tons]"))
print(g)
dev.off()