function [savepath] = plotArm(pathkey1, pathkey2)
% plotArm(pathkey)
%          Plots the point-light arm from data under pathkey1 and saves the
%          AVI under pathkey2.
%
%                Version 0.1,  21 January 2016 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7

data = readArmData(pathkey1);

mainfigure = figure; set(mainfigure, 'Position', [50 60 800 600], 'Color', [0.1 0.1 0.1]);
whitebg([0.1 0.1 0.1])
box off;
set(gca,'xtick',[])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
for ind = 1:size(data, 1),
    te2 = reshape(data(ind, :), [3 5])';
    plot3(te2(:, 1), te2(:, 2), te2(:, 3), 'MarkerSize', 23.0, 'Marker', '.', 'LineStyle', 'none')
    view([120 -30])
    pause(0.05);
end

savepath = WalkerPath.getPath(pathkey2);

return


