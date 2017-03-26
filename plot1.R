##read data from the file and replace ? with NA
hpc <- read.table("../data/household_power_consumption.txt", stringsAsFactors=FALSE, 
                  header = TRUE, sep=";", na.strings=c("?","NA"))
##convert first column to date
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
##subset 02/01/2007 and 02/02/2007
hpc2 <- subset(hpc, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
##initialize the picture
png("plot1.png", width=400, height=400)
##create the histogram
hist(hpc2$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",
     ylab="Frequency", col="red")
##write to file
dev.off()
