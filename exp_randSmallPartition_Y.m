% random partition the sum of 1
% only generate small number of partitions assuming that
clear; clc; close all

limit = 3;
randBound = 2;
count = 0;
all = 0;
counter = [];
percentage = [];
counti = [];
constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];

tic
% 1 partition - 76 outcomes
datap{1} = [];
for i = 1:76
    odf_1 = zeros(1,76);
    odf_1(i) = 1./constraint(i);
    val = SeparateOptY(odf_1);
    all = all + 1
    if val == -10000;
        count = count + 1
    end
    datap{1} = [datap{1};odf_1,-val];
end

percentage = [percentage;((76-count)*100)/76];
counter = [counter;76-count];
counti = [counti;1];


% 2 partition - 76*75 = 5700 outcomes
% make both the partition point and the outcome random



for i = limit:limit
    display(i)
    randsize = randBound;%*i;
    [array, countSum,allSum] = randPartition(i,randsize,@SeparateOptY);
    datap{i} = array;
    all = all +allSum;
    count = count + countSum;
    disp('count');
    disp(count);
    disp('iter');
    disp(i);
    %if count > 5000
    %    i = limit+1
    %end
    counti = [counti;i];
    percent = (randsize-countSum)/allSum;
    percentage = [percentage;percent*100];
    counter = [counter;randsize-countSum];

end
t = toc;

for i = limit:limit
    bestopt(i) = max(datap{i}(:,77));
    meanopt(i) = mean(datap{i}(:,77));
    sdopt(i) = std(datap{i}(:,77));
end

% subplot(3,1,1)
% plot(bestopt,'*')
% subplot(3,1,2)
% plot(meanopt,'o')
% subplot(3,1,3)
% plo:1(sdopt,'+')



Data_SmallPartition = [];
for i = limit:limit
    Data_SmallPartition = [Data_SmallPartition; datap{i}];
end


[s,ind] = sort(Data_SmallPartition(:,77));
dataSort = Data_SmallPartition(ind,:);

for i = 1:randsize
if dataSort(i,77) == s(i)
    continue
else
    disp('sorting not right!')
    break
end
end

dataOri_Y_RkI = Data_SmallPartition;
dataSort(:,77) = s;
%dataPolar_Y_RkI = [dataSort(1:1250,:);...
%    dataSort(end-1250+1:end,:)];
t_Y_RkI = t;

sat = all - count;
percent = (sat*100)/all;
disp('all');
disp(all);
disp('satisfied');
disp(sat);
%disp('percent');
disp(counter);
disp(percentage);
disp(size(counti));
disp(size(percentage));
%plot(counti,percentage);
 
save('data_Y_Rkl2.mat','dataOri*','t_*','datap');

%figure,close                    % must do this first, otherwise plot is empty
%plot(counti,percentage)                      % usual plotting
%print -dpdf -r600 plot.pdf
%Exit
