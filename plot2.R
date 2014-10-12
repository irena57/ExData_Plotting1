## Assignment 1 in Exploratory Data Analysis, plot #2
## Plotting the Global Active Power consumption vs Date and Time (plot 2)


#####################################################################
# Reading data from the file "household_power_consumption.txt" 
#
# Variables (columns meaning):
## 1. Date: Date in format dd/mm/yyyy
## 2. Time: time in format hh:mm:ss
## 3. Global_active_power: household global minute-averaged active power (in kilowatt)

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
	for(i in 3:9) consumption_data[,i]<-as.numeric(consumption_data[,i])  # missing values "?" coerce to NA
	

#####################################################################
# Subsetting only the dates which interest us (2007-02-01 and 2007-02-02)
	dates=c("2007-02-01","2007-02-02")
	consumption_Febr2007 <- subset (consumption_data,
			            consumption_data$Date == dates[1] | consumption_data$Date == dates[2],na.rm=TRUE)


#####################################################################
# Eliminating NA values (coerced from "?")
	y <- consumption_Febr2007$Global_active_power
	bad<-is.na(y)
	y <- y[!bad]
	x <- consumption_Febr2007$DT[!is.na(consumption_Febr2007$Global_active_power)]


#####################################################################
# Plot construction and launching it into .png file 480 pixels by 480 pixels
png(filename = "plot2.png",width = 480, height = 480, units = "px")
	par(pin=c(4.0,3.5))   				                         # plot size in inches - global parameter
	plot(x,y,type="n",xlab=" ",ylab="Global Active Power (kilowatts)")       # just setup for the plot
	lines(x,y)					                         # plotting y vs x with lines
dev.off()

