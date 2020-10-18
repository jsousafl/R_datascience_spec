NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Summarizing emissions per year
emissionPerYear <- with(NEI, tapply(Emissions,year,sum))

#Creating Data Frame
df_summ <- data.frame(Year = names(emissionPerYear), Total.Emission = emissionPerYear)

df_summ$Total.Emission <- df_summ$Total.Emission/10e+06

#Opening png device
png(filename='plot1.png')

#Creating barplot 
barplot(df_summ$Total.Emission, 
        names.arg = df_summ$Year, 
        xlab = "Years", 
        ylab = "Total Emission [tons x 10e+06]",
        main = "Evolution of PM 2.5 emission from 1999 to 2008")

dev.off()