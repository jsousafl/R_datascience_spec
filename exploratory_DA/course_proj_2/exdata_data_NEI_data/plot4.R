NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find SCC ID from coal combustion-related sources
idCoal <- grep("coal",SCC$EI.Sector,ignore.case = TRUE)
SCC_Coal <- SCC$SCC[idCoal]

#Filter raw data with the SCC ID found
NEI_Coal <- subset(NEI, NEI$SCC %in% SCC_Coal)
# Summarizing emissions per year in a data frame
emissionPerYearDF <- with(NEI_Coal, aggregate(Emissions,list(year),sum))
names(emissionPerYearDF) <- c("Year","Emission")

#Normalizing values
emissionPerYearDF$Emission <- emissionPerYearDF$Emission/10e+04
#Opening png device
png(filename='plot4.png')

#Creating barplot
barplot(emissionPerYearDF$Emission,
       names.arg = emissionPerYearDF$Year,
       xlab = "Years",
       ylab = "Total Emission [tons x 10e+04]",
       main = expression("1999 to 2008 PM"[2.5]*" emission from coal combustion-related sources"))

dev.off()