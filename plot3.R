
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
## 7. This file re-create plot 3



## set the working directory
setwd("c:\\Development\\R\\Coursera\\04 - Exploratory data analysis\\Week 1") 

## specify the source file name and location
sourcefilename <- "./data/household_power_consumption.txt"

## search for the specific row in the dataset
startrow <- grep("1/2/2007", readLines(sourcefilename))[1]-1

## search for the last row of the subset 
endrow <- grep("3/2/2007", readLines(sourcefilename))[1]-1

## read the header seperately
myheader <-read.table(sourcefilename,header = FALSE, sep = ";",nrows= 1,stringsAsFactors = FALSE)

## read the subset of data using skip & nrows. Set na.strings = "?"
subsetofdata <- read.table(sourcefilename,header = FALSE, sep = ";",na.strings = "?",skip=startrow,nrows= (endrow - startrow))

## Remove NA rows with complete.cases function 
subsetofdata <- subsetofdata[which(complete.cases(subsetofdata)),]

## add the header as colnames for the dataframe
colnames(subsetofdata) <- unlist(myheader)

## create a new column by converting the concatenated V1 & V2 to datetime 
subsetofdata$mydatetime <-  strptime(paste(subsetofdata$Date,subsetofdata$Time),"%d/%m/%Y %H:%M:%S")  

## Plot 3 to png
png(filename = "plot3.png",width = 480, height = 480, units = "px", pointsize = 12)
  
## create plot 3

## plot Sub_metering_1
plot(subsetofdata$mydatetime,subsetofdata$Sub_metering_1,type="l",lty = 1,xlab="",ylab="Energy sub metering")
## add line for Sub_metering_2 -red
lines(subsetofdata$mydatetime,subsetofdata$Sub_metering_2,type="l",lty = 1,col="red")
## add line for Sub_metering_3 -  blue
lines(subsetofdata$mydatetime,subsetofdata$Sub_metering_3,type="l",lty = 1,col="blue")
## add legend without border
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
 
## close the graphical device
dev.off()

