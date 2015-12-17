function every5Gen(randsize)
all = randsize;
sat = 0; count = 0;
propFunc = @SeparateOptimumY;
odfs = [];
Data = [];
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
    [val,w1t,w1b] = propFunc(odf);
    if val == -10000;
        count = count + 1;
    else
	sat = sat + 1;
	disp(strcat('row',num2str(sat),'satisfied....'));
	odfs = [odfs;odf,-val];
        Data = [Data;odf,w1t,w1b,-val];
    end
	
    
end

end

t = toc;

t_Y_REk = t;

disp('satisfied');
disp(sat);
disp('time');
disp(t);
fileName = strcat('Data/data_first5Generator_',num2str(randsize),'.mat');
save(fileName,'randsize','odfs','Data','t_*')
exit;

