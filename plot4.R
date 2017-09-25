
## Programmer: Jacques du Plessis
## Date: 24 September 2017
## Course: Exploratory Data Analysis - Week 1
## Assignment Notes: 
## 1. We will only be using data from the dates 2007-02-01 and 2007-02-02.
## 2. Read the data from just those dates rather than reading in the entire dataset
## 3. Convert the Date and Time variables to Date/Time classes using strptime
## 4. Note that in this dataset missing values are coded as ?
## 5. Create a separate R code file per plot
## 6. Your code should include code for reading the data so that the plot can be fully reproduced
## 7. This file re-create plot 4



## set the working directory
setwd("c:\\Development\\R\\Coursera\\04 - Exploratory data analysis\\Week 1") 
  
## specify the source file name and location
sourcefilename <- "./data/household_power_consumption.txt"
  
## search for the specific row in the dataset
startrow <- grep("1/2/2007", readLines(sourcefilename))[1]-1
  
## search for the last row of the subset 
endrow <- grep("3/2/2007", readLines(sourcefilename))[1]-1

## read the subset of data using skip & nrows. Set na.strings = "?"
subsetofdata <- read.table(sourcefilename,header = FALSE, sep = ";",na.strings = "?",skip=startrow,nrows= (endrow - startrow))
  
## Remove NA rows with complete.cases function 
subsetofdata <- subsetofdata[which(complete.cases(subsetofdata)),]
  
## create a new column by converting the concatenated V1 & V2 to datetime 
subsetofdata$mydatetime <-  strptime(paste(subsetofdata$V1,subsetofdata$V2),"%d/%m/%Y %H:%M:%S")  

## Plot 4 graphs to plot no 4 png
png(filename = "plot4.png",width = 480, height = 480, units = "px", pointsize = 12)

## create 4 plots from left to right and top to bottom
par(mfrow=c(2,2))

## first plot - Global Active Power
plot(subsetofdata$mydatetime,subsetofdata$V3,type="l",lty = 1,xlab="",ylab="Global Active Power")
## second plot - Voltage
plot(subsetofdata$mydatetime,subsetofdata$V5,type="l",lty = 1,xlab="datetime",ylab="Voltage")
## third plot - Energy sub metering
plot(subsetofdata$mydatetime,subsetofdata$V7,type="l",lty = 1,xlab="",ylab="Energy sub metering")
lines(subsetofdata$mydatetime,subsetofdata$V8,type="l",lty = 1,col="red")
lines(subsetofdata$mydatetime,subsetofdata$V9,type="l",lty = 1,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## fourth plot - Global_reactive_power 
plot(subsetofdata$mydatetime,subsetofdata$V4,type="l",lty = 1,xlab="datetime",ylab="Global_reactive_power")

## close the graphical device
dev.off()

