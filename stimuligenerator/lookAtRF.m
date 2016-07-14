function lookAtRF(folder, centerX, centerY, resX, resY)

narginchk(5, 5)

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
    tic;
    frames = read(video, [1 Inf]);
    display(['Read ', num2str(size(frames,4)),' frames from ', video.name,' in ', num2str(toc),' seconds.']);
    for frindex = 1 : 30,%size(frames, 4)
        
        LeftX = centerX - floor(resX / 2) + 1;
        RightX = centerX + floor(resX / 2);
        LeftY = centerY - floor(resY / 2) + 1;
        RightY = centerY + floor(resY / 2);
        
        videoFrame = squeeze(frames(LeftX:RightX, LeftY:RightY, :, frindex));
%         videoFrame(:, :, 2 : 3) = [];
%         videoFrame = videoFrame(50:850,300:600);
%NOTE: below its very important to convert the second argument with char(),
%otherwise the imwrite() function won't be able to parse its arguments.
        imwrite(videoFrame, char(fullfile(videoNameList(i), strcat(num2str(frindex),'.png'))),'PNG');

        %imshow(videoFrame);
    end
end