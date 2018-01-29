function d = point_to_line(pt, v1, v2)
% Taken from below link.
%  https://www.mathworks.com/matlabcentral/answers/95608-is-there-a-function-in-matlab-that-calculates-the-shortest-distance-from-a-point-to-a-line#answer_104961
  a = v1 - v2;
  a = [a 0];
  b = pt - v2;
  b= [b 0];
  d = norm(cross(a,b,2)) / norm(a);
end