
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

area_map<-ggplot(final_data, aes(map_id=stateName)) + geom_map(map=US, aes(fill=area),color="blue")
area_map<- area_map + expand_limits(x=US$long, y=US$lat)
area_map

murder_map<- ggplot(final_data,aes(map_id=stateName))+ geom_map(map=US,aes(fill=Murder),color="yellow")
murder_map<-murder_map + expand_limits(x=US$long, y=US$lat)
murder_map

population_bubble<-ggplot(final_data,aes(size=population)) + geom_point(colour="blue",aes(size=population)) + xlab("Population")















