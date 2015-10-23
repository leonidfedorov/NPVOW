function [respath] = plotWalker(pathkey, grid)
%plotBWwalker(varargin) plots walker frames net to each other for
%                       visual comparison. Takes pathkey and plot grid 
%                       dimensions as input. Number of cells in the grid
%                       equals the number of images retrieved with pathkey.
%        
%
%                Version 0.9,  23 Oct 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%


walkerims = loadLFAPpxlarray(WalkerPath.getPath(pathkey));

patlen = size(walkerims,3);

f = figure;
for ind = 1:patlen
    sa = subaxis(grid(1),grid(2),ind, 'Spacing',0,'Padding',0,'MR',0);

    imagesc(walkerims(:, :, ind)); 
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    %set(gca, 'Position', [0 0 1 1])
    
    ahnd = axis;
    thnd = title(num2str(ind));
    set(thnd,'Position', [ahnd(1)*50.0 ahnd(4)*1.0 0],'Color', [1 1 1]);
end
title([pathkey, ' walker. Last ', num2str(patlen - prod(grid)), ' images are not displayed']);
% if ~isdir(savepath)
%     mkdir(savepath);
% end
%TODO: perhaps think about saving if it gets more sophisticated
%TODO: can give prettier plots -- like without color distortion
respath = [];

end