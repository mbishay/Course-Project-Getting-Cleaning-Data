##STEP 1: MERGE TRAINING AND TEST DBS
##reading training data
trainingsubjects <- read.table('./UCI HAR Dataset/train/subject_train.txt', header = FALSE, ,stringsAsFactors = F, fill = T)
xtrain <- read.table('./UCI HAR Dataset/train/X_train.txt', header = FALSE, ,stringsAsFactors = F, fill = T)
ytrain <- read.table('./UCI HAR Dataset/train/Y_train.txt', header = FALSE, ,stringsAsFactors = F, fill = T)

##stitch training database together and label as "training data"
trainingDB <- cbind(trainingsubjects, xtrain, ytrain)
trainingDB$condition <- "training"

##remove temporary files
rm(trainingsubjects,xtrain, ytrain)

##reading test data
testingsubjects <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, ,stringsAsFactors = F, fill = T)
xtest <- read.table('./UCI HAR Dataset/test/X_test.txt', header = FALSE, ,stringsAsFactors = F, fill = T)
ytest <- read.table('./UCI HAR Dataset/test/Y_test.txt', header = FALSE, ,stringsAsFactors = F, fill = T)

##stitch training database together and label as "testing data"
testingDB <- cbind(testingsubjects, xtest, ytest)
testingDB$condition <- "testing"

##remove temporary files
rm(testingsubjects,xtest, ytest)

##combine training and testing data
fulldata <- rbind(testingDB, trainingDB)
rm(testingDB,trainingDB)

##label variables
activitylabels <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, ,stringsAsFactors = F, fill = T)
names(fulldata) <- c("SubjectNumber", activitylabels$V2, "Activity", "Condition")

##STEP 2: SELECT VARIABLES THAT INCLUDE MEAN OR STANDARD DEVIATION
##determine which variables contain "mean" or "std" for standard deviation
variablestouse <- c(grep("mean", activitylabels$V2), grep("std", activitylabels$V2))

##create new database with only the mean and std columns
variablecolumnnumber <- variablestouse+1
shorterdata <- fulldata[,c(1,variablecolumnnumber,563,564)]

##STEP 3: LABEL THE ACTIVITIES
activities <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE, ,stringsAsFactors = F, fill = T)
shorterdata<-merge(shorterdata,activities,by.x="Activity", by.y="V1")[,-1]
names(shorterdata)[82] <- "Activity"

##STEP 4: LABEL WITH DESCRIPTIVE VARIABLE NAMES
##make labels easier to read
currentlabels <- colnames(shorterdata)
##remove parentheses
currentlabels <- gsub("\\()", "", currentlabels)
##cleanuplabels
currentlabels <- gsub("tBody", "TimeBody", currentlabels)
currentlabels <- gsub("tGravity", "TimeGravity", currentlabels)
currentlabels <- gsub("fBody", "FastFourierBody", currentlabels)
currentlabels <- gsub("Acc", "Accelerometer", currentlabels)
currentlabels <- gsub("Gyro", "Gyroscope", currentlabels)
currentlabels <- gsub("Mag","Magnitude",currentlabels)
currentlabels <- gsub("-","",currentlabels)
##rename columns of the shorter database
names(shorterdata) <- currentlabels

##STEP 5: CREATE A NEW, TIDY DB WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
##read in libraries and initialize dataframe for new data
library(plyr)
library(reshape2)
newdata <- data.frame()

##for each subject calculate mean of each variable and add a row to the newdata dataframe
for(i in 1:30){
    subdata <- shorterdata[shorterdata$SubjectNumber==i,]
    rows <- ddply(subdata, .(Activity), numcolwise(mean))
    newdata <- rbind(newdata, rows)
}

##create a longform dataframe with Subject Number and Activity as the IDs
newdata <- melt(newdata,id.vars=c("SubjectNumber","Activity"))
names(newdata)[3:4] <- c("Variable","MeanValue")

##clean up newdata by separating Variable into as many groups as possible
newdata[grep("Time", newdata$Variable), "Domain"] <- "Time"
newdata[grep("FastFourier", newdata$Variable), "Domain"] <- "FastFourierTransform"
newdata$Variable<- sub("Time", "", newdata$Variable)
newdata$Variable<- sub("FastFourier", "", newdata$Variable)

newdata[grep("Accelerometer", newdata$Variable), "Device"] <- "Accelerometer"
newdata[grep("Gyroscope", newdata$Variable), "Device"] <- "Gyroscope"
newdata$Variable<- sub("Accelerometer", "", newdata$Variable)
newdata$Variable<- sub("Gyroscope", "", newdata$Variable)

newdata[grep("Body", newdata$Variable), "AccelerationSignal"] <- "Body"
newdata[grep("Gravity", newdata$Variable), "AccelerationSignal"] <- "Gravity"
newdata$Variable<- sub("Body", "", newdata$Variable)
newdata$Variable<- sub("Gravity", "", newdata$Variable)

newdata[grep("std", newdata$Variable), "Measurement"] <- "StandardDeviation"
newdata$Variable<- sub("std", "", newdata$Variable)
newdata[grep("mean", newdata$Variable), "Measurement"] <- "Mean"
newdata$Variable<- sub("mean", "", newdata$Variable)

newdata[grep("X", newdata$Variable), "Axis"] <- "X"
newdata$Variable<- sub("X", "", newdata$Variable)
newdata[grep("Y", newdata$Variable), "Axis"] <- "Y"
newdata$Variable<- sub("Y", "", newdata$Variable)
newdata[grep("Z", newdata$Variable), "Axis"] <- "Z"
newdata$Variable<- sub("Z", "", newdata$Variable)

##rename the "leftover" variable
names(newdata)[3] <- "Other"

##reorder variables
newdata <- newdata[c(1,2,5,6,7,8,9,3,4)]

##write final database
write.table(newdata, file="CourseProject.txt", row.name=FALSE)
