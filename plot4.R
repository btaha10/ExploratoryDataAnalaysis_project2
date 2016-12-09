
# Load datasets from local area
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?

# Coal combustion related sources
coalsrc = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge NEI & SCC data sets
mergedset <- merge(x=NEI, y=coalsrc, by='SCC')
mergedsum <- aggregate(mergedset[, 'Emissions'], by=list(mergedset$year), sum)
colnames(mergedsum) <- c('Year', 'Emissions')
# resize limit for Y-axis
rng1 <- which.min(mergedsum$Emissions)
rng2 <- which.max(mergedsum$Emissions)
hlimit <- ceiling(mergedsum$Emissions[rng2]*1.1/1000)
llimit <- floor(mergedsum$Emissions[rng1]*.9/1000)

p <- ggplot(data=mergedsum, aes(x=Year, y=Emissions/1000, ymin = llimit, ymax = hlimit)) + 
geom_line(aes(group=1, col=Emissions)) +
geom_point(aes(size=2, col=Emissions)) +
ggtitle(expression('Total Emissions of PM2.5 from coal combustion across the United States')) +  
ylab(c('PM2.5 in kilotons')) +
geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=.5, vjust=-.7)) +
theme(legend.position='none')

# Generate the graph in the same directory as the source code 
ggsave(filename='plot4.png',p)

