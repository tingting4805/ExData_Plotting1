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
png(file = "plot1.png") ## Open png device;
## Create plot and send to the file
hist(bigdf$Global_active_power,col="red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()  ## Close the PNG file device.
close(f)
