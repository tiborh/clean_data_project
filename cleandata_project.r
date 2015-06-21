## to check a file head
file.head <- function(path.to.file,n=5)
    {
        con <- file(path.to.file, "rt")
        five.lines <- readLines(con, n)
        print(five.lines)
        close(con)
        rm(con)
    }


## getting data file
if(!file.exists("./data")){dir.create("./data")}
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path.to.file = file.path("./data/spDataSet.zip")
download.file(fileUrl,destfile=path.to.file,method="curl")

## after data has been extracted from zip
data.root <- file.path("../../R/datasets/UCI_HAR_Dataset")
readme <- file.path(data.root,"README.txt")
readme
file.head(readme)

## test
test.root <- file.path(data.root,"test")
## data
xtest.path <- file.path(test.root,"X_test.txt")
file.head(xtest.path,1)
xtest.dat <- read.table(xtest.path)
## colname
features.path <- file.path(data.root,"features.txt")
features.dat <- read.table(features.path,stringsAsFactors=F)
str(features.dat)
class(features.dat$V2)
colnames(xtest.dat) = features.dat$V2
str(xtest.dat)
## test subject
testsubj.path <- file.path(test.root,"subject_test.txt")
testsubj.dat <- read.table(testsubj.path)
## colname
colname = c("subject")
colnames(testsubj.dat) = colname
str(testsubj.dat)
## ytest
ytest.path <- file.path(test.root,"y_test.txt")
ytest.dat <- read.table(ytest.path)
## colname
colname = c("y.test")
colnames(ytest.dat) = colname
str(ytest.dat)
## activity labels
act.labels.path <- file.path(data.root,"activity_labels.txt")
act.labels.dat <- read.table(act.labels.path)
str(act.labels.dat)
ytest.map <- merge(ytest.dat,act.labels.dat,by.x="y.test",by.y="V1")
names(ytest.map) = c("activity.code","activity.name");
str(ytest.map)

## combining test data
combined.dat <- data.frame(testsubj.dat$subject,ytest.map$activity.name,xtest.dat)
tempnames <- names(combined.dat)
head(tempnames)
tempnames[1] = "subject"
tempnames[2] = "activity"
names(combined.dat) = tempnames
combined.dat$test = c(TRUE)
str(combined.dat)
head(combined.dat$test)
tail(names(combined.dat))

## train
train.root <- file.path(data.root,"train")
## data
train.path <- file.path(train.root,"X_train.txt")
file.head(train.path,1)
train.dat <- read.table(train.path)
class(train.dat)
## colname
colnames(train.dat) = features.dat$V2
str(train.dat)
## train subject
trainsubj.path <- file.path(train.root,"subject_train.txt")
trainsubj.dat <- read.table(trainsubj.path)
## colname
colname = c("train.subject")
colnames(trainsubj.dat) = colname
str(trainsubj.dat)
## ytest
ytrain.path <- file.path(train.root,"y_train.txt")
ytrain.dat <- read.table(ytrain.path)
## colname
colname = c("y.train")
colnames(ytrain.dat) = colname
str(ytrain.dat)
tail(ytrain.dat)

## activity labels
ytrain.map <- merge(ytrain.dat,act.labels.dat,by.x="y.train",by.y="V1")
names(ytrain.map) = c("activity.code","activity.name");
str(ytrain.map)

## combining training data
combined2.dat <- data.frame(trainsubj.dat$train.subject,ytrain.map$activity.name,train.dat)
tempnames <- names(combined2.dat)
head(tempnames)
tempnames[1] = "subject"
tempnames[2] = "activity"
names(combined2.dat) = tempnames
combined2.dat$test = c(FALSE)
str(combined2.dat)
tail(names(combined2.dat))
head(combined2.dat$test)

## combining test and train data sets
aggregate.dat <- rbind(combined.dat,combined2.dat)
str(aggregate.dat)

## extracing column averages
column.means <- colMeans(aggregate.dat[3:563])
str(column.means)                       # vector

## extracting standard deviations
column.sdevs <- apply(aggregate.dat[3:563],2,sd)
str(column.sdevs)

## summaries
install.packages("psych")
library(psych)
## describe(aggregate.dat) # overkill
aggregate.analysis <- describeBy(aggregate.dat[3:563],list(aggregate.dat$subject,aggregate.dat$activity),skew=FALSE,ranges=FALSE)
class(aggregate.analysis)
str(aggregate.analysis)
write.table(aggregate.analysis,file="aggregate_analysis.txt",row.name=FALSE)
