function extractData(val)
%It extracts the odfs and the stress value from the rows in the matrix and stores in new matrix
	inFile = strcat('Data/data_SmallPartition',num2str(val),'_200000.mat');
	outFile = strcat('data_SmallPartition',num2str(val),'_200000.mat');

	load(inFile);

	odfs = [];
	len = length(Data);
	for i=1:len
        	row = Data(i,:);
        	odf = [row(1:76),row(80)];
        	odfs = [odfs;odf];
	end

	save(outFile,'randsize','odfs','Data','t_Y_RkI');
	exit;

