library(dplyr)

p <- function(..., sep='') {
  paste(..., sep=sep, collapse=sep)
}

download_data <- function() {
  data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  destination_file <- p(getwd(), "/", "UCI HAR Dataset.zip")
  download.file(data_url, destination_file, method = "auto")
  unzip(destination_file)
}

load_set <- function(type) {
  activity_labels <- read.table(p(getwd(), "/UCI HAR Dataset/activity_labels.txt"), 
                                header = FALSE,
                                sep = " ",
                                col.names = c("label_id", "label"))
  
  features_labels <- read.table(p(getwd(), "/UCI HAR Dataset/features.txt"), 
                                header = FALSE,
                                sep = " ",
                                col.names = c("column", "name"))
  
  features_column_names <- features_labels$name
  
  subjects <- read.table(p(getwd(), "/UCI HAR Dataset/", type, "/subject_", type ,".txt"), 
                         header = FALSE,
                         sep = " ",
                         col.names = c("subject"))
  
  labels <- read.table(p(getwd(), "/UCI HAR Dataset/", type, "/y_", type, ".txt"), 
                       header = FALSE,
                       sep = " ",
                       col.names = c("label_id"))
  labels['label'] <- ''
  
  labels <- rows_update(labels, activity_labels, by = "label_id")
  
  labels <- select(labels, -c(label_id))
  
  features <- read.fwf(p(getwd(), "/UCI HAR Dataset/", type, "/X_", type, ".txt"), 
                       header = FALSE,
                       widths = rep(16,561),
                       sep = "", 
                       fill = FALSE,
                       strip.white = TRUE,
                       col.names = features_column_names,
                       check.names = FALSE)
  
  features <- features[ , grepl("mean|std", colnames(features), ignore.case = TRUE)]
  
  set <- bind_cols(subjects, labels, features)
  
  set  
}

download_data()

test <- load_set("test")
train <- load_set("train")

full <- bind_rows(test, train)

summary <- full %>%
  group_by(subject, label) %>%
  summarise_at(vars(-group_cols()), mean)

write.table(summary, file = p(getwd(), "/summary.txt"), row.names = FALSE)
write.csv(summary, file = p(getwd(), "/summary.csv"), row.names = FALSE)