
############################################
#IST 687- Introduction to Data Science
# Due date - 10/18/2018 by 11:59 p.m.
# Homework 7 (Maps)
# Submitted by- Aniruddh Garge
# SUID- 863559754
# Submitted on- 10/17/2018
# Portions of this code came from Introduction to Data Science and Internet
# Comments are all original.

# Cleaning the data set given and renaming the columns.
raw_data<-raw_data[,-1:-4]
raw_data<-raw_data[-c(1,53,10),]
colnames(raw_data) <- c("stateName","population","popOver18","percentOver18")
raw_data

arrests<-USArrests
arrests <- cbind(rownames(arrests),arrests)
colnames(arrests) <- c("stateName")
arrests

# Merging the 2 data sets and renaming the columns.
final_data<-merge(raw_data,arrests)
colnames(final_data) <- c("stateName","population","popOver18","percentOver18","Murder","Assault","UrbanPop","Rape")
final_data

library(ggplot2)
library(ggmap)

# In built parameters in ggmap
state.area
state.name

# Using state.area to create a new column in the merged data set.
final_data$area<-state.area
final_data

# Finding the latitude and longitude coordinates and adding them to the merged data set.
state_center<-data.frame(state.center)
state_center
final_data$longitude<- state_center$x
final_data$latitude<- state_center$y
final_data

# ggplot expects the state names to be in lower case. (In the book "Introduction to Data Science.")
final_data$stateName<-tolower(final_data$stateName)
final_data

# Generating US map as per state names.
US<-map_data("state")

# Color coded map based on area of the state
area_map<-ggplot(final_data, aes(map_id=stateName)) + geom_map(map=US, aes(fill=area),color="blue")
area_map<- area_map + expand_limits(x=US$long, y=US$lat)
area_map

# Generating a map based on murder rate in every state.
murder_map<- ggplot(final_data,aes(map_id=stateName))+ geom_map(map=US,aes(fill=Murder),color="yellow")
murder_map<-murder_map + expand_limits(x=US$long, y=US$lat)
murder_map

# Generating a bubble chart on map which shows murder rate on map and population as a bubble on the map.
population_bubble<-ggplot(final_data,aes(map_id=stateName))+geom_map(map=US,aes(fill=Murder),color="blue")
population_bubble<-population_bubble+expand_limits(x=US$long,y=US$lat)
population_bubble<- population_bubble + geom_point(aes(x=final_data$longitude, y=final_data$latitude, size=final_data$population)) + coord_map()
population_bubble<-population_bubble + ggtitle("Population Bubble Chart")
population_bubble

# Showing the murder rate only for the northeast states.
northeast_murder<- murder_map+ xlim(-83.93, -63.93) + ylim(30.73, 50.73)
northeast_murder

# Showing the above generated bubble chart for northeast states.
northeast_population<-population_bubble + xlim(-83.93, -63.93) + ylim(30.73, 50.73)
northeast_population


