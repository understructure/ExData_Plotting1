
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

# create numeric from character variable
pwr2$Global_active_power2 <- as.numeric(pwr2$Global_active_power)

# create and save file
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg="white")
hist(pwr2$Global_active_power2, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
#, cex.lab=0.9, cex.axis=0.9
dev.off()