
# Load datasets from local area
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# motor vehicle related sources
gasolinesrc = SCC[grepl("vehicle", SCC$Short.Name, ignore.case=TRUE),]
# filter out baltimore data from dataset related to motor vehicle
baltimore <- subset(NEI, fips=='24510' & SCC %in% gasolinesrc$SCC)

# change int years to factors
baltimore$year <- factor(baltimore$year, levels=c('1999', '2002', '2005', '2008'))
# Aggregate tons of emissions from motor-related sources by year in Baltimore 
baltimore <- aggregate(Emissions ~ year, baltimore, FUN=sum)
baltimore$PM <- round(baltimore[,2],2)
largest <- which.max(baltimore$PM)

# resize limit for Y-axis
ylimit <- round(ceiling(baltimore$PM[[largest]]*1.1))

p <- ggplot(data=baltimore, aes(x=year, y=Emissions, ymax = ylimit)) +
guides(fill=FALSE) + 
geom_bar(stat='identity', aes(fill=year)) +
geom_text(aes(label=round(Emissions,digits=2), size=2, hjust=.5, vjust=-.7)) +
ggtitle(c('Total Emissions of PM2.5 from Motor Vehicle Sources in Baltimore, Maryland')) +
theme(legend.position = 'none') + 
ylab(c('PM2.5 in Tons')) +
xlab('Year')  

# Generate the graph in the same directory as the source code 
ggsave(filename='plot5.png',p)

