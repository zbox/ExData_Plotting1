datadir <- 'power_consumption'

# Create directory if it not exists
if (!dir.exists(datadir)) {
  dir.create(datadir)
}

# Download and unzip data set archive
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile=paste(datadir, 'dataset.zip', sep = '/'))
unzip(zipfile=paste(datadir, 'dataset.zip', sep = '/'), exdir=datadir)

# Load data
filePath <- paste(datadir, 'household_power_consumption.txt', sep = '/')
dataset <- read.table(filePath, sep = ';', na.strings='?', header=TRUE)
res <- dataset[(dataset$Date == '1/2/2007' | dataset$Date == '2/2/2007'),]

res$Date <- as.Date(res$Date, format='%d/%m/%Y')
res$DateTime <- as.POSIXct(paste(res$Date, res$Time))

# Create png
png('plot2.png', height=480, width=480, res=120)

# Generate plot
plot(
	res$Global_active_power~res$DateTime, 
	ylab='Global Active Power (kilowatts)', 
	xlab='', 
	type='l'
)

dev.off()

