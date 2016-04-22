function [mask] = circleMask(centerX, centerY, sizeX, sizeY, radius)


[x, y] = meshgrid(- (centerX - 1) : (sizeX - centerX), -(centerY - 1) : (sizeY - centerY));

mask = ((x .^ 2 + y .^ 2) <= radius ^ 2);

return
