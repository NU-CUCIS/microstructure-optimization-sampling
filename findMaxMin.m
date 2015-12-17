function findMaxMin()%fileName)
%%Find the Maximum and Minimum of the odfs
%fileName = 'Data/data_SmallPartition3_10000.mat'%'smallPartition100000.mat'
fileName = 'AllData.mat'
allData = load(fileName);
Data = allData.odfs;
len = length(Data);
Max = Data(1,77);
odfHi =Data(1,:);
odfHi = odfHi(1:76);
Min = Data(1,77);
odfLo = Data(1,:);
odfHi = odfLo(1:76);
println(len);
nc =[];
Opts =[];countnc = zeros(1,76);
for i=1:size(Data,1)
	all = Data(i,:);
	odf = all(1:76);
	val = all(77);
	nc = [nc,nnz(odf)];
	countnc(nc) = 1;
	if val>350
		odfHi = odf;
		Max = val;
		println('exiting')
		break
	end
	Opts =[Opts,val];
	if val>Max
		println('i am greater than max');
		Max = val;
		odfHi = odf;
	end
	
	if val<Min
		Min = val;
		odfLo = odf;
	end
end

disp('Max');
disp(Max);
disp(odfHi);
[a,b,c] = SeparateOptY(odfHi);
save('Odf.mat','odfHi');
println(b);
println(c);
disp('Min');
disp(Min);
disp(odfLo);
println(countnc);
%figure,close;
%plot(nc,Opts);
%print -dpdf -r600 Out.pdf
exit;
