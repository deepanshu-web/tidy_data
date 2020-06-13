#adding datasets
library(dplyr)
dat1<-read.table("X_train.txt")
nam<-read.table("y_train.txt")
subject<-read.table("subject_train.txt")
dat2<-read.table("X_test.txt")
nam2<-read.table("y_test.txt")
subject2<-read.table("subject_test.txt")
features<-read.table("features.txt")

#naming the columns of the datasets

colnames(dat1)<-features$V2
colnames(dat2)<-features$V2
dat1$label<-nam$V1
dat1$subject<-subject$V1
ncol(dat1)
dat1<-dat1[,c(563,562,1:561)]
dat2$label<-nam2$V1
dat2$subject<-subject2$V1
dat2<-dat2[,c(563,562,1:561)]
factor(dat2$subject)
factor(dat1$subject)

#merging the datasets
data_main<-rbind.data.frame(dat1,dat2)

#Extracts only the measurements on the mean and standard deviation for each measurement.
a<-grep("mean",colnames(data_main))
b<-grep("std",colnames(data_main))
data_main<-select(data_main,c(1,2,a,b))
colnames(data_main)
str(data_main$label)
data_main$label<-as.character(data_main$label)

#adding the activity labels
a<-c("WALKING", "WALKING_UPSTAIRS" ,"WALKING_DOWNSTAIRS", "SITTING" ,"STANDING" ,"LAYING")
for(i in 1:6){
data_main$label<-gsub(i,a[i],data_main$label)
  
}  
#independent tidy data set with the average of each variable for each activity and each subject.
data_m<-group_by(data_main,subject,label)
q5<-summarise_all(data_m,mean)
#answer = q5
tidy_data<-q5
