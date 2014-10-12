## Assignment 1 in Exploratory Data Analysis, plot #3
## Plotting the Energy sub meterings for various part of the household vs Time (plot 3)


#####################################################################
# Reading data from the file "household_power_consumption.txt" 
#
# Variables (columns meaning):
## 1. Date: Date in format dd/mm/yyyy
## 2. Time: time in format hh:mm:ss
## 3. Global_active_power: household global minute-averaged active power (in kilowatt)
## 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## 5. Voltage: minute-averaged voltage (in volt)
## 6. Global_intensity: household global minute-averaged current intensity (in ampere)
## 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
## 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
	
	consumption_data <- read.csv("household_power_consumption.txt",sep=";",head=TRUE,colClasses = "character") 
	

#####################################################################
# Conversion of the Date and Time variables to Date/Time classes in R
	consumption_data$Date <- strptime(consumption_data$Date,"%d/%m/%Y") # converts to Data class
	consumption_data$Date <- as.Date(consumption_data$Date)             # removes PST from format
	date <- consumption_data$Date
	time <- consumption_data$Time
	t <- paste(date, time)
	consumption_data$DT <- t       # adding new column of combined Date and Time to dataframe
	consumption_data$DT<-strptime(consumption_data$DT, "%Y-%m-%d %H:%M:%S") # converts to Time class

# Converting rest columns from "character" to "numeric"
	for(i in 3:9) consumption_data[,i]<-as.numeric(consumption_data[,i])# missing values "?" coerce to NA
	

#####################################################################
# Subsetting only the dates which interest us (2007-02-01 and 2007-02-02)
	dates=c("2007-02-01","2007-02-02")
	consumption_Febr2007 <- subset (consumption_data,
			            consumption_data$Date == dates[1] | consumption_data$Date == dates[2],na.rm=TRUE)


#####################################################################
# Eliminating NA values (coerced from "?")
	complete<- 
		!is.na(consumption_Febr2007$Sub_metering_1) & !is.na(consumption_Febr2007$Sub_metering_2) & !is.na(consumption_Febr2007$Sub_metering_3)
	y1 <- consumption_Febr2007$Sub_metering_1
	y2 <- consumption_Febr2007$Sub_metering_2
	y3 <- consumption_Febr2007$Sub_metering_3
	y1 <- y1[complete]
	y2 <- y2[complete]
	y3 <- y3[complete]
	x <- consumption_Febr2007$DT[complete]
		

#####################################################################
# Plot construction and launching it into .png file 480 pixels by 480 pixels
	png(filename = "plot3.png",width = 480, height = 480, units = "px")
	   par(pin=c(4.0,3.5))							# plot size in inches - global parameter
	   plot(x,y1,type="n",xlab=" ",ylab="Energy sub metering")	# just setup for the plot
	   lines(x,y1,col="black")						# plotting y1
	   lines(x,y2,col="red")						# plotting y2
	   lines(x,y3,col="blue")						# plotting y3
	   legends <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
	   colors <- c("black","red","blue")
	   legend("topright",lty=1,lwd=1,col=colors,legend=legends)
	dev.off()

