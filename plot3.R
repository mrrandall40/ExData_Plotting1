#plot3.R

#download the source data
if (!file.exists("exdata_data_household_power_consumption.zip")){
        download.file(url  =  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile = "exdata_data_household_power_consumption.zip")
}

#extract the source data
if (!file.exists("household_power_consumption.txt")){
        unzip("exdata_data_household_power_consumption.zip", exdir = getwd())
}

#import non-standard date format https://stackoverflow.com/questions/13022299/specify-custom-date-format-for-colclasses-argument-in-read-table-read-csv
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
                     ,na.strings = "?", colClasses = c("myDate","character",
                                                       "numeric","numeric","numeric","numeric","numeric",
                                                       "numeric","numeric"))

mysubset <- subset(mydata,mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02")

mysubset$DateTime <-  as.POSIXct(paste(mysubset$Date, mysubset$Time))

png(filename = "plot3.png", width = 480, height = 480)

plot(mysubset$DateTime,mysubset$Sub_metering_1,type = "l", 
     ylab = "Energy Sub Metering", xlab = "")
points(mysubset$DateTime,mysubset$Sub_metering_2, col = "red", type = "l")
points(mysubset$DateTime,mysubset$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty=1, lwd=1, col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#dev.copy(device = png, "plot3.png")

dev.off()

print(dev.cur())