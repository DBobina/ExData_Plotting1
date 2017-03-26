library(dplyr)

##read data from the file and replace ? with NA
hpc <- read.table("../data/household_power_consumption.txt", stringsAsFactors=FALSE, 
                  header = TRUE, sep=";", na.strings=c("?","NA"))
##create a new column by concatenating the date and time data
hpc <- mutate(hpc, DateTime = paste(hpc$Date, hpc$Time))
##convert new column to datetime
hpc$DateTime <- strptime(as.character(hpc$DateTime), "%d/%m/%Y %H:%M:%S")
##convert first column to date
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
##subset 02/01/2007 and 02/02/2007
hpc2 <- subset(hpc, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

##initialize the picture
png("plot4.png", width=400, height=400)

par(mfcol = c(2,2), mar = c(4,4,1,0.5), oma = c(0,0,2,0))

###Add first plot
plot(hpc2$DateTime, hpc2$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

###Add second plot
plot(hpc2$DateTime,hpc2$Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "n")
##add data sets
points(hpc2$DateTime,hpc2$Sub_metering_1,col="black", type="l")
points(hpc2$DateTime,hpc2$Sub_metering_2,col="red", type="l")
points(hpc2$DateTime,hpc2$Sub_metering_3,col="blue", type="l")
##add the legend
legend("topright", lty=1, box.lwd=0, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

###Add third plot
plot(hpc2$DateTime, hpc2$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

###Add forth plot
plot(hpc2$DateTime, hpc2$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

##write to file
dev.off()


