
# Load datasets from local area
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

# filter out baltimore data from dataset  
baltimore <- subset(NEI, fips=='24510')

# change int years to factors
baltimore$year <- factor(baltimore$year, levels=c('1999', '2002', '2005', '2008'))

p <- ggplot(data=baltimore, aes(x=year, y=log(Emissions))) +
facet_grid(. ~ type) + guides(fill=F) + xlab('Year') +
ylab(c('Log of PM2.5 Emissions')) +
ggtitle('Emissions per Type in Baltimore City, Maryland') +
geom_boxplot(aes(fill=type)) + 
stat_boxplot(geom ='errorbar')

# Generate the graph in the same directory as the source code 
ggsave(filename='plot3.png',p)


