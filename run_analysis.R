


if (!("reshape2" %in% rownames(installed.packages())) ) {
        print("Please install required package \"reshape2\" before proceeding")
##Looks to see if the reshape2 package is installed and prompts for install if not installed
        
} else {
        
        library(reshape2)
        
        activity_labels <- read.table("./activity_labels.txt",col.names=c("activity_id","activity_name"))
        ## Reads the files and the activity names to lable the columns
        
        features <- read.table("features.txt")
        feature_names <-  features[,2]
        ## Read the column names from the dataframe
        
        testdata <- read.table("./test/X_test.txt")
        colnames(testdata) <- feature_names
        traindata <- read.table("./train/X_train.txt")
        colnames(traindata) <- feature_names
        ## Read the test and training data to label the dataframe columns
        
        test_subject_id <- read.table("./test/subject_test.txt")
        colnames(test_subject_id) <- "subject_id"
        ## Read test subject ids
        
        test_activity_id <- read.table("./test/y_test.txt")
        colnames(test_activity_id) <- "activity_id"
        ## Get the test activity ids and label the dataframe columns
        
        train_subject_id <- read.table("./train/subject_train.txt")
        colnames(train_subject_id) <- "subject_id"
        ## Read train subjects ids, label dataframe columns 
        
        train_activity_id <- read.table("./train/y_train.txt")
        colnames(train_activity_id) <- "activity_id"
        ## Read activity ids of training data and label dataframe columns
        
        test_data <- cbind(test_subject_id , test_activity_id , testdata)
        ## Put test subjects and activity ids into one dataframe
        
        train_data <- cbind(train_subject_id , train_activity_id , traindata)
        ## Put train subject and activity ids into one dataframe
        
        all_data <- rbind(train_data,test_data)
        ## Combine the test and train data into one dataframe 
        

        mean_col_idx <- grep("mean",names(all_data),ignore.case=TRUE)
        mean_col_names <- names(all_data)[mean_col_idx]
        std_col_idx <- grep("std",names(all_data),ignore.case=TRUE)
        std_col_names <- names(all_data)[std_col_idx]
        meanstddata <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]
        ## Remove all columns not refering to mean or std
        
        descrnames <- merge(activity_labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)
        ## Merge the mean/std dataset with the activities dataset
        
        data_melt <- melt(descrnames,id=c("activity_id","activity_name","subject_id"))
        mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)
        ## Melt and cast the dataset
        
        write.table(mean_data,"./tidy_dataset.txt", row.names=FALSE)
        ## Create the tidy data dataset
        
}
