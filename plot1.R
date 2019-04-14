library(lubridate)
raw <- read.table("household_power_consumption.txt", header=FALSE, sep=";", skip=66637, nrows=2880, na.strings="?")
colnames(raw) <- c("Date",
                   "Time",
                   "Global_active_power",
                   "Global_reactive_power",
                   "Global_intensity",
                   "Voltage",
                   "Sub_metering_1",
                   "Sub_metering_2",
                   "Sub_metering_3")

##changed the date format from dmy to ymd
Date <- dmy(raw$Date)

##removed the wrong date column and cbind with correct format
raw2 <- cbind(Date,subset(raw, select = -Date))

hist(raw2$Global_active_power, freq=TRUE, main="Global Active Power",xlab="Global Active Power(kilowatts)", ylab="Frequency", col="red")
    
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()