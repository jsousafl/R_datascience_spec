library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset df using baltimore fips
NEI2cities <- subset(NEI,fips == "24510" | fips == "06037")

#Find SCC ID from coal combustion-related sources
idVehicle <- grep("mobile",SCC$EI.Sector,ignore.case = TRUE)
SCC_Vehicle <- SCC$SCC[idVehicle]

#Filter raw data with the SCC ID found
NEI_2CitiesVehicle <- subset(NEI2cities, NEI2cities$SCC %in% SCC_Vehicle)

# Summarizing emissions per year and type + Creating Data Frame
emissionYearCitiesDF <- with(NEI_2CitiesVehicle, aggregate(Emissions,list(year,fips),sum))
names(emissionYearCitiesDF) <- c("Year","City","Emission")
emissionYearCitiesDF$Year <- factor(emissionYearCitiesDF$Year)
emissionYearCitiesDF$City <- factor(emissionYearCitiesDF$City)
levels(emissionYearCitiesDF$City) <- c("Los Angeles County","Baltimore City")
#Opening png device
png("plot6.png")

g<- ggplot(emissionYearCitiesDF, aes(Year,Emission)) + 
  facet_grid(.~City) + aes(fill = City) +
  geom_bar(stat="identity",show.legend = FALSE) +
  labs(title=expression("PM"[2.5]*" Emissions from 1999 to 2008 in Baltimore City and LA County")) +
  labs(y=expression("PM"[2.5]* "[Tons]"))
print(g)
dev.off()