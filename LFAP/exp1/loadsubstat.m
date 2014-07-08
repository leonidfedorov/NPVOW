function[towa,away]=loadsubstat(subname)
close all;
%subname = '';

%load('female_exp\away\exp_0.3927_fe_aw_fr4.mat');
dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp1\';
te = load(strcat(dname,subname,'_resp136.mat'));

resp = te.('resp');

toidx = find(resp(:,2)==1);
awidx = find(resp(:,2)==0);

toAll = resp(toidx,3);
awAll = resp(awidx,3);

towa = [resp(18:34,1:2),vec2mat(toAll,numel(toidx)/17)];
away = [resp(1:17,1:2),vec2mat(awAll,numel(awidx)/17)];


return;