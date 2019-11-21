function [bestOpt, bestOdf] = modifiedRosanneSearch(num)
	
	Max = 1;
	fhandle = @rosanneOptY %%%Need to change this
	
	data1 = load('constraints.mat');
	constraint = data1.constraint;
	
	inFileName = concat('Data/treeConstraints',num,'.mat')
	data2 = load(inFileName);
	idxes = data2.idxes;
	ub = data2.ub;
	lb = data2.lb;
	
	data3 = load('Odf.mat');
	odf = data3.odfHi;
	%odf = zeros(1,76);
	%odf(idxes(1)) = 1/constraint(idxes(1));
	indices = [];
	odfs = [];
	opts = [];

	for i=1:76
		idx = idxes(i);
		odfX0 = odf(idx);
		indices = [indices,idx];
		low = lb(idx);
		up = ub(idx);	
		Constraint = constraint(idx);	
		fhandle = @(odfX0)rosanneOptY(odfX0, odf, indices, num);
		chandle = @(odfX0)simpleConstraint(odfX0, odf, indices, num);
		odfX = patternsearch(fhandle,odfX0,[],[],Constraint,Max,low,up,chandle);
		println('idx',idx);
		println('odfX',odfX);
		val = odfX*constraint(idx);
		Max = Max - val;
		odf = setRosanneBounds(idxes,indices,odf,odfX,constraint);
		opt = SeparateOptY(odf);
		println('val',val);
		println('Max',Max);
		println('opt',opt);
		opts = [opts;opt];
		odfs = [odfs;odf];
	end

	outFileName = concat('Data/rosanneSols',num,'.mat');
	save(outFileName,'opts','odfs');
	exit;
