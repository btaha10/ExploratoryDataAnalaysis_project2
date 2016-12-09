
# Load datasets from local area
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?  
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources  
# for each of the years 1999, 2002, 2005, and 2008.

# Generate the graph in the same directory as the source code
png(filename='plot1.png', width=600, height=400, units='px')

# set facet to one plotting region
par(mfrow=c(1,1), mar=c(5,5,3,1))
names(NEI)
unique(NEI$Pollutant)

yearlyemis <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
yearlyemis$PM <- round(yearlyemis[,2]/1000,2)
largest <- which.max(yearlyemis$PM)

# resize limit for Y-axis
ylimit <- round(ceiling(yearlyemis$PM[[largest]]*1.1))

barplot(yearlyemis$PM, names.arg=yearlyemis[,1],  
        xlab='Year', ylab=c('PM2.5 in Kilotons'), ylim=c(0,ylimit),
        main=c('Total Emission of PM2.5 in the United States')) 

dev.off()
