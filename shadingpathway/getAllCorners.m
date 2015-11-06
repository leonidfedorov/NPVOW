function [output] = getAllCorners(folder)

%getAllCorners(folder) return a cell array of corners for each image in the
%           given folder.
%        
%
%                Version 1.0,  4 November 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%
output = []

frames = getFrameList(fullfile(folder));
imgs = cellfun(@(x) imread(fullfile(folder,x)),frames, 'UniformOutput', false);
cornerset = cellfun(@(x) corner(x,'QualityLevel', 0.3), imgs, 'UniformOutput', false);
cellfun(@(x) display(size(x,1)), cornerset)


for ii = 1:numel(frames),
    f = figure;
    fpos = get(f, 'position');
    if size(imgs{ii},3) > 1, imgs{ii}(:,:,2:3) = []; end
    set(f, 'position', [0 0 size(imgs{ii})])
    imshow(imgs{ii},'Border','tight'); hold on;
    for jj = 1:size(cornerset{ii},1),
        plot(cornerset{ii}(jj,1), cornerset{ii}(jj,2),'g*');
    end
    hold off;
end

return