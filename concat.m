function [out] = concat(varargin)

%This function concats substrings and even numbers into one string
	out = '';
	for i=1:nargin
		val = varargin{i};

		if isnumeric(val)==1
			val = num2str(val);
		end

        out = strcat(out,val);

	end

