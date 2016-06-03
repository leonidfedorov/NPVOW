function [outpath] = randomPatch(in1, in2, out, radius, phnum1, phnum2, blend)
%randomPatch(in1, in2, out, radius, phnum1, phnum2, blend)
%
%Generates a patched mix between two videos.
%
%Considering one video, it generates a specified number of "pinholes", of 
%specified size at random positions for every frame. Every pixel outside 
%the "pinholes" is set to black.
%
%Given the pixels from inside the "pinholes" from both videos, we compose
%a new frame by applying them on top of each other. In case the "pinholes"
%overlap, the pixels are taken from the second video(specified by 'in2').
%
%One can fix the total number of "pinholes" as phnum1 + phnum2, and
%then change the ratio between phnum1 and phnum2, thus biasing 
%the resulting video towards 'in1' or 'in2'
%
%For example, setting phnum1 = 1000, phnum2 = 0, will have 1000 "pinholes"
%in the resulting video('out'), but all pixels will be taken from 'in1'
%Another example, setting phnum1 = 700, phnum2 = 300 will have 700 
%"pinholes" from 'in1' and 300 "pinholes" from 'in2'.
%
%In both cases we have 1000 "pinholes". Therefore we (coarsely)can think 
%that 'in1' has probability phnum1/(phnum1+phnum2) and 'in2' has
%probability phnum2/(phnum1+phnum2) to "show up".
%
%Then in the first example above this is, accordingly 
%1000 / (1000 + 0) = 1.0 and 0 / (1000 + 0) = 0.0
%and in the second example this is
%700 / (700 + 300) = 0.7 and 300 / (700 + 300) = 0.3
%
%One should fix phnum1 + phnum2 and radius for a given experiment.
%
%Patch size can be controlled by the radius parameter.
%
%In the first pilot experiment we set radius=10.
%To try help 'uncertain' participants we set radius=12.
%In both cases we set phnum1 + phnum2 = 1000.
%
%Description of arguments:
%in1 is a full path to the first AVI file
%in2 is a full path to the second AVI file
%out is a full path to the resulting AVI file
%radius is the radius of the disks
%phnum1 is the number of disks applied to the first AVI file
%phnum2 is the number of disks applied to the second AVI file
%blend is presently unused; in principle it is supposed to control the 
%       involvement of first and second file in case the disks overlap.
%
%-LF 06.03.2016
%

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
   
    mask1 = zeros(size(frame1));
    mask2 = zeros(size(frame2));
    
    for circleInd = 1 : phnum1, 
        mask1 = double(mask1 + circleMask(randi(500, phnum1, 2) + 200, randi(700, phnum1, 2) + 100, size(frame1, 1), size(frame1, 2), radius) > 0);
%         mask2 = double(mask2 + circleMask(randi(500, phnum2, 2) + 200, randi(700, phnum2, 2) + 100, size(frame2, 1), size(frame2, 2), radius) > 0);
    end
    
    for circleInd = 1 : phnum2, 
%         mask1 = double(mask1 + circleMask(randi(500, phnum1, 2) + 200, randi(700, phnum1, 2) + 100, size(frame1, 1), size(frame1, 2), radius) > 0);
        mask2 = double(mask2 + circleMask(randi(500, phnum2, 2) + 200, randi(700, phnum2, 2) + 100, size(frame2, 1), size(frame2, 2), radius) > 0);
    end 
    
    frame1 = uint8(mask1).* frame1;
    frame2 = uint8(mask2).* frame2;
    
    newframe = frame2;
    for xInd = 1:size(frame1, 1),
        for yInd = 1:size(frame1, 1),
            if and(frame2(xInd, yInd) == 0, frame1(xInd, yInd) > 0)
                newframe(xInd, yInd) = frame1(xInd, yInd);
            end
        end
    end
    
    newframe = im2double(newframe);
%     newframe = im2double(frame1 + frame2);
    
%     frame2 = imfilter(frame2, fspecial('gasussian', 30, 0.5), 'replicate');
    
%     newframe = blend * mask .* im2double(frame1) + (1 - blend) * mask.* im2double(frame2);
    

    
    subplot(2, 2, 1); imshow(frame1);
    subplot(2, 2, 2); imshow(frame2);
%     subplot(2, 2, 3); imshow(mask);
    subplot(2, 2, 4); imshow(newframe);
    writeVideo(outvid, newframe);

end

close(outvid);
