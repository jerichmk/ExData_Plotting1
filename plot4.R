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

##combine date and time columns into one
datetime <- as.POSIXct(paste(raw2$Date, raw2$Time))
raw3 <- cbind(datetime, raw2)

par(mfrow=c(2,2))
plot(raw3$datetime, raw3$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(raw3$datetime, raw3$Global_intensity, type="l", col="black", xlab="datetime", ylab="Voltage")


plot(raw3$datetime, raw3$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(raw3$datetime, raw3$Sub_metering_3, type="l", col="blue")
lines(raw3$datetime, raw3$Sub_metering_2, type="l", col="red")

legend("topright", legend=c("Sub metering 1","Sub metering 2","Sub metering 3"),
       col=c("black","red", "blue"), lty="solid")

plot(raw3$datetime, raw3$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()