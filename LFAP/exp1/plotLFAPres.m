function [standarderror] = plotLFAPresNEW(dname)%(towa0, away0, towa1, away1, towa2, away2, towa3, away3, type)

dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp1\result';

listing = dir(dname);
listing(1:2) = []; %cut off references to parent folders, only keep the filenames
numfiles = numel(listing);


colorlist = [166,206,227;...
    31,120,180;...
    178,223,138;...
    51,160,44;...
    251,154,153;...
    227,26,28;...
    253,191,111;...
    255,127,0;...
    202,178,214;...
    106,61,154;...
    255,255,153;...
    177,89,40];
shiftlist = [0:0.1964/12:0.1963];


towaAll = inf(17,17,numfiles);
awayAll = inf(17,17,numfiles);
towaAllMean = inf(17,numfiles);
towaAllStd = inf(17,numfiles);
awayAllMean = inf(17,numfiles);
awayAllStd = inf(17,numfiles);


%towaAxes = axes('position',[800, 100, 300, 200]);
towaFigure = figure(1);
awayFigure = figure(2);
for n = 1:numfiles,
    color =colorlist(n,:)/256;
    shift = shiftlist(n)/3;
    %scale = 10;
    
    [towa, away] = loadsubstat(listing(n).name);
    
    
    
    towaAll(:,:,n) = towa;
    towaAllMean(:,n) = mean(towa(:,3:17),2);
    towaAllStd(:,n) = std(towa(:,3:17),[],2)/sqrt(15);
    
    set(0, 'currentfigure', towaFigure);  %# for figures
    plot(towaAll(:,1,n)+shift,towaAllMean(:,n),'LineStyle','-.','Color',color,'LineWidth',2.0); hold on;
    %shadedErrorBar(towa(:,1), towaAllMean(:,n), towaAllStd(:,n)/sqrt(15),{'LineStyle','-','LineWidth',3.0,'Color',color},1);hold on;
    %errorbar(towaAll(:,1,n)+shift,towaAllMean(:,n),towaAllStd(:,n),'LineStyle','-','Color',color,'LineWidth',3.0); hold on;
    
    
    
    awayAllMean(:,n) = 1-mean(flipud(away(:,3:17)),2);
    awayAllStd(:,n) = 1-std(flipud(away(:,3:17)),[],2)/sqrt(15);
    awayAll(:,:,n) = away;
    
    set(0, 'currentfigure', awayFigure);  %# for figures
    plot(towaAll(:,1,n)+shift,awayAllMean(:,n),'LineStyle','-.','Color',color,'LineWidth',2.0); hold on;
end

towaPulledMean = mean(towaAllMean,2);
towaPulledStd = std(towaAllMean,[],2);
set(0, 'currentfigure', towaFigure);
shadedErrorBar(towa(:,1),towaPulledMean,towaPulledStd/sqrt(12),{'LineStyle','-','LineWidth',3.0,'Color',[0 0 0]},1)
xlim([-pi/4 5*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking towards', 'increase in X axis means light source moving up', ...
     'increase in Y axis means being more correct'});

awayPulledMean = mean(awayAllMean,2);
awayPulledStd = std(awayAllMean,[],2);
set(0, 'currentfigure', awayFigure);
shadedErrorBar(towa(:,1),awayPulledMean,awayPulledStd/sqrt(12),{'LineStyle','-','LineWidth',3.0,'Color',[0 0 0]},1)
xlim([-pi/4 5*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking away', 'increase in X axis means light source moving up', ...
     'increase in Y axis means being more correct'});

return;