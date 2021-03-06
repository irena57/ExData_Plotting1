## Assignment 1 in Exploratory Data Analysis, plot #4
## Plotting a set of 4 plots concerning Energy Consumption (plot 4)


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
	consumption_data$Date <- strptime(consumption_data$Date,"%d/%m/%Y") # converts to Date class
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
# Setting variables and eliminating NA values (coerced from "?")
# 1) For Plot #1
	y1 <- consumption_Febr2007$Global_active_power
	bad<-is.na(y1)
	y1 <- y1[!bad]
	x1 <- consumption_Febr2007$DT[!is.na(consumption_Febr2007$Global_active_power)]
# 2) For Plot #2
	complete<- 
		!is.na(consumption_Febr2007$Sub_metering_1) & !is.na(consumption_Febr2007$Sub_metering_2) & !is.na(consumption_Febr2007$Sub_metering_3)
	y2_1 <- consumption_Febr2007$Sub_metering_1
	y2_2 <- consumption_Febr2007$Sub_metering_2
	y2_3 <- consumption_Febr2007$Sub_metering_3
	y2_1 <- y2_1[complete]
	y2_2 <- y2_2[complete]
	y2_3 <- y2_3[complete]
	x2 <- consumption_Febr2007$DT[complete]
# 3) For Plot #3
	y3 <- consumption_Febr2007$Voltage[!is.na(consumption_Febr2007$Voltage)]
	x3 <- consumption_Febr2007$DT[!is.na(consumption_Febr2007$Voltage)]
# 4) For Plot #4
	y4 <- consumption_Febr2007$Global_reactive_power[!is.na(consumption_Febr2007$Global_reactive_power)]
	x4 <- consumption_Febr2007$DT[!is.na(consumption_Febr2007$Global_reactive_power)]
	

#####################################################################
# Plot construction and launching it into .png file 480 pixels by 480 pixels
	png(filename = "plot4.png",width = 480, height = 480, units = "px")
 	par(mfcol=c(2,2),oma=c(0,1,0,0),mar=c(4,0,0,2),pin=c(2.0,1.75))	# setting layout
		
plot(x1,y1,type="n",xlab=" ",ylab="Global Active Power")			# plot 1
	lines(x1,y1,lwd=0.7)
					           
plot(x2,y2_1,type="n",xlab=" ",ylab="Energy sub metering")			# plot 2
	lines(x2,y2_1,col="black",lwd=0.8)
	lines(x2,y2_2,col="red",lwd=0.8)
	lines(x2,y2_3,col="blue",lwd=0.8)	  				  
	legends <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3") 
	colors <- c("black","red","blue")
	legend("topright",cex=0.85,lty=1,lwd=1,col=colors,legend=legends,bty="n") 

plot(x3,y3,type="n",xlab="datetime",ylab="Voltage")				# plot 3
	lines(x3,y3,lwd=0.8,asp=0.375)
		
plot(x4,y4,type="n",xlab="datetime",ylab="Global_reactive_power")		# plot 4
	lines(x4,y4,lwd=0.8,asp=0.375)
	
	dev.off()

