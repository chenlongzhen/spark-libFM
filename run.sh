#!/bin/bash

if [ $1 -eq 1 ];then
    git pull
    mvn package
fi

jobname=clz_fm
intask=1  # binary model           
inallIterations=10  #迭代cishu上限
innumCorrections=3
intolerance=0.00001
indim=1
inreg1=0.01
inreg2=0.01
ininitStd=0.01
instep=1 #每个几步算一次测试auc
intestTrain=1 #是否计算train auc
checkPointPath=/team/ad_wajue/chenlongzhen/mobai/checkPoint #保存AUC高的模型
earlyStop=3 # 3次AUC低于历史高值stop
train_path_in=/team/ad_wajue/chenlongzhen/mobai/train_file.data 
#test_path_in=/team/ad_wajue/dw/rec_ml_test/rec_ml_test/model_dataSet/testing 
test_path_in=0

localPath=weight # 输出权重
featureIDPath=/data/chenlongzhen/mobai/data/featureId.data #输入feature 对应的id
ifSplit=0.9 # trainsplit
ifSaveWeight=1

spark-submit \
--class TestFM \
--master yarn-client \
--num-executors 50 \
--executor-memory 2G \
--executor-cores 4  \
--driver-memory 5G \
target/FM-1.0-SNAPSHOT.jar \
$intask \
$inallIterations \
$innumCorrections \
$intolerance \
$indim \
$inreg1 \
$inreg2 \
$ininitStd \
$instep \
$checkPointPath \
$earlyStop \
$train_path_in \
$test_path_in \
$intestTrain \
$jobname \
$localPath \
$featureIDPath \
$ifSplit \
$ifSaveWeight

