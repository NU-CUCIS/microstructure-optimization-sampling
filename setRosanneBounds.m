function[odf] = setRosanneBounds(idxes,indices,odf,odfX,constraint)
	val = 0;
	for i = 1:length(indices)-1
		idx = idxes(i);
		val = val +(constraint(idx)*odf(idx));
	end

	idx = indices(length(indices));
	val = val+(constraint(idx)*odfX);
	odf(idx) = odfX;

	len = 76 - length(indices);
	for i = 1:76
		if sum(find(idxes(i)==indices))==0 %if it is not a member of the list
			odf(i) = (1-val)/len;
		end
	end
