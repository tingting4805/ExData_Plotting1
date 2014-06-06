## Initialization with loading packages...
library(sqldf)
library(gsubfn)
library(RSQLite)
library(DBI)
library(RSQLite.extfuns)

## Read in data.
f <- file("household_power_consumption.txt")
bigdf <- sqldf("select * from f where Date='1/2/2007' or Date='2/2/2007'", 
               dbname = tempfile(), 
               file.format = list(row.names = F, header = T, sep=";"))
## ... tempfile() has been specified in order to store temporary files
## on disk.
## ... only entries with Date = '1/2/2007' or '2/2/2007' would be 
## loaded. 

## Start plotting...
png(file = "plot4.png") ## Open png device;
## Create plot and send to the file
## First convert time to POSIXct format.
bigdf$ConvertedDateTime <- paste(bigdf$Date, bigdf$Time)
bigdf$ConvertedDateTime <- as.POSIXct(strptime(bigdf$ConvertedDateTime, 
                                               format = "%d/%m/%Y %H:%M:%S"))


par(mfrow = c(2,2))
with(bigdf, {
  plot(ConvertedDateTime,Global_active_power,type="l", ylab="Global Active Power",xlab="")
  plot(ConvertedDateTime, Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(ConvertedDateTime,Sub_metering_1,type="l", col="black",
       xlab = "", ylab = "Energy sub metering")
  lines(bigdf$ConvertedDateTime,bigdf$Sub_metering_2,col="red")
  lines(bigdf$ConvertedDateTime,bigdf$Sub_metering_3,col="blue")
  legend("topright",lty = 1,bty="n",col=c("black","red","blue"),
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(ConvertedDateTime,Global_reactive_power,type="l", xlab="datetime")
})

dev.off()  ## Close the PNG file device.
close(f)