function checkOdfs()
Data = load('AllData.mat');
odfs = [];
for i=1:length(Data.odfs)
Odf = Data.odfs(i,:);
odf = Odf(1:76);
val = Odf(77);
if val < 0
	val = -val
end
odfs = [odfs;odf,val];
end

save('AllData.mat','odfs');
exit;
