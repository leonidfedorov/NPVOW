function plotRFVariability(pathkey, type)
%plotRFVariability(pathkey, type) plots variability of RFs for each condition in
%       LFAP experiments, where the experiment type is specified.
%
%                Version 1.0,  16 November 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%
narginchk(2, 2)


stimulipath = WalkerPath.getPath(pathkey);
model_type = type;


data = loadRFVariability(pathkey, type);

dims =  data.('dimensions');
xind = dims(2); 
yind = dims(3);


variability = data.('variability');

figure;
for j = 1 : xind * yind
    [row, col] = ind2sub([xind yind], j);
    plotind = sub2ind([xind yind], col, row);
    subplot(xind, yind, plotind);
    plot(variability(:, j));
end



return