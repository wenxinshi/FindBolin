function [flag] = svmdecide (v)
% Load the data and select features for classification

X=[0.1025,0;0.1274,0;0.1283,0;0.0927,0;0.1777,0;0.1234,0;0.0779,0;0.1119,0;0.0999,0;0.1131,0;0.1288,0;0.1214,0;0.1130,0;0.1191,0;0.1814,0;0.0808,0;0.1024,0;0.0776,0;0.0779,0;0.0186,0;0.0742,0];
%X = [meas(:,1), meas(:,2)];
% Extract the Setosa class


Y=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0];
% Y = nominal(ismember(species,'setosa'));
% Randomly partitions observations into a training set and a test
% set using stratified holdout
% P = cvpartition(Y,'Holdout',0.20);
% Use a linear support vector machine classifier
svmStruct = svmtrain(X(1:21,:),Y(1:21),'method','LS');%,'showplot',true);
C = svmclassify(svmStruct,[v,0]);%,'showplot',true);
flag=double(C);
% errRate = sum(Y(P.test)~= C)/P.TestSize;  %mis-classification rate
% conMat = confusionmat(Y(P.test),C); % the confusion matrix