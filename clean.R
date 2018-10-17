

raw_data<-raw_data[,-1:-4]
raw_data<-raw_data[-c(1,53,10),]
colnames(raw_data) <- c("stateName","population","popOver18","percentOver18")
raw_data

arrests<-USArrests
arrests <- cbind(rownames(arrests),arrests)
colnames(arrests) <- c("stateName")
arrests

final_data<-merge(raw_data,arrests)
colnames(final_data) <- c("stateName","population","popOver18","percentOver18","Murder","Assault","UrbanPop","Rape")
final_data

library(ggplot2)
library(ggmap)

state.area
state.name
