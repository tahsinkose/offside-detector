function draw_difference(pt1, pt2, v11, v21, v1, v2, sz)
  
  	d1 = (v2(2) - v1(2)) / (v2(1) - v1(1)); %slope of the first line.
    
    d = -1/d1/2;							%perpendicular slope of the first line.
    
    x2 = (sz(1)/20) / sqrt(1+d^2);			%endpoints of the blue line.
    y2 = (sz(1)/20) * d / sqrt(1+d^2);		%
    
    plot([pt2(1)-x2 pt2(1)+x2], [pt2(2)-y2 pt2(2)+y2],'LineWidth',2,'Color','blue'); %plotting blue line segment for player 1.
    
    d1 = (v21(2) - v11(2)) / (v21(1) - v11(1));		%slope of the second line.
    
    d = -1/d1/2;							%perpendicular slope of the second line.
    
    x2 = (sz(1)/20) / sqrt(1+d^2);			%endpoints of the blue line.
    y2 = (sz(1)/20) * d / sqrt(1+d^2);		%
    
    plot([pt1(1)-x2 pt1(1)+x2], [pt1(2)-y2 pt1(2)+y2],'LineWidth',2,'Color','blue'); %plotting blue line segment for player 2.
    
    
    plot([pt2(1) pt2(1)], [pt2(2) pt2(2)-sz(2)/10],'LineWidth',2,'Color','black');	%plotting black vertical lines for both players.
    plot([pt1(1) pt1(1)], [pt1(2) pt1(2)-sz(2)/10],'LineWidth',2,'Color','black');
    
    
    
end
