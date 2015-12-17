function[Sum] = checkRosanne(odf,constraint)
	Sum = 0;

	for i=1:76
		val = odf(i)*constraint(i);
		Sum = Sum + val;
	end
	

