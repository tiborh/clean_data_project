# script description

1. file is downloaded
2. unzip is done manually, not by the script
3. test and train data are processed separately
4. first column for each data frame has the subject_test.txt data
5. second column has the y_test.txt y_train.txt data respectively, substituted with the activity labels
   e.g. ytest.map <- merge(ytest.dat,act.labels.dat,by.x="y.test",by.y="V1")
6. columns 3 to 563 have the data from X_test.txt and X_train.txt respectively
7. a column 564 has been added to each where the value is TRUE for test data and FALSE for train data
8. column names for columns 3 to 563 come from feature.txt
9. at the end the two data frames are bound together
10. column averages and column standard deviations are extracted column.means and column.sdevs
11 the analysis containing the averages by subject and activity is in the variable aggregate analysis

## variables used:
1. paths for the various files have the suffix .path
2. directories have .root at the end
3. when downloading the file, path.to.file and fileUrl are used
4. combination data: combined.dat for test results, combined2.dat for train results and aggreagate.dat for the combination of the two
5. the variables having the string "name" or "names" inside, are used for naming or renaming columns

 [1] "act.labels.dat"     "act.labels.path"    "aggregate.analysis"
 [4] "aggregate.dat"      "colname"            "column.means"      
 [7] "column.sdevs"       "combined2.dat"      "combined.dat"      
[10] "data.root"          "features.dat"       "features.path"     
[13] "file.head"          "fileUrl"            "path.to.file"      
[16]                      "tempnames"          "test.root"         
[19] "testsubj.dat"       "testsubj.path"      "thenames"          
[22] "train.dat"          "train.path"         "train.root"        
[25] "trainsubj.dat"      "trainsubj.path"     "xtest.dat"         
[28] "xtest.path"         "ytest.dat"          "ytest.map"         
[31] "ytest.path"         "ytrain.dat"         "ytrain.map"        
[34] "ytrain.path"       

## files used from the unzipped data:
a. ./UCI_HAR_Dataset:
b. activity_labels.txt   gives the data in the activity column replacing numbers from y_....txt files
c. features.txt          gives the data to the column headings (except for columns 1,2 and 564)

d. ./UCI_HAR_Dataset/test:
e. subject_test.txt      gives column 1 (named subject) in combined.dat
f. X_test.txt            gives columns 3 to 563 in combined.dat
d. y_test.txt            gives colum 2 (named activity) in combined.dat

f. ./UCI_HAR_Dataset/train:
e. subject_train.txt     gives column 1 (named subject) in combined2.dat
g. X_train.txt           gives columns 3 to 563 in combined2.dat
h. y_train.txt           gives colum 2 (named activity) in combined2.dat
