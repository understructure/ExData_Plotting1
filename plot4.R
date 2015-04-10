
# download the file and get it into a variable
# NOTE : If you're on Windows or an OS without this directory,
# you must change this to an existing directory in order to
# run this code successfully!

myDir <-"~/Downloads"
setwd(myDir)

# get the file, you may need the rCurl library installed for this to work
www <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temporaryFile <- tempfile()
download.file(www,destfile=temporaryFile, method="curl")
unzip(temporaryFile, exdir="myDir")
pwr <- read.csv("household_power_consumption.txt", stringsAsFactors=FALSE, sep=";")

# get date into proper format
pwr$date2 <- as.Date(pwr$Date, "%d/%m/%Y")

# create smaller dataset
pwr2 <-  pwr[pwr$date2 == "2007-02-01" | pwr$date2 == "2007-02-02",]

# create numeric from character variables

# for plot 1
pwr2$Voltage2 <- as.numeric(pwr2$Voltage)

# for plot 2
pwr2$Global_active_power2 <- as.numeric(pwr2$Global_active_power)

# for plot 3
pwr2$Sub_metering_1 <- as.numeric(as.character(pwr2$Sub_metering_1))
pwr2$Sub_metering_2 <- as.numeric(as.character(pwr2$Sub_metering_2))
pwr2$Sub_metering_3 <- as.numeric(as.character(pwr2$Sub_metering_3))

# for plot 4
pwr2$Global_reactive_power2 <- as.numeric(pwr2$Global_reactive_power)
# create and save file


png(filename = "plot4.png", width = 480, height = 480, units = "px", bg="white")

# setup for four panel plot
par(mfrow=c(2,2))
# plot 4-1
plot(pwr2$Global_active_power2, xlab=NA, type="l", ylab="Global Active Power (kilowatts)", xaxt='n')
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri", "Sat"))

# plot 4-2
plot(pwr2$Voltage2, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

# plot 4-3
plot(pwr2$Sub_metering_1, xlab=NA, type="n", ylab="Energy sub metering", xaxt='n', yaxt='n', ylim=c(0,40))
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri", "Sat"))

lines(pwr2$Sub_metering_1, col="black")
lines(pwr2$Sub_metering_2, col="red")
lines(pwr2$Sub_metering_3, col="blue")
axis(2, at=c(0, 10, 20, 30), labels=c("0", "10", "20", "30"))
#?legend
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(1,1),col=c("black", "red","blue"), bty="n"
                        #,cex=.7
       ) # gives the legend lines the correct color and width
       
# plot 4-4
plot(pwr2$Global_reactive_power2, type="l", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))
dev.off()

?legend
