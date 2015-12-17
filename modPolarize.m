function modPolarize(percent,Var)

%........
%........


%data1 = load('Data/data_Y_Rkl1.mat');
%data2 = load('Data/data_Y_Rkl2_100000.mat');
%data3 = load('Data/data_Y_Rkl3_100000.mat');
%data4 = load('Data/data_Y_Rkl4_100000.mat');
%data5 = load('Data/data_Y_Rkl5_100000.mat');
%data6 = load('Data/data_Y_Rkl6_100000.mat');
%data7 = load('Data/data_Y_Rkl7_100000.mat');
%dat = load(strcat('Data/data_SmallPartition',num2str(iter),'_200000.mat'));
%disp('Data loaded............');
%Odfs = [data1.odfs;data2.odfs;data3.odfs;data4.odfs;data5.odfs;data6.odfs;data7.odfs];
%data = [];
%for i = 1:length(Odfs)
%    odf = Odfs(i,:);
%    data = [data;odf,-SeparateOptY(odf)];
%end
%display(type);
%save('smallPartition100000.mat','data','Odfs');
%if isempty(strfind(type, 'small')) == 0
%dat = load('smallPartition1400000.mat');
%else
dat = load('AllData.mat');
%end
data = dat.odfs;
disp('Data loaded............');
perc = percent/100; % 20% of upper and lower values are kept
percHigh = (percent+Var)/100;
%percLow = (percent-Var)/100;
percMid = (percent-Var)/100;;
tar = data(:,end);

[stTar,ind] = sort(tar);

%disp(dsize);
dsize = floor(percMid*size(data,1));
mid = round(size(data,1)/2);
int = round(dsize/2);
dsizeMid = 2*int; 

dsizeHigh = floor(percHigh*size(data,1));
%dsizeLow = floor(percLow*size(data,1));
%lowTarData = data(ind(1:dsize),:);
highTarData = data(ind(end-dsizeHigh+1:end),:);
midTarData = data(ind(mid-int:mid+int-1),:);
%lowTarData = data(ind(1:dsizeLow),:);
% plot histogram

[hh,hout] = hist(highTarData(:,77));
[mh,mout] = hist(midTarData(:,77));

constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];
facLimit = 1./constraint;

normMidData = []; normHighData = [];
for i = 1:76
    normMidData = [normMidData,midTarData(:,i)./facLimit(i)];
    normHighData = [normHighData, highTarData(:,i)./facLimit(i)];    
end
normMidData = [normMidData,zeros(dsizeMid,1)];
normHighData = [normHighData,ones(dsizeHigh,1)];
headers = {'odf1', 'odf2', 'odf3', 'odf4', 'odf5', 'odf6', 'odf7', 'odf8', 'odf9', 'odf10', 'odf11', 'odf12', 'odf13', 'odf14', 'odf15', 'odf16', 'odf17', 'odf18', 'odf19', 'odf20', 'odf21', 'odf22', 'odf23', 'odf24', 'odf25', 'odf26', 'odf27', 'odf28', 'odf29', 'odf30', 'odf31', 'odf32', 'odf33', 'odf34', 'odf35', 'odf36', 'odf37', 'odf38', 'odf39', 'odf40', 'odf41', 'odf42', 'odf43', 'odf44', 'odf45', 'odf46', 'odf47', 'odf48', 'odf49', 'odf50', 'odf51', 'odf52', 'odf53', 'odf54', 'odf55', 'odf56', 'odf57', 'odf58', 'odf59', 'odf60', 'odf61', 'odf62', 'odf63', 'odf64', 'odf65', 'odf66', 'odf67', 'odf68', 'odf69', 'odf70', 'odf71', 'odf72', 'odf73', 'odf74', 'odf75', 'odf76','decision'};
normData = [normMidData;normHighData];
%disp(length(headers));
%disp(length(normLowData));
%normData = [headers;normLowData;normHighData];
fileName = strcat('Weka/polarizedMid',num2str(percent),'_',num2str(Var),'.csv');
csvwrite_with_headers(fileName,normData,headers);
%csvwrite(fileName,normData);
exit;
