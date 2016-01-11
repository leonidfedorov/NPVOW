function [pxlArray] = timeFadeStimuli(pathkey)
% pixelMorph(pathkey)
%          Linearly combine PNGs under pathkey as sum(c_i*X_i) where X_i 
%          is the i-th image in the folder of N images, and c_i = i*1.0/N
%          and save as a PNG in the same folder.
%
%                Version 1.0,  11 January 2016 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7


folder = WalkerPath.getPath(pathkey)
pictures = loadLFAPpxlarray(folder);
numofpics = size(pictures, 3);
pictures = pictures(300:800, 870:1100, :);


scale = exp(0.5:0.5:5)/150;
for jj = 1 : numofpics,
    if jj < numofpics
        pictures(:, :, jj) = imfilter(pictures(:, :, jj), fspecial('gaussian', 50, 0.5), 'replicate');
    end
    %c_jj = jj * 1.0 / numofpics^2;
    c_jj = scale(jj)
    pictures(:, :, jj) = pictures(:, :, jj) * c_jj;
end
pxlArray = sum(pictures, 3)*3;


f = figure;
imshow(pxlArray);


end