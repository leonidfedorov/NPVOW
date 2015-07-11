function [compareStructure] = compareStimuli(folder)

%compareStimuli(folder) runs processStimuliSet() and storeAVIasPNGset()
%           on each subfolder in a given folder. Returns compared results.
%        
%
%                Version 0.5,  11 July 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%



narginchk(1,1)


d = dir(folder);
isub = [d(:).isdir]; %# returns logical vector
folderList = {d(isub).name}';
folderList(ismember(folderList,{'.','..'})) = [];

%resultPathList = {};


for i = 1:numel(folderList),
    stimuliPath = (fullfile(folder,char(folderList(i))));
    display(['Will go through stimuli: ' stimuliPath]);
    storeAVIasPNGset(stimuliPath);
    processStimuliSet(stimuliPath);
end

%TODO: add result comparison
compareStructure = [];

return