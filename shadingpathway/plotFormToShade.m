function plotFormToShade(pathkey, timestamp)
% plotFormToShade(pathkey, timestamp);
%          plots responses of the form pathway of the Giese-Poggio 2003
%          model to the stimuli of large shaded walkers. Takes pathkey as
%          an input - it should contain a data result. On one figure there 
%          are curves of every orientation selective cell within every
%          receptive field over time. The second figure shows a movie of
%          the original walker with overlayed RF activity quiver plot.
%          Arrow orientation indicates filter orientation and arrow length
%          indicates response strength. The movie is shown with fixed delay
%          between frames, independent from original stimuli FPS. All
%          plotted frames of the movie are saved either in the {pathkey} 
%          folder, or in {timestamp} folder if the {timestamp} is provided.
%
%                Version 1.0,  14 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%

narginchk(1, 2)

if nargin == 1
    stimulipath = WalkerPath.getPath(pathkey);
elseif nargin == 2
    stimulipath = fullfile(WalkerPath.getPath(pathkey), timestamp);
end

formdata = load(fullfile(stimulipath, 'formresp.mat'));
V4 = formdata.formresp.v4;
V4pos = formdata.formresp.v4pos;

nrows = size(V4, 1);
ncols = size(V4, 2);

for rowInd = 1 : nrows,
    for colInd = 1 : ncols,       
        subaxis(nrows, ncols, nrows*(rowInd - 1) + colInd); plot(squeeze(V4(rowInd, colInd, :, :))');
        title(['Cells at row: ', num2str(rowInd), ' column: ', num2str(colInd)]);
    end
end


listing = getFrameList(stimulipath);

f = figure;
fpos = get(f, 'position');
[posX, posY] = meshgrid(V4pos(1, :), V4pos(2, :));
for ind = 1:numel(listing)
    img_in = im2double(imread(fullfile(stimulipath,listing{ind})));
    if size(img_in,3) > 1, img_in(:,:,2:3) = []; end
    if ~isequal([fpos(3), fpos(4)], size(img_in))
        set(f, 'position', [0 0 size(img_in)])
    end
    imshow(img_in, 'Border', 'tight'); hold on;
    for i = 1:8
        oneresp = V4(:, :, i, ind);
        quiver(posX, posY, oneresp*sin((i+1)*2*pi/8)*500, oneresp*cos((i+1)*2*pi/8)*500, 0);
    end
    
    currFrame = getframe(gcf);
    imwrite(currFrame.cdata, fullfile(stimulipath,['q',listing{ind}]),'PNG');
    pause(0.03)
end


%display(1)

return

