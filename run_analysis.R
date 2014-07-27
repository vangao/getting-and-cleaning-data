##Data management
##
##This scrips first merge the training and test data set to new one, totaldata.
##Then  extract the mean and standard deviation for each measurement.
##After that,name the activities and values in the dataset
##finally, a second, independent tidy data set with the average of each variable 
##for each activity and each subject is created.
##

##read the files into R
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

##merge test and trainning data set to a new one
newdata<-rbind(x_train,x_test)

##merge the subject ID
newsubject<-rbind(subject_train,subject_test)
names(newsubject)<-"subject ID"

##merge the activity ID
newactivity<-rbind(y_train,y_test)
names(newactivity)<-"activity ID"

##merge all the data sets, question 1
totaldata<-cbind(newdata,newsubject,newactivity)

##extract the mean and std value, question 2
mean_std<-totaldata[,1:6]

##name the activities, question 3
names(activity_labels)<-c("activity ID","activity")
totaldata$"activity"<-activity_labels[totaldata$"activity ID",2]

##name each value, question4
namesthree<-c("subject ID","activity ID","activity")
namesfive<-as.character(features[,2])
value_names<-c(namesfive,namesthree)
names(totaldata)<-value_names

##question 5, a new dataset is created
finaldata<-data.frame()
for(i in 1:561){
	for(j in 1:6){
		log1<-totaldata[,562]==j
		datasetnew<-totaldata[which(log1),i]
		finaldata[i,j]<-mean(datasetnew)
	}
}

for(i in 1:561){
	for(j in 1:30){
		log1<-totaldata[,562]==j
		datasetnew<-totaldata[which(log1),i]
		finaldata[i,j+6]<-mean(datasetnew)
	}
}

##write out the two dataset as csv files
write.table(totaldata,"./UCI HAR Dataset/firstdataset.txt")
write.table(finaldata,"./UCI HAR Dataset/seconddataset.txt")

