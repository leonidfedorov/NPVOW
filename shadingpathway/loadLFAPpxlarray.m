function [pixelArray] = loadLFAPpxlarray(stimuliPath)


narginchk(1,1)
%get file list in a folder


%listing = dir(fullfile(stimuliPath,'*.png'));

listing = getFrameList(stimuliPath);

%NOTE: this hack allows me to pre-allocate the pixelArray, but not read 
%the first file twice. I only assume that all images are of same size and
%stored as PNGs, but I don't know the number of images and the size itself.

if numel(listing) > 0
    img_in = im2double(imread(fullfile(stimuliPath, listing{1})));
    pixelArray = inf([size(img_in),numel(listing)]);
    pixelArray(:,:,1) = img_in;

    for ind = 2:numel(listing),
        img_in = im2double(imread(fullfile(stimuliPath, listing{ind})));
    %    imshow(img_in)
        pixelArray(:,:,ind) = img_in;
    end
end

return