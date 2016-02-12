function [savepath] = plotArm(pathkey1, pathkey2)
% plotArm(pathkey)
%          Plots the point-light arm from data under pathkey1 and saves the
%          AVI under pathkey2.
%
%                Version 0.9,  12 February 2016 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7

data = readArmData(pathkey1);

mainfigure = figure; set(mainfigure, 'Position', [50 60 900 900], 'Color', [0.1 0.1 0.1]);
whitebg([0.1 0.1 0.1])
%box off;
% set(gca,'xtick',[])
% set(gca,'xtick',[])
% set(gca,'xticklabel',[])
%axis equal;
showaxes('boxoff');

%given a list of column numbers, returns the total min and max value
getCoordLimits = @(colnums) bounds(cell2mat(arrayfun(@(ind) bounds(data(:, ind)), colnums, 'UniformOutput', false)));

xlim(getCoordLimits([1 : 3 : 15]) * 1.1);
ylim(getCoordLimits([2 : 3 : 15]) * 1.1);
zlim(getCoordLimits([3 : 3 : 15]) * 1.1);
set(gca,'Position',[.001 .001 .998 .998]);
%this set of parameters is simply adjusted by hand for convenience
startSample = 1050; %starting sample point(row in CSV file)
stopSample = size(data, 1) - 750; %stopping sample point
numOfCycles = 1; %number of times to repeat the motion
timeInt = 0.03;%time interval between plotting samples, has nothing to do with the original sampling frequency
azim_elev = [0 0];% we're plotting in 3D so can adjust the view to our convenience

%TODO: transormations to the arm should apply here: noise, rotation, shift
noise = 0;
shift = [0 0];
rotation = [0 0 0];

V = VideoWriter(fullfile(WalkerPath.getPath(pathkey2), [namevec('n', noise), namevec('s', shift), namevec('r', rotation), namevec('v', azim_elev)]), 'Motion JPEG AVI');
set(V, 'Quality', 100, 'FrameRate', 25);
open(V);

for cycleInd = 1:numOfCycles,
    for ind = startSample : stopSample,
        te2 = reshape(data(ind, :), [3 5])';
        l = line(te2(:, 1), te2(:, 2), te2(:, 3), 'MarkerSize', 50.0, 'Marker', '.', 'MarkerFaceColor', 'red', 'LineStyle', 'none')

        view(azim_elev)
        pause(timeInt);
        
        writeVideo(V, getframe(gcf));
        
        delete(l);
    end
end

close(V);

savepath = WalkerPath.getPath(pathkey2);

return


