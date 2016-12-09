
# Load datasets from local area
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

vehiclesrc = SCC[grepl("vehicle", SCC$Short.Name, ignore.case=TRUE),]

# filter out motor vehicle for baltimore/LosAngeles data from dataset
vehiclesEmis <- subset(NEI, (SCC %in% vehiclesrc$SCC) & (fips %in% c('24510','06037')))
# Aggregate tons of emissions from motor vehicle related sources by year in Baltimore
vehiclesEmisAll <- aggregate(Emissions ~ fips + year, vehiclesEmis, sum) 
vehiclesEmisAll$city <- factor(vehiclesEmisAll$fips,  
                     levels = c('24510','06037'),  
                     labels = c('Baltimore', 'Los Angeles')) 
vehiclesEmis$year <- factor(vehiclesEmis$year, levels = unique(vehiclesEmis$year)) 
largest <- which.max(vehiclesEmisAll$Emissions)

# resize limit for Y-axis
ylimit <- round(ceiling(vehiclesEmisAll$Emissions[[largest]]*1.1))

p <- ggplot(data=vehiclesEmisAll, aes(x=year, y=Emissions, group=city, color=city, ymax=ylimit)) +
geom_line() +
geom_point() +
geom_text(aes(label=round(Emissions,2), vjust=-0.5)) +
ggtitle(c('Total Emissions of PM2.5 from Motor Vehicle Sources')) +
ylab('Tons') +
xlab('Year')

# Generate the graph in the same directory as the source code 
ggsave(filename='plot6.png',p)

