function plotSnapshotProfiles(type, pathkey, timestamp)
% plotSnapshotProfiles(pathkey, timestamp);
%          plots responses of the snapshot neuron level of the Giese-Poggio
%          2003 model to a given pathway input.
%
%                Version 1.0,  26 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%

narginchk(2, 3)

if nargin == 2
    stimulipath = WalkerPath.getPath(pathkey);
elseif nargin == 3
    stimulipath = fullfile(WalkerPath.getPath(pathkey), timestamp);
end

respdata = load(fullfile(stimulipath, strcat(type,'_networkResp.mat')));
nresp = respdata.networkResp.resp;
keys = respdata.networkResp.meta;

%Recall that networResp.resp is a 2d cell array where cell indexed i,j
%contains responses of population j to population i, e.g.:
%          [pop1 to pop1] [pop2 to pop1]
%          [pop1 to pop2] [pop2 to pop2]
% Moreover, networkResp.meta stores a 1d cell array of pathkeys on which
% the populations were trained. So indexes i and j in .resp both correspond
% to index k from list 1:numel(.keys). We use this identical numeration to
% label the plots.

[popnum,respnum] = size(nresp);
figure;
for rowind = 1 : popnum,
    for colind = 1:respnum,
        display((rowind-1)*popnum + colind)
        subplot(popnum, popnum, (rowind-1)*(popnum) + colind);
        surf(nresp{rowind, colind});
        title(['Response of ', keys{colind}, ' to ', keys{rowind}])
%         surf(nresp{ind});
%         title(keys{ind})
    end
end

display(1)

return

