function [resultPathList] = processStimuliSet(folder)

%processStimuliSet(folder) runs the hierarchical part of shading pathway on
%       a collection of stimuli in a given folder. Assumes the videos are 
%       already split into individual images and stores all results there
%        
%
%                Version 1.5,  07 July 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%


narginchk(1,1)


d = dir(folder);
isub = [d(:).isdir]; %# returns logical vector
folderList = {d(isub).name}';
folderList(ismember(folderList,{'.','..'})) = [];

resultPathList = {};


for i = 1:numel(folderList),
    resultPath = allcgabormax(fullfile(folder,char(folderList(i))));
    display(resultPath)
    resultPathList = [resultPathList; resultPath];
end
display(resultPathList)



return