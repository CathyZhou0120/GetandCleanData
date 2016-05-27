library(reshape2)

#get file from destination and unzip it
setwd("C:\\Users\\user\\R_assignment")
fileunzip<-unzip("UCI HAR Dataset.zip")


#Merges the training and the test sets to create one data set
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2]<-as.character(activity[,2])
features<-read.table("UCI HAR Dataset/features.txt")
features[,2]<-as.character(features[,2])

subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt")
x_test<-read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table("UCI HAR Dataset\\test\\y_test.txt")

subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt")
x_train<-read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train<-read.table("UCI HAR Dataset\\train\\y_train.txt")

test.all<-cbind(subject_test,y_test,x_test)
train.all<-cbind(subject_train,y_train,x_train)

#Extracts only the measurements on the mean and standard deviation for each measurement

feature.names<-grepl(".*mean.*|.*std.*",features)
feature.lable<-features[feature.names,2]
feature.lable<-gsub("[-|()]","",feature.lable)

#Uses descriptive activity names to name the activities in the data set

all.data<-rbind(test.all,train.all)

colnames(all.data) <- c("subject", "activity", feature.lable)
all.data$activity <- factor(all.data$activity, levels = activity[,1], labels = activity[,2])
all.data$subject <- as.factor(all.data$subject)

all.data2<- melt(all.data, id = c("subject", "activity"))

#calculate mean
all.data.mean <- dcast(all.data2, subject + activity ~ variable, mean)

#write to table
write.table(all.data.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)






