function [v1 v2] = find_line(slopes,theta)
	% Simply returns the line segment that corresponds to theta. Since, slopes object array only involves distinct thetas', there will be only one
	% line segment. When it is found, no need to further traverse the array, simply exit.
	for i=1:length(slopes)
		if slopes(i).theta == theta
			v1 = slopes(i).begin;
			v2 = slopes(i).end;
			return
	end

end