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
png('plot4.png', height=480, width=480, res=120)

# Generate plot
par(mfrow=c(2,2), mar=c(4,4,2,1))

plot(
	res$Global_active_power~res$DateTime, 
	ylab='Global Active Power', 
	xlab='', 
	type='l'
)

plot(
	res$Voltage~res$DateTime, 
	ylab='Voltage', 
	xlab='datetime', 
	type='l'
)

plot(
	res$Sub_metering_1~res$DateTime, 
	ylab='Energy sub metering', 
	xlab='', 
	type='l'
)

lines(res$Sub_metering_2~res$DateTime, col='red')
lines(res$Sub_metering_3~res$DateTime, col='blue')

legend(
	'topright', 
	legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
	col=c('black', 'red', 'blue'), 
	bty='n',
	lwd=par('lwd'), 
	cex=0.5
)

plot(
	res$Global_reactive_power~res$DateTime, 
	ylab='Global_rective_power',
	xlab='datetime',
	type='l'
)

dev.off()
