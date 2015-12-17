function getPoly()%fileName)
%%Find the Maximum and Minimum of the odfs
%fileName = 'Data/data_SmallPartition3_10000.mat'%'smallPartition100000.mat'
fileName = 'AllData.mat'
allData = load(fileName);
Data = allData.odfs;
len = length(Data);
Max = Data(1,77);
odfHi = Data(1,:);
Min = Data(1,77);
odfLo = Data(1,:);
println(len);
nc =[];polySol = [];polyVal = [];
Opts =[];countnc = zeros(1,76);
for i=1:size(Data,1)
	all = Data(i,:);
	odf = all(1:76);
	val = all(77);
	nc = [nc,nnz(odf)];
	if  nnz(odf) ==76
		polySol = [polySol;odf];
		polyVal = [polyVal,val];	
	end
	Opts =[Opts,val];
	if val>Max
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
disp('Min');
disp(Min);
disp(odfLo);
println(countnc);
%figure,close;
%plot(nc,Opts);
%print -dpdf -r600 Out.pdf
save('sol76.mat','polySol','polyVal');
exit;
