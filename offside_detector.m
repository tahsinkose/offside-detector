function offside_detector(image)
    clf;
    I= imread(image);
    ColoredImage= I;
    I= imgaussfilt(I(:,:,2:2),1.9);% Gaussian filter. Used in-order to eliminate noise through blurring the image. 1.9 is experimentally found.
    I = imadjust(I);
    BW = edge(I,'canny'); %Built-in Edge detection filter.
    [H,T,R] = hough(BW,'Theta',-60:0.1:60); % Only consider lines with  -45 degree to 45 degree.


    P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

    lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
    f=figure(1);
    imshow(ColoredImage), hold on
    xlabel('y');
    ylabel('x');

    slopes = line_segment_detector(lines); %Extract all distinct slopes.
    [click1,click2]= getpts(f); % Clicks have problem when reading. Below lines are for that purpose.
    points=[click1,click2];
    click1 = points(1,:);
    click2 = points(2,:);
    % They are properly aligned.
    [slope11,slope12] = two_slopes(click1,slopes)
    [slope21,slope22] = two_slopes(click2,slopes)
    
    lineLength = 700; % Explicitly set to an adequately big value to cover all along the image.
	
	% ------------------------------------------ PLAYER 1 SUBROUTINE -------------------------------------------------
    x(1) = click1(1);
	y(1) = click1(2);
	% Before calculating end points of line segments, we need to interpolate between two slopes we have extracted.
	% The main reason of this calculation is, when lines themselves are clicked on the image, the resulting slope is excellent. However, as we go farther away from the baseline slope, which is slope11, the slopes accumulate
	% themselves and become more ond more inaccurrate.
	[v11 v12] = find_line(slopes,slope11);
	[v3 v4] = find_line(slopes,slope12);
	
	% Player 1 distances to slopes of offside-lines in the field.
	d1 = abs(point_to_line([x(1) y(1)], v11,v12)); 
	d2 = abs(point_to_line([x(1) y(1)], v3,v4));
	% Above two variables will be used to interpolate the slope accordingly.
	player1_slope = slope11 + (((slope12 - slope11) *d1 )/ (d1+d2));
	
	% Sum the angle with 90 degree because of matlab image plot.
	x(2) = x(1) + lineLength * cosd(player1_slope+90); % Draw the line up until end of the image. x(1) is x component of the starting point. x(2) is x component of the ending point.
    y(2) = y(1) + lineLength * sind(player1_slope+90); % Draw the line up until end of the image. y(1) is y component of the starting point. y(2) is y component of the ending point.
	fprintf('Player 1 Slope theta: %.2f\n',player1_slope+90);
    plot(x,y,'LineWidth',1,'Color','red');
    
    x(2) = x(1) - lineLength * cosd(player1_slope+90); % Draw the line down until end of image.
    y(2) = y(1) - lineLength * sind(player1_slope+90);  % Draw the line down until end of image.
    plot(x,y,'LineWidth',1,'Color','red'); %Plot line segment.
	
	% ------------------------------------------ PLAYER 2 SUBROUTINE --------------------------------------------------
	
	x(1) = click2(1);
	y(1) = click2(2);
	[v21 v22] = find_line(slopes,slope21);
	[v3 v4] = find_line(slopes,slope22);
	d3 =abs(point_to_line([x(1) y(1)], v21,v22));
    d4 = abs(point_to_line([x(1) y(1)], v3,v4));

	player2_slope = slope21 + (((slope22 - slope21) *d3 )/ (d3+d4));
	
	x(2) = x(1) + lineLength * cosd(player2_slope+90);
    y(2) = y(1) + lineLength * sind(player2_slope+90); 
	fprintf('Player 2  Slope theta: %.2f\n',player2_slope+90);
    plot(x,y,'LineWidth',1,'Color','black');
    
    x(2) = x(1) - lineLength * cosd(player2_slope+90);
    y(2) = y(1) - lineLength * sind(player2_slope+90); 
    plot(x,y,'LineWidth',1,'Color','black');
	
	draw_difference(click1, click2, v11, v12, v22, v21, size(I)); % Pixel distance along two selected points.
	
	if abs(slope22-slope21) > 20 %Experimentally found. If the difference is more than 18 degrees, than one of the edges are not found.
		multiplier = 11; %2-fold of 5.5, because one of the edges couldn't be detected.
	else
		multiplier = 5.5;
	end
	%                             multiplier * |Theta - Alpha| / |BigLine1.Degree - BigLine2.Degree|
	str = ['Distance= ', num2str(multiplier*abs(player1_slope - player2_slope)/abs(slope22-slope21)),'m']; % Simply take the ratio between two big offside lines and apply it to players'.
	t = text((click1(1)+click2(1))/2 - 35,(click1(2)+click2(2))/2, str);
	t.FontSize = 10;
end