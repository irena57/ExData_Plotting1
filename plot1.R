## Assignment 1 in Exploratory Data Analysis, plot #1
## Plotting the histogram of Global Active Power consumption (plot 1)


#####################################################################
# Reading data from the file "household_power_consumption.txt" 
	consumption_data <- read.csv("household_power_consumption.txt",sep=";",head=TRUE,colClasses = "character") 
	

#####################################################################
# Conversion of the Date variable to Date class in R
	consumption_data$Date <- strptime(consumption_data$Date,"%d/%m/%Y") # converts to Date class
	consumption_data$Date <- as.Date(consumption_data$Date)             # removes PST from format
	
# Converting rest columns from "character" to "numeric"
	for(i in 3:9) consumption_data[,i]<-as.numeric(consumption_data[,i])# missing values "?" coerce to NA
	

#####################################################################
# Subsetting only the dates which interest us (2007-02-01 and 2007-02-02)
	dates=c("2007-02-01","2007-02-02")
	consumption_Febr2007 <- subset (consumption_data,
			            consumption_data$Date == dates[1] | consumption_data$Date == dates[2])


#####################################################################
#  Eliminating NA values (coerced from "?")
	x <- consumption_Febr2007$Global_active_power
	bad<-is.na(x)
	x <- x[!bad]


#####################################################################
# Histogram construction and launching it into .png file 480 pixels by 480 pixels
	png(filename = "plot1.png",width = 480, height = 480, units = "px")
	hist(x, col="red", main="Global Active Power",xlab="Global Active Power (kilowatts)")
	dev.off()

#####################################################################
