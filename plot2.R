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
png("plot2.png", width=400, height=400)
##create the plot
plot(hpc2$DateTime, hpc2$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
##write to file
dev.off()