% random partition the sum of 1
% only generate small number of partitions assuming that

function SmallPartition(num,randsize)
%clear; clc; close all
counter = [];
odfs = [];
Data = [];
count = 0;
constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];

tic
% 1 partition - 76 outcomes
if num == 1
	for i = 1:76
    		odf_1 = zeros(1,76);
    		odf_1(i) = 1./constraint(i);
    		odf = odf_1(i)
    		[val,w1t,w1b] = SeparateOptimumY(odf_1);
    		if val == -10000
        		count = count + 1;
    		else
			odfs = [odfs;odf_1,-val];
			Data = [Data;odf_1,num,w1t,w1b,-val];
	    
    		end
	end

else

	[odfarray,dataarray] = randSmallPartition(num,randsize,@SeparateOptimumY);
	odfs = [odfs;odfarray];	
	Data = [Data;dataarray];
end
toc
t = toc;
t_Y_RkI = t;
println(t)
fileName = strcat('Data/data_SmallPartition',num2str(num),'_',num2str(randsize),'.mat'); 
save(fileName,'Data','odfs','randsize','count','t_*');
FindMaxMin(fileName);
exit;