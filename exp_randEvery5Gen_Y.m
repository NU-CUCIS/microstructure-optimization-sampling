clear all
warning off

randsize =500;
all = randsize;
count = 0;
propFunc = @SeparateOptY;

constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];

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
data_RandEvery5 = [];

tic

for i = 1:randsize
    
remainFac = 1:1:75;
setFac = zeros(1,75);
thsd = 1;

outerLp = 1;
while isempty(remainFac) == 0
    
    if length(remainFac) < 5
        r = 1;
    else
        r = 5;
    end
    
    randDraw = randsample(length(remainFac),r);
    randFac = remainFac(randDraw);
    remainFac(randDraw) = [];
    
    randFacRand = rand(1,r).*thsd;
    
    innerLp(outerLp) = 1;
    while sum(randFacRand) > thsd
        randFacRand = rand(1,r).*thsd;
        innerLp(outerLp) = innerLp(outerLp) + 1;
    end
    
    thVector(outerLp) = thsd;
    
    thsd = thsd - sum(randFacRand); 
    
    setFac(randFac) = randFacRand./constraint(randFac);
    
    outerLp = outerLp + 1;
end

odf = [setFac,thsd/constraint(end)];
if (odf>=0) == true(1,length(odf))
    val = propFunc(odf);
    if val == -10000
        count = count + 1
    end
    
    data_RandEvery5 = [data_RandEvery5;odf,-val];
    %else
%         display('outbound wrong');
%         return
    %end
%else
%     display('negative wrong');
%     return
end

end

t = toc;

[s,ind] = sort(data_RandEvery5(:,77));
dataSort = data_RandEvery5(ind,:);

for i = 1:randsize
if dataSort(i,77) == s(i)
    continue
else
    disp('sorting not right!')
    break
end
end

dataOri_Y_REk = data_RandEvery5;
%dataSort(:,77) = s;
%dataPolar_Y_REk = [dataSort(1:1250,:);...
%    dataSort(end-1250+1:end,:)];
t_Y_REk = t;

sat = all - count;
percent = (sat *100)/all;
disp('all');
disp(all);
disp('satisfied');
disp(sat);
disp('percent');
disp(percent);
save('data_Y_REk.mat','dataOri*','t_*')


