# Getting and Cleaning Data code book

## The run_analysis.R script loads, joins the data from "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

Annotation code snippet:

	#load annotation
	headers = read.delim('./features.txt',header=F)
	act_labels = read.table('./activity_labels.txt')
	names(act_labels) = c('Code','Activity')

###Load data from training and test data sets:

	#load training data
	train_subject = read.delim('./train/subject_train.txt',header=F)
	train_data = read.table('./train/X_train.txt')	
	train_labels = read.delim('./train/y_train.txt',,header=F)
	#cbind and name headers
	names(train_data) = headers[,1]
	train = cbind(train_subject,train_labels,train_data)
	names(train)[1:2] = c('Subject','Labels')
	train$Source = 'training'

	#load training data
	train_subject = read.delim('./train/subject_train.txt',header=F)
	train_data = read.table('./train/X_train.txt')
	train_labels = read.delim('./train/y_train.txt',,header=F)
	#cbind and name headers
	names(train_data) = headers[,1]
	train = cbind(train_subject,train_labels,train_data)
	names(train)[1:2] = c('Subject','Labels')
	train$Source = 'training'

###row bind the data from the training and test set

	#rbind test and training data
	dat = rbind(train,tst)

###Add human readable activity names

	#merge with activity names
	dat = merge(dat,act_labels,by.x='Labels',by.y='Code')

###Generate mean values per subject and activity

	#calc mean for each activity by subject
	out = aggregate(dat[, 3:563], list(dat$Subject,dat$Activity), mean)
	#write out summary data frame
	write.table(out,file='summary_file.txt',row.names=F,sep='\t',quote=F)