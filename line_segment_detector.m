function slopes = line_segment_detector(lines)
    max_len = 0;
    slopes=[];
    slope=0;
    distinct_index = 0;
    % Distinct slopes are accumulated with minimum point as its starting
    % point and maximum point as its finishing point.
    for k = 1:length(lines)
        if lines(k).theta ~= slope % First occurence of line with slope.
            distinct_index = distinct_index + 1; % Distinct indices must be incremented exclusively.
            slopes(distinct_index).theta = lines(k).theta;
            if lines(k).theta > 0 % If theta is positive, then the first point occured will be the maximum point.
                slopes(distinct_index).end = lines(k).point1;
            else % Else, will be the minimum point.
                slopes(distinct_index).begin= lines(k).point1;
            end
            
            slope = lines(k).theta; % Save slope for next step of iteration.
            
        else % If not the first occurence, respect for the minimum or maximum point according to the theta value.
            if lines(k).theta > 0
                slopes(distinct_index).begin= lines(k).point2;
            else
                slopes(distinct_index).end = lines(k).point1;
            end
        end
        
    end
   
end