function [slope1,slope2] = two_slopes(pt,slopes)
    distances = [];
    directions =[]; % 0 represent left, 1 represents right. Main purpose is to find one line to the left and one line to the right.
    for k=1:length(slopes)
        d = point_to_line(pt,slopes(k).begin,slopes(k).end); % Calculate the distance of point to each line. Distance is non-negative
		which_direction = find_direction(pt,slopes(k).begin,slopes(k).end); % In here we calculate the position of point wrt  respective line is accumulated into a logical array. 
		directions = [directions which_direction];
        %fprintf('Distance: %.2f\n',d);
        %fprintf('Theta: %.2f\n',slopes(k).theta);
        distances= [distances d];
    end
    temp_slopes = slopes;
    [m,ind] = min(distances);
	dir = directions(ind);
    slope1 = temp_slopes(ind).theta;
    distances(ind) = [];% Remove min distance to find the second minimum distance.
	directions(ind) = [];
    temp_slopes(ind) = [];
	while 1
		if dir == 0 % Previous line was on left. Find the immediate right line.
			m = min(distances(find(directions==1)));
		else % Previous line was on right. Find the immediate left line.
			m = min(distances(find(directions==0)));
		end
		if isempty(m)
			m = min(distances);
			ind = find(distances==m);
			slope2 = temp_slopes(ind).theta;
			break
		else
			ind = find(distances==m);
			slope2 = temp_slopes(ind).theta; % Assign it whatever the condition. Below, check whether it is a duplicate or too-close line.
			if abs(slope1 - slope2) < 3 % They are too close, probably a floating point error in the distance function.
				distances(ind) = [];
				directions(ind) = [];
				temp_slopes(ind) = [];
			else
				break
			end
		end
	end
		
end