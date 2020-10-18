NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset df using baltimore fips
NEI_baltimore <- subset(NEI,fips == "24510")
# Summarizing emissions per year
emissionPerYear <- with(NEI_baltimore, tapply(Emissions,year,sum))

#Creating Data Frame
df_summ <- data.frame(Year = names(emissionPerYear), Total.Emission = emissionPerYear)

#Opening png device
png(filename='plot2.png')

#Creating barplot 
barplot(df_summ$Total.Emission, 
        names.arg = df_summ$Year, 
        xlab = "Years", 
        ylab = "Total Emission",
        main = "PM 2.5 emission from 1999 to 2008 in Baltimore City")

dev.off()