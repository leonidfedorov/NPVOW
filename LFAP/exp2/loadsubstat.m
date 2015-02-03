function[awayMeanAbove,awayMeanBelow,towaMeanAbove,towaMeanBelow]=loadsubstat(subname)
%close all;
%subname = '';



%load('female_exp\away\exp_0.3927_fe_aw_fr4.mat');
dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\';
te = load(strcat(dname,'results\BG0.8\', subname));

resp = te.('resp');

%cut first repetition of every movie for subjects where it is included in
%the data, because it is counted as a training trial
if size(resp, 1)==756,
    resp(1:36,:) = [];
end


%retrieve [lightangle, original direction, recognized direction, condition],
%and then sort by condition
awayComplete = sortrows(resp(resp(:,2)==0,[1:3,8]), 4);
towaComplete = sortrows(resp(resp(:,2)==1,[1:3,8]), 4);

%select lighting positions and original walking directions separately
%TODO: this would be the best use of a database, instead of this
%be very careful here: MATLAB is bad with equality of floats, so we use
%inequalities; lightangle 3.927 means AWAY/ABOVE, 5.4978 is AWAY/BELOW,
%0.7854 is TOWA/BELOW, 2.3562 is TOWA/ABOVE
awayCompleteAbove = awayComplete(awayComplete(:,1) < 3.9271,:);
awayCompleteBelow = awayComplete(awayComplete(:,1) > 5.4977,:);

towaCompleteAbove = towaComplete(towaComplete(:,1) > 2.3561,:);
towaCompleteBelow = towaComplete(towaComplete(:,1) < 0.7855,:);


%compute means when per averaging condition, when everything is selected
%TODO: select with a sparse bitmask istead of an array
%mask = ones(1,40)
awayMeanAbove = inf(9,1);
awayMeanBelow = inf(9,1);
towaMeanAbove = inf(9,1);
towaMeanBelow = inf(9,1);
for condind = 1:9,    
    awayMeanAbove(condind) = mean(awayCompleteAbove(20*(condind-1)+1:20*condind,3));
    awayMeanBelow(condind) = mean(awayCompleteBelow(20*(condind-1)+1:20*condind,3));
    towaMeanAbove(condind) = mean(towaCompleteAbove(20*(condind-1)+1:20*condind,3));
    towaMeanBelow(condind) = mean(towaCompleteBelow(20*(condind-1)+1:20*condind,3));
end

%shad = resp(~isinf(resp(:,1)),:);
%towaComplete = shad(shad(:,2)==1,:);
%awayComplete = shad(shad(:,2)==0,:);

%towa = [towaComplete(1:17,1:2),reshape(towaComplete(:,3),[17 size(towaComplete,1)/17])];
%away = [awayComplete(1:17,1:2),reshape(awayComplete(:,3),[17 size(awayComplete,1)/17])];


return