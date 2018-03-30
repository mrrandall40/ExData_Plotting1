#plot1.R

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
#setClass("myTime")
#setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S"))

mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
           na.strings = "?", colClasses = c("myDate","character","numeric","numeric",
           "numeric","numeric","numeric","numeric","numeric"))

mysubset <- subset(mydata,mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02")

hist(mysubset$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.copy(device = png, "plot1.png")

dev.off()

print(dev.cur())