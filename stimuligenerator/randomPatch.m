function [outpath] = randomPatch(in1, in2, out, radius, phnum, blend)

close all;
in1vid = VideoReader(in1)
in2vid = VideoReader(in2)
frrate = get(in1vid,'FrameRate');
numofr1 = get(in1vid, 'NumberOfFrames');
numofr2 = get(in2vid, 'NumberOfFrames');

if numofr1 ~= numofr2,
    display('Videos have to be normalized by having the same number of frames.')
    outpath = 'no path assigned because of error.';
    return
end


frames1 = read(in1vid);
frames2 = read(in2vid);

if size(frames1) ~= size(frames2),
    display('Videos have to be normalized by having the same resolution.')
    outpath = 'no path assigned because of error.';
    return
end


outvid = VideoWriter(out, 'Motion JPEG AVI');
set(outvid, 'Quality', 100, 'FrameRate', frrate);
open(outvid);

% outframes = nnz(size(frames1, ))

frames1(:, :, 2 : 3, :) = [];
frames2(:, :, 2 : 3, :) = [];

for frindex = 1:numofr1,
    frame1 = frames1(:, :, frindex);
    frame2 = frames2(:, :, frindex);
   
    mask = zeros(size(frame1));
    for circleInd = 1 : phnum, 
        mask = double(mask + circleMask(randi(500, phnum, 2) + 200, randi(700, phnum, 2) + 100, size(frame1, 1), size(frame1, 2), radius) > 0);
    end

    frame2 = imfilter(frame2, fspecial('gaussian', 30, 0.5), 'replicate');
    
    newframe = blend * mask .* im2double(frame1) + (1 - blend) * mask.* im2double(frame2);
    

    
    subplot(2, 2, 1); imshow(frame1);
    subplot(2, 2, 2); imshow(frame2);
    subplot(2, 2, 3); imshow(mask);
    subplot(2, 2, 4); imshow(newframe);
    writeVideo(outvid, newframe);

end

close(outvid);
