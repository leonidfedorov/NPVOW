function[towa,away]=storematasavi(folder)
%close all;

folder = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp1\conditions\current\';
%filename = 'away_4.7124_febw.mat';

listing = dir(fullfile(folder,'*.mat'));

for fileI = 1:numel(listing)
    fullFilename = fullfile(folder, listing(fileI).name)

    data = load(fullFilename);
    allFrames = data.('mmo');

    [pathstr, name, ext] = fileparts (fullFilename);
    vidObj = VideoWriter(fullfile(pathstr,strcat(name,'.avi')));
    open(vidObj);

    for frameI  = 1:numel(allFrames)
        %imshow(allFrames(i).cdata);
        writeVideo(vidObj,allFrames(frameI).cdata);
    end

    close(vidObj);
end

return;