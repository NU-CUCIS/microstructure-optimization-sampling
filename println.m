function [] = Print(varargin)
%This function prints out comma separated values. Similar to println function in java	
	out = '';
	for i=1:nargin
		val = varargin{i};
		
		if isnumeric(val)==1
			val = num2str(val);
		end
			
		out = strcat(out,val);
		
	end
	disp(out)
