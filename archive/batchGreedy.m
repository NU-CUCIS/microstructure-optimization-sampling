function batchGreedy(randsize,randtime)
all = randsize;
%randtime = 100;
count = 0;
odfs = [];
constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];

propFunc = @SeparateOptY;
% all random
% keep the entries that <= 1
% 
% datam = [];
% 
% while size(datam,1) < 100
%     a = rand(1,75)./constraint(1:75);
% 
%     if a*constraint(1:75)' <= 1
%        dr = [a,(1 - a*constraint(1:75)')/constraint(76)];
%        opt = materialOpt(dr);
%        datam = [datam;dr,opt];
%     end
% 
% end

% nothing can be found
data_Greedy = [];
tic
for i = 1:randsize
    
remainFac = 1:1:75;
fixFac = zeros(1,75);
setFac = zeros(1,76);
thsd = 1;

while isempty(remainFac) == 0
    
%     if length(remainFac) < 5
%         r = 1;
%     else
%         r = 5;
%     end
%     
    r = 1;
    randDraw = randsample(length(remainFac),r);
    randFac = remainFac(randDraw);
    remainFac(randDraw) = [];
    
    thisVal = []; thisOpt = [];
    
    for j = 1:randtime
        randFacRand = rand(1,r).*thsd;
        setFac(randFac) = randFacRand./constraint(randFac);
        otherVal = (1 - setFac*constraint')/(length(remainFac)+1);
        setFac([remainFac,76]) = otherVal./constraint([remainFac,76]);
        
        thisVal(j) = randFacRand;
        thisOpt(j) = -propFunc(setFac);
        
        %if     
    end
    
    maxInd = find(thisOpt == max(thisOpt));
    %minInd = find(thisOpt == min(thisOpt));

    if length(maxInd) > 1
        maxInd = maxInd(1);
    end
    %if length(minInd) > 1
    %    minInd = minInd(1);
    %end
    
    fixVal = thisVal(maxInd);
    
    thsd = thsd - fixVal; 
    
    fixFac(randFac) = fixVal./constraint(randFac);
    setFac = [fixFac,0];
end


odf = [fixFac,thsd/constraint(end)];

val = propFunc(odf);
if val == -10000;
    count = count + 1;
else
    odfs = [odfs;odf];
end

disp(strcat('iteration',num2str(i),' over............'));

if (odf>=0) == true(1,length(odf))
    % display('Yes!')
    %checksum(i) = constraint*odf';
    %if constraint*odf' == 1
        data_Greedy = [data_Greedy;odf,-val];
    %else
%         display('outbound wrong');
%         return
    %end
else
%     display('negative wrong');
%     return
end

end
t = toc;

[s,ind] = sort(data_Greedy(:,77));
dataSort = data_Greedy(ind,:);

for i = 1:randsize
if dataSort(i,77) == s(i)
    continue
else
    disp('sorting not right!')
    break
end
end

dataOri_Y_BFA = data_Greedy;
%dataSort(:,77) = s;
%dataPolar_Y_BFA = [dataSort(1:1250,:);...
%    dataSort(end-1250+1:end,:)];
t_Y_BFA = t;

counter = all - count;
percent = (counter*100)/all;
%disp('all');
%disp(all);
%disp('satisfied');
%disp(sat);
disp('percent');
disp(percent);
fileName = strcat('Data/data_Y_Greedy',num2str(randtime),'_',num2str(randsize),'.mat');
save(fileName,'odfs','counter','randsize','dataOri*','t_*');
exit;


