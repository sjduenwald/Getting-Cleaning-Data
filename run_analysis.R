setwd('C:/Users/sduenwald/UCI HAR Dataset')
#load annotation
headers = read.delim('./features.txt',header=F)
act_labels = read.table('./activity_labels.txt')
names(act_labels) = c('Code','Activity')

#load training data
train_subject = read.delim('./train/subject_train.txt',header=F)
train_data = read.table('./train/X_train.txt')
train_labels = read.delim('./train/y_train.txt',,header=F)
#cbind and name headers
names(train_data) = headers[,1]
train = cbind(train_subject,train_labels,train_data)
names(train)[1:2] = c('Subject','Labels')
train$Source = 'training'

#load test data
test_subject = read.delim('./test/subject_test.txt',,header=F)
test_data = read.table('./test/X_test.txt')
test_labels = read.delim('./test/y_test.txt',,header=F)
#cbind and name headers
names(test_data) = headers[,1]
tst = cbind(test_subject,test_labels,test_data)
names(tst)[1:2] = c('Subject','Labels')
tst$Source = 'test'

#rbind test and training data
dat = rbind(train,tst)

#merge with activity names
dat = merge(dat,act_labels,by.x='Labels',by.y='Code')

#calc mean for each activity by subject
out = aggregate(dat[, 3:563], list(dat$Subject,dat$Activity), mean)
#write out summary data frame
write.table(out,file='summary_file.txt',row.names=F,sep='\t',quote=F)
