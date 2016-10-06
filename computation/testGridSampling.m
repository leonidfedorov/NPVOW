function [time, measure] = testGridSampling(ubound, numdisks, ngrid, R)


% %number of disks
% numdisks = 1000; 
% %upper bound of the number of pixels in the square image
% ubound = 900;
% %grid density
% ngrid = 10000;
% %disk radius
% R = 10;


tic

rvec = R * ones(1, numdisks); %all disks will be of same radius

%vectors of disk centers, so that no disk pixels are outside [1, ubound]
xc = randi(ubound - 2 * R, 1, numdisks) + R; 
yc = randi(ubound - 2 * R, 1, numdisks) + R;


 
% preliminary square the radii for efficiency
rvec2 = rvec .* rvec;
 

% grid left, right, top and down bounds
xmin = min(xc - rvec);
xmax = max(xc + rvec);
ymin = min(yc - rvec);
ymax = max(yc + rvec);

%total area of the box
box_area = (xmax - xmin) * (ymax - ymin);

%  point counter
inside = 0;
 

% For every point in the grid, check if its inside the disk
for x = linspace(xmin, xmax, ngrid)
    for y = linspace(ymin, ymax, ngrid)
        if any(rvec2 > (x - xc).^2 + (y - yc).^2)
            inside = inside + 1;
        end
    end
end
 

% covering area is the total area times the ratio of inside/all points
covering_area = box_area * inside / ngrid^2;

% hypothetical maximal area if disks didn't overlap
max_area = pi * (R^2) * numdisks;

% overlapping area is the hypothetical non-overlapping area minus covering
overlap_area = max_area - covering_area;
 
% proportion of overlapping area relative to the original 
overlap_ratio = overlap_area / (ubound ^ 2);


time = toc

measure = overlap_ratio


return
