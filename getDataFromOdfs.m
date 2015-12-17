function getDataFromOdfs()
allOdfs = load('allOdfs.mat');
Odfs = allOdfs.odfs;
odfs = [];
Data = [];
for i=1:length(Odfs)
	odfVal = Odfs(i,:);
	odf = odfVal(1:76);
	[val, w1t, w1b] = SeparateOptimumY(odf);
	disp(strcat('row',num2str(i),' processed.......'));
	odfs = [odfs;odf,val];
	Data = [Data;odf,1,w1t,w1b,val];
end

save('allOdfs.mat','odfs','Data');
exit;
	
	
