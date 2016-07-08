function [outpath] = edgeLess(in1, in2, out,  delta, blend)

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

% h = figure;
for frindex = 1:numofr1,
    frame1 = frames1(:, :, frindex);
    frame2 = frames2(:, :, frindex);
    newframe = inf(size(frame1));
    
%     newframe = double(abs(frame1 - frame2) > 20);
    for xInd = 1 : size(frame1, 1),
        for yInd = 1 : size(frame1, 2),
            px1 = frame1(xInd, yInd);
            px2 = frame2(xInd, yInd);
            if px1 - px2 > delta,
                newframe(xInd, yInd) = im2double(px1);
            elseif and(px1 - px2 <= delta, px1 - px2 >= -delta)
                newframe(xInd, yInd) = blend * im2double(px1) + (1 - blend) * im2double(px2);
            else
                newframe(xInd, yInd) = im2double(px2);
            end
        end
    end


    
    s1 = subplot(2, 2, 1); imshow(frame1, 'Parent', s1);
    s2 = subplot(2, 2, 2); imshow(frame2, 'Parent', s2);
%     subplot(2, 2, 3); imshow(mask);
    s4 = subplot(2, 2, 4); imshow(newframe, 'Parent', s4);
    writeVideo(outvid, newframe);

end

close(outvid);
