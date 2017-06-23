#First set working directory
setwd("C:/Users/Amanda/Documents/Data Science Specialization/Getting and Cleaning Data")
#Load all data
activitylabel<-read.table("activity_labels.txt")
features<-read.table("features.txt")
subjecttest<-read.table("subject_test.txt")
subjecttrain<-read.table("subject_train.txt")
xtest<-read.table("X_test.txt")
xtrain<-read.table("X_train.txt")
ytest<-read.table("y_test.txt")
ytrain<-read.table("y_train.txt")
#Make column names
colnames(activitylabel)<-c("ActivityID","ActivityType")
colnames(subjecttrain)<-"SubjectID"
colnames(xtrain)<-features[,2]
colnames(ytrain)<-"ActivityID"
colnames(subjecttest)<-"SubjectID"
colnames(xtest)<-features[,2]
colnames(ytest)<-"ActivityID"
#Merge first Test data then Train Data
testdata<-cbind(subjecttest,xtest,ytest)
traindata<-cbind(subjecttrain,xtrain,ytrain)
#Merge both data sets together
finaldata<-rbind(testdata,traindata)
#Extract mean and standard deviation
mean(features$V1)
sd(features$V1)
meanandstd<-finaldata[,grepl("mean|std|Subject|ActivityID",colnames(finaldata))]
#Load the plyr package for gsub for descriptive names
library(plyr)
names(meanandstd)<-gsub("^t","Time",names(meanandstd))
names(meanandstd)<-gsub("Acc","Accelerometer",names(meanandstd))
names(meanandstd)<-gsub("Gyro","Gyroscope",names(meanandstd))
names(meanandstd)<-gsub("Mag","Magnitude",names(meanandstd))
names(meanandstd)
#Create a new tidy data set
secondtidydata<-ddply(meanandstd,c("SubjectID","ActivityID"),numcolwise(mean))
write.table(secondtidydata,file = "secondtidydata.txt")