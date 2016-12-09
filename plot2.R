
# Load datasets from local area
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")  
# from 1999 to 2008? Use the base plotting system to make a plot answering this question. 

# Generate the graph in the same directory as the source code
png(filename='plot2.png', width=600, height=400, units='px')

# set facet to one plotting region
par(mfrow=c(1,1), mar=c(5,5,3,1))

# filter out baltimore data from dataset  
baltimore <- subset(NEI, fips=='24510')

yearlyemis <- tapply(X=baltimore$Emissions, INDEX=baltimore$year, FUN=sum)
largest <- which.max(yearlyemis)
# resize limit for Y-axis
ylimit <- round(ceiling(yearlyemis[[largest]]*1.1))

barplot(tapply(X=baltimore$Emissions, INDEX=baltimore$year, FUN=sum),
        xlab='Year', ylab=c('PM2.5'), ylim=c(0,ylimit),
        main='Total Emission in Baltimore City, Maryland')

dev.off()
