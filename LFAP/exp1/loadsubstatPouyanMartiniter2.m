function[towa,away]=loadsubstatPouyanMartiniter2(subname)
close all;

[towaM, awayM] = loadsubstatMartiniter2('ml');
[towaP, awayP] = loadsubstatPouyaniter2('PF');




towamean = mean([towaM(:,3:7),towaP(3:7)],2);
towastd = std([towaM(:,3:7),towaP(3:7)]')/sqrt(8);
errorbar(towaP(:,1),towamean,towastd,'or');
xlim([-pi/4 5*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking towards', 'increase in X axis means light source moving up', ...
    'increase in Y axis means being more correct'});

awaymean = mean([awayM(:,3:7),awayP(3:7)],2);
awaystd = std([awayM(:,3:7),awayP(3:7)]')/sqrt(8);
figure;errorbar(awayP(:,1),awaymean,awaystd,'ob');
%xlim([3*pi/4 9*pi/4]);
xlim([-pi/4 5*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking away', 'increase in X axis means light source moving bottom', ...
    'increase in Y axis means being less correct'});

return;