function plotDist()%fileName)
%%Find the Maximum and Minimum of the odfs
%fileName = 'Data/data_SmallPartition3_10000.mat'%'smallPartition100000.mat'
fileName = 'AllData.mat'
allData = load(fileName);
Data = allData.odfs;
len = size(Data,1);
Max = Data(1,77);
odfHi = Data(1,:);
Min = Data(1,77);
odfLo = Data(1,:);
nc =[];
Opts =[];
zeroOdf =zeros(1,76);
maxOpt = [];maxOdf = [];
for i=1:76
        maxOpt=[maxOpt,0];
	maxOdf =[maxOdf;zeroOdf];
end
println(size(maxOdf));
println(maxOdf);
for i=1:len
	println('In row',i);
	all = Data(i,:);
	odf = all(1:76);
	val = all(77);
	nc = [nc,nnz(odf)];
	println(length( maxOdf(nc,:)));
	println(length(odf));
	if maxOpt(nc) ==0
		maxOpt(nc) =val;
		for i=1:76
			maxOdf(nc,i) =odf(i);
		end
	else
		maxOpt(nc) = max(val, maxOpt(nc));
		%maxOdf(nc,:) = odf;
		for i=1:76
                        maxOdf(nc,i) =odf(i);
                end
	end	
	
	%Opts =[Opts,val];
	%if val>Max
	%	Max = val;
	%	odfHi = odf;
	%end
	
	%if val<Min
	%	Min = val;
	%	odfLo = odf;
	%end
end
%disp('Max');
%disp(Max);
%disp(odfHi);
%disp('Min');
%disp(Min);
%disp(odfLo);
%figure,close
%plot(iter,maxOpt)
%print -dpdf -r600 chart.pdf
save('polyCrystal.mat','maxOpt','maxOdf');
exit;
