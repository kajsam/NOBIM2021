# NOBIM 2021
# by Kajsa Møllersen (kajsa.mollersen@uit.no) June 2021

library(pROC) # to find the conf int of auc

# These numbers are from https://www.kaggle.com/c/siim-isic-melanoma-classification/data?select=train.csv 
n = 10982 # size of test set
malignant_rate = 0.02 # in training set
teams = 3308
AUC_1 = 0.9490 # best performing team

n_mal = round(n*malignant_rate) # estimated number of malignant cases
n_ben = n-n_mal # estimated number of benign cases

class = rep(0, n)
class[1:n_mal] = 1 # true class label

# Create toy example with AUC = 0.9490

predict1 = class
false1 = 0.3205 # this parameter is adjusted until required AUC is produced
# malignant prediction
n_mal_05 = round(false1*n_mal)
n_mal_pred = seq(from = (1/n_mal_05), to = 1, by = (1/n_mal_05))
predict1[1:n_mal_05] = n_mal_pred

# benign prediction
n_ben_05 = round(false1*n_ben)
n_ben_pred = seq(from = (1/n_ben_05), to = 1, by = (1/n_ben_05))
predict1[(n_mal+1):(n_mal+n_ben_05)] = n_ben_pred

roc1 = roc(class,predict1)
plot(roc1)
auc(class,predict1)
ci.auc(class, predict1) 

## That's all for the NOBIM abstract. One more example below.

# AUC = 0.9297
predict2 = class
false = false1+ 0.0565

# malignant prediction
n_mal_05 = round(false*n_mal)
n_mal_pred = seq(from = (1/n_mal_05), to = 1, by = (1/n_mal_05))
predict2[1:n_mal_05] = n_mal_pred

# benign prediction
n_ben_05 = round(false*n_ben)
n_ben_pred = seq(from = (1/n_ben_05), to = 1, by = (1/n_ben_05))
predict2[(n_mal+1):(n_mal+n_ben_05)] = n_ben_pred

roc2 = roc(class,predict2)
plot(roc2)
auc(class,predict2)
ci.auc(class, predict2) 

roc.test(class,predict1,predict2, paired = F)

