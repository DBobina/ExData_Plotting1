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
png("plot3.png", width=400, height=400)

##create plot with only the axis and labels no data
plot(hpc2$DateTime,hpc2$Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "n")
##add data sets
points(hpc2$DateTime,hpc2$Sub_metering_1,col="black", type="l")
points(hpc2$DateTime,hpc2$Sub_metering_2,col="red", type="l")
points(hpc2$DateTime,hpc2$Sub_metering_3,col="blue", type="l")
##add the legend
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##write to file
dev.off()


