function [mask] = makesquarecellmask(cellSize, marginSize)

%makesquarecellmask(cellSize, marginSize) creates a square matrix of size
%       (cellSize+marginSize*2)^2 that could be used as a weight mask for a 
%       square receptive field. Weights are evenly distributed in an
%       interval (0,1] so that their number matches marginSize+1, as:
%       (1/(marginSize+1):(1/(marginSize+1)):1. Exactly at indices
%       [marginSize+1:marginSize+cellSize]^2 there's a cellSize^2 square 
%       matrix of 1.0, so the receptive field central weights equal 1.0
%        
%       Example: makesquarecellmask(2, 2) returns:
%       [[0.3333    0.3333    0.3333    0.3333    0.3333    0.3333];
%       [0.3333    0.6667    0.6667    0.6667    0.6667    0.3333];
%       [0.3333    0.6667    1.0000    1.0000    0.6667    0.3333];
%       [0.3333    0.6667    1.0000    1.0000    0.6667    0.3333];
%       [0.3333    0.6667    0.6667    0.6667    0.6667    0.3333];
%       [0.3333    0.3333    0.3333    0.3333    0.3333    0.3333]]
%
%                Version 1.0,  07 July 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%

narginchk(2,2)

weights = ( 1/(marginSize+1) ): ( 1/(marginSize+1) ) : 1;

size = cellSize + marginSize*2;

cell = inf(size,size);

for i = 1:numel(weights), 
    cell(i:end-i+1, i:end-i+1) = ones(size-2*(i-1),size-2*(i-1)) * weights(i);
end

%display(cell)
%surf(cell)

mask = cell;


return