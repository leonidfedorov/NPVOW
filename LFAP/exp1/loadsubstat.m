function[towa,away]=loadsubstat(subname)
close all;
%subname = '';



%load('female_exp\away\exp_0.3927_fe_aw_fr4.mat');
dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp1\';
te = load(strcat(dname,'result\', subname));

resp = te.('resp');

%cut first repetition of every movie for subjects where it is included in
%the data, because it is counted as a training trial
if size(resp, 1)==576,
    resp(1:36,:) = [];
end

shad = resp(~isinf(resp(:,1)),:);
towaComplete = shad(shad(:,2)==1,:);
awayComplete = shad(shad(:,2)==0,:);

towa = [towaComplete(1:17,1:2),reshape(towaComplete(:,3),[17 size(towaComplete,1)/17])];
away = [awayComplete(1:17,1:2),reshape(awayComplete(:,3),[17 size(awayComplete,1)/17])];


towamean = mean(towa(:,3:17),2);
towastd = std(towa(:,3:17)')/4;
errorbar(towa(:,1),towamean,towastd,'r');
xlim([-pi/4 5*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking towards', 'increase in X axis means light source moving up', ...
    'increase in Y axis means being more correct'});

awaymean = mean(away(:,3:17),2);
awaystd = std(away(:,3:17)')/4;
figure;errorbar(away(:,1),awaymean,awaystd,'b');
xlim([3*pi/4 9*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking away', 'increase in X axis means light source moving bottom', ...
    'increase in Y axis means being less correct'});

[p_towa,tab_towa, stats_towa] = anova1(towa(:,3:17)')
[p_away,tab_away, stats_away] = anova1(away(:,3:17)')

return