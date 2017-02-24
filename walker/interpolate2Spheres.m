function interpolate2Spheres(maskim_path, grayim_path, restim_path)
close all;
% maskim = imread(fullfile('C:\Users\leonidf\Documents\MATLAB\NPVOW\LFAP\exp4\bw_away_3.1416_febw', '1.png'));
% grayim = imread(fullfile('C:\Users\leonidf\Documents\MATLAB\NPVOW\LFAP\exp4\away_3.1416_febw', '1.png'));
% restim_path = fullfile('C:\Users\leonidf\Documents\MATLAB\NPVOW\LFAP\exp4\interp_away_3.1416_febw', '1.png');

maskim = imread(maskim_path);
grayim = imread(grayim_path);


grayim(:, :, 2:3) = [];
grayim = im2double(grayim);

maskim(:, :, 2:3) = [];
maskim = maskim > 5;
%internal points
[y,x] = find(maskim);

%boundary points
% crn = corner(maskim, 'Harris');
[ye, xe] = find(edge(maskim, 'Sobel'));
crn = [xe, ye];

%center of mass
cm = [mean(x) mean(y)];

%determine radius as a maximal distance between center of mass and boundary
rads = [];
for j = 1:size(crn, 1),
    rads = [rads pdist([cm; crn(j,:)])];
end
r = max(rads);

imshow(maskim); hold on; 

plot(crn(:,1), crn(:, 2), 'r.');
%in the image, y coordinate counts from the top
plot(cm(1), cm(2), 'g*');
plot([crn(1,1), cm(1)], [crn(1,2), cm(2)])
%crn(1,1) x coordinate of 1st corner, crn(1, 2) y coordinate of first
%corner.
%cm(1) x coordinate of center cm(2) y coordinate of center
% plot([crn(2,1), cm(1)], [crn(2,2), cm(2)]) %vertical line


 
alphas = Inf(size(crn, 1),1);
xb_n = Inf(size(crn, 1), 1);
yb_n = Inf(size(crn, 1), 1);
for i = 1:size(crn, 1),
%     alpha = atan(crn(i, 2) / crn(i, 1));
%     rad2deg(alpha)
%     atan2d(norm(cross(crn(i, :), v)), dot(u, v))
    %angle between center-to-boundary vector and Y=0 horizontal line
    alpha = atan2(crn(i, 2) - cm(2), crn(i, 1) - cm(1));
%     rad2deg(atan2(crn(i, 2) - cm(2), crn(i, 1) - cm(1)))
    %new boundary coordinates
    xb_n(i)= r * cos(alpha) + cm(1);
    yb_n(i) = r * sin(alpha) + cm(2);   
    plot([cm(1), xb_n(i)], [cm(2), yb_n(i)]);
    
    alphas(i) = alpha;
end

%X and Y coordinate functions in the new chart, interpolated (learnt) as a 
%map between old and new boundaries
Fx = scatteredInterpolant(crn(:, 1), crn(:, 2), xb_n, 'linear');
Fy = scatteredInterpolant(crn(:, 1), crn(:, 2), yb_n, 'linear');

%X and Y coordinates of internal points in the new chart by evaluating the
%cooridnate map
% [xq, yq] = meshgrid(x, y);
xint_new = Fx(x, y);
% [xq, yq] = meshgrid(x, y);
yint_new = Fy(x, y);

plot(xint_new, yint_new, 'r.')
plot(crn(:, 1), crn(:, 2), 'g*')

%"gray" brightness values as a coordinate of the interior points
gv = Inf(size(x));
for k = 1:size(x, 1),
    gv(k) = grayim(y(k), x(k));
end

%brightness coordinate function from new XY chart to the old color
Fgv = scatteredInterpolant(xint_new, yint_new, gv, 'nearest');

%brightness of points in the new coordinate chart
%test values that worked on 1.png
% [xg, yg] = meshgrid(397 : 468, 457 : 528);
% [xg, yg] = meshgrid(round(min(xint_new), 0):round(max(xint_new), 0), round(min(yint_new), 0): round(max(yint_new), 0));
[xg, yg] = meshgrid(1:900, 1:900);
gv_new = Fgv(xg, yg);
% Fgv = scatteredInterpolant(xint_new, yint_new,)

%circular mask centered at the center of mass and with new boundary radius
figure; imshow(gv_new);
% circmask = circleMask(numel(397 : 468)/2, numel(397 : 468)/2, numel(397 : 468), numel(457 : 528), r);
wi = round(min(xint_new), 0) : round(max(xint_new), 0);
he = round(min(yint_new), 0) : round(max(yint_new), 0);
circmask = circleMask(cm(1), cm(2), 900, 900, r);

%binary mask cuts off color interpolated outside the boundary
sphere = circmask .* gv_new;
figure; imshow(sphere);

imwrite(sphere, restim_path, 'PNG')

% display(1)'

end
