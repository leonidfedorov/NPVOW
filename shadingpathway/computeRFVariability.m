function [vardata] = computeRFVariability(pathkey, type)

%computeRFVariability(folder) given the results of the hierarchical shading
%              pathway computation stored in a specified folder, computes
%              the temporal variability of each RF. 
%
%                Version 0.9,  11 November 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%

resp = loadPathwayResp(pathkey, type);
[tind, xind, yind, dirind] = size(resp); 
%[# of time points, # of RFs in horizontal dimension, # .. in vertical
%dimension, # of filter orientations]


ev = unityroots(dirind); %Complex roots to 'x^dirind = 1', each has absolute value = 1 obviously

rfresp = zeros(tind, xind * yind);
te = reshape(resp, tind, xind * yind, dirind); %just have the 2d RF array as 1d array for convenience
for i = 1 : xind * yind,
    for t = 1 : tind,
        %inner product of R^dirind RF response vector at a given time with a standard 
        %basis of C^dirind represents an R^1 RF population code at a higher level
        rfresp(t, i) = ev * squeeze(te(t, i, :));
    end
end

rftempmeans = sum(rfresp, 1) / tind; %means of every RF across time(which is the first array dimension)

%we take the temporal variability as the absolute value of every RF code
%minus its temporal mean
rfvariability = inf(size(rfresp));
for i = 1 : xind * yind,
    for t = 1 : tind,
        rfvariability(t, i) = abs((rfresp(t, i) - rftempmeans(i)));
    end
end


%TODO: this is a very crude quantifier of variability, which basically sums
%up across all RFs and all time. If it doesn't work, improve it here.
vardata.sum = sum(rfvariability(:));
vardata.dimensions = [tind, xind, yind, dirind];
vardata.variability = rfvariability;

save(fullfile( WalkerPath.getPath(pathkey), strcat('rfvar_', type,'.mat')),'vardata')



return