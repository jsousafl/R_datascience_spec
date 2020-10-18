library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset df using baltimore fips
NEI_baltimore <- subset(NEI,fips == "24510")

#Find SCC ID from coal combustion-related sources
idVehicle <- grep("mobile",SCC$EI.Sector,ignore.case = TRUE)
SCC_Vehicle <- SCC$SCC[idVehicle]

#Filter raw data with the SCC ID found
NEI_BaltVehicle <- subset(NEI_baltimore, NEI_baltimore$SCC %in% SCC_Vehicle)

# Summarizing emissions per year and type + Creating Data Frame
emissionYearDF <- with(NEI_BaltVehicle, aggregate(Emissions,list(year),sum))
names(emissionYearDF) <- c("Year","Emission")
emissionYearDF$Year <- factor(emissionYearDF$Year)
#Opening png device
png("plot5.png")

g<- ggplot(emissionYearDF, aes(Year,Emission)) + 
  geom_bar(stat="identity") +
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions from 1999 to 2008 in Baltimore City")) +
  labs(y=expression("PM"[2.5]* "[Tons]"))
print(g)
dev.off()