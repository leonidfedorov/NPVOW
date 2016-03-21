function storeAVIasPNGset(folder)

%storeAVIasPNGset(folder) stores each AVI from a given folder as a set of
%       PNGs corresponding to its frames, in folders identical to AVI names
%        
%
%                Version 1.5,  07 July 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%


narginchk(1,1)

%NOTE: dir() actually takes care of potential double slashes in this wildcard
%call, but not of the case of no slashes; hence appending filesep()
aviListing = dir(strcat(folder, filesep, '*.avi'));
videoNameList = {};
for i = 1 : numel(aviListing),
    [filePath, fileName, fileExt] = fileparts(aviListing(i).name); 
    videoName = fullfile(folder, fileName);
    videoNameList = [videoNameList; {videoName}]; 
    if ~isdir(videoName)
        mkdir(videoName);
    end
end


for i = 1 : numel(videoNameList)
    fullVideoName = fullfile(folder, aviListing(i).name);
    video = VideoReader(fullVideoName);
    display(fullVideoName)

    % we only want half of all frames because they contain full gait cycle
    for frindex = 28:177,%1 : (video.framerate*video.duration), 
        videoFrame = readFrame(video);
        videoFrame(:, :, 2 : 3) = [];
%         videoFrame = videoFrame(50:850,300:600);
%NOTE: below its very important to convert the second argument with char(),
%otherwise the imwrite() function won't be able to parse its arguments.
        imwrite(videoFrame, char(fullfile(videoNameList(i), strcat(num2str(frindex),'.png'))),'PNG');

        %imshow(videoFrame);
    end
end