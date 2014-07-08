function[towa,away]=loadsubstatPouyaniter2(subname)
close all;
%subname = '';

%load('female_exp\away\exp_0.3927_fe_aw_fr4.mat');
dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp1\';
te = load(strcat(dname,'pilot\iter2\', subname,'_resp540.mat'));

resp = te.('resp');

for i = 1:size(resp,1),
    if resp(i,1)>11.7 && resp(i,1)<11.9,
        resp(i,1) = inf;
    elseif resp(i,1)>6.7 && resp(i,1)<6.9,
        resp(i,1) = -inf;
    end
    if mod(i,36)==0
        resp(i,1) = 3.1416;
    end
    if resp(i,2) == 0 && resp(i,1) ~=inf && resp(i,1) ~= -inf,
        resp(i,1) = resp(i,1) + pi;
    end
end

shad = resp(~isinf(resp(:,1)),:);
towaComplete = shad(shad(:,2)==1,:);
awayComplete = shad(shad(:,2)==0,:);

towa = [towaComplete(1:17,1:2),reshape(towaComplete(:,3),[17 size(towaComplete,1)/17])];
away = [awayComplete(1:17,1:2),reshape(awayComplete(:,3),[17 size(awayComplete,1)/17])];


towamean = mean(towa(:,3:17),2);
towastd = std(towa(:,3:17)')/4;
errorbar(towa(:,1),towamean,towastd,'or');
xlim([-pi/4 5*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking towards', 'increase in X axis means light source moving up', ...
    'increase in Y axis means being more correct'});

awaymean = mean(away(:,3:17),2);
awaystd = std(away(:,3:17)')/4;
figure;errorbar(away(:,1),awaymean,awaystd,'ob');
xlim([3*pi/4 9*pi/4]);
ylim([-0.2 1.2]);
grid on;
title({'walking away', 'increase in X axis means light source moving bottom', ...
    'increase in Y axis means being less correct'});

return;