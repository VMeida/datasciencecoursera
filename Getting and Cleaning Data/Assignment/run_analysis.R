setwd('D:/Coursera/Getting and Cleaning Data/')

# Loading data into R
## PS: After exploring the data, I've found easier to change the X_train on load ;)

features <- read.table('./data/UCI HAR Dataset/features.txt')
X_train <- read.table('./data/UCI HAR Dataset/train/X_train.txt', col.names = features$V2)
y_train <- read.table('./data/UCI HAR Dataset/train/y_train.txt')
X_test <- read.table('./data/UCI HAR Dataset/test/X_test.txt', col.names = features$V2)
y_test <- read.table('./data/UCI HAR Dataset/test/y_test.txt')
subject_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt')

## Exploratory Phase

unique(features)
head(X_test)
head(X_train)
unique(y_train)
names(X_train)
str(X_train)
str(y_train)
str(X_test)
str(y_test)
str(subject_train)
str(subject_test)

## Joining X_train with y_train and subject_train

full_train <- cbind(subject=subject_train, activity = y_train, X_train)
head(full_train)
str(full_train)

## Joining X_test with y_test and subject_test

full_test <- cbind(subject=subject_test, activity = y_test, X_test)
head(full_test)
str(full_test)

full_table <- rbind(full_train, full_test)

str(full_table)
## Renaming features table acording activity_labels.txt

full_table[[2]] <- gsub('1', 'walking', full_table[[2]])
full_table[[2]] <- gsub('2', 'walking upstairs', full_table[[2]])
full_table[[2]] <- gsub('3', 'walking downstairs', full_table[[2]])
full_table[[2]] <- gsub('4', 'sitting', full_table[[2]])
full_table[[2]] <- gsub('5', 'standing', full_table[[2]])
full_table[[2]] <- gsub('6', 'laying', full_table[[2]])

## Also, changing activity column name to a proper name

colnames(full_table)[1] <- 'subject'
colnames(full_table)[2] <- 'activity'

str(full_table)

## Extracting only mean and standard deviation columns (mean() & std())

match <- c('subject','activity','[Mm]ean','std')

full_table <- full_table[grep(paste(match, collapse = '|'), names(full_table))]
str(full_table)

## Renaming labels for descritive names

names(full_table) <- gsub('^t', 'time of ', names(full_table))
names(full_table) <- gsub('^f', 'fft of ', names(full_table))
names(full_table) <- gsub('Acc', ' acceleration ', names(full_table))
names(full_table) <- gsub('Gyro', ' angular acceleration ', names(full_table))
names(full_table) <- gsub('Mag', 'magnitude', names(full_table))
names(full_table) <- gsub('Jerk', 'jerk ', names(full_table))
names(full_table) <- gsub('std', 'standard deviation', names(full_table))
names(full_table) <- gsub('Freq', ' frequency', names(full_table))
names(full_table) <- gsub('Body', 'body', names(full_table))
names(full_table) <- gsub('[Mm]ean', ' mean', names(full_table))
names(full_table) <- gsub('\\.', '', names(full_table))
names(full_table) <- gsub('X', ' axis-x ', names(full_table))
names(full_table) <- gsub('Y', ' axis-y ', names(full_table))
names(full_table) <- gsub('Z', ' axis-z ', names(full_table))

names(full_table)

## Loading dplyr for grouping by activities and calculating the mean values

library(dplyr)
df <- tbl_df(full_table)

df <- df %>%
  group_by(subject, activity) %>%
    summarise_all(mean)

head(df, n=20)

## Command to write table

write.table(df,file='./Assignment/tidy_dataset.txt', row.names = FALSE)
