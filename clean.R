

raw_data<-raw_data[,-1:-4]
raw_data<-raw_data[-c(1,53,10),]
colnames(raw_data) <- c("stateName","population","popOver18","percentOver18")
raw_data

arrests<-USArrests
arrests
