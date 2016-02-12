function [rotA] = rotation3D(phi, theta, psi)
% follows convention in: 
% http://mathworld.wolfram.com/EulerAngles.html
% as of 12 Feb 2016.
% Assumes rotation matrix A = B(psi)*C(theta)*D(phi)
display(0)
rotD = @(an) [cos(an), sin(an), 0; ...
                  -sin(an), cos(an), 0; ...
                  0, 0, 1];
              
rotC = @(an) [1, 0, 0; ...
                0, cos(an), sin(an); ...
                0, -sin(an), cos(an)];

rotB = @(an) [cos(an), sin(an), 0; ...
                -sin(an), cos(an), 0; ...
                0, 0, 1];

rotA = rotB(psi) * rotC(theta) * rotD(phi);

return