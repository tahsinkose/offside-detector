function dir = find_direction(pt, v1,v2)
	% Simply calculates through parametric line equation -> y(t) = v1(2) + (v2(2)-v1(2))*t . And same for x(t)
	t  = (pt(2) - v1(2)) / (v2(2)-v1(2)); 
	x_on_line = v1(1)  + t * (v2(1) - v1(1));
	if  x_on_line < pt(1) %means point is right to the line.
		dir = 1;
	else
		dir = 0; % means point is left to the line.
	end
end