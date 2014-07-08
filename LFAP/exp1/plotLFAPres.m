function [standarderror] = plotLFAPres(towa0, away0, towa1, away1, towa2, away2, towa3, away3, type)

type = 0;

[towa0,away0] = loadsubstatfromold(0);
[towa1,away1] = loadsubstatfromold(1);
[towa2,away2] = loadsubstat('dude1');
[towa3,away3] = loadsubstat('daria');

close all;

towamean = mean([towa0(:,3:6),towa1(:,3:6),towa2(:,3:6),towa3(:,3:6)],2);
towastd = std([towa0(:,3:6),towa1(:,3:6),towa2(:,3:6),towa3(:,3:6)]')/4;
errorbar(towa0(:,1),towamean,towastd,'or');
xlim([0 pi]);
ylim([0 1]);
title('walking towards');

awaymean = mean([away0(:,3:6),away1(:,3:6),away2(:,3:6),away3(:,3:6)],2);
awaystd = std([away0(:,3:6),away1(:,3:6),away2(:,3:6),away3(:,3:6)]')/4;
figure; errorbar(away0(:,1),awaymean,awaystd,'ob');
xlim([0 pi]);
ylim([0 1]);
title('walking away');

return;