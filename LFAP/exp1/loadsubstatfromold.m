function[towa,away]=loadsubstatfromold(subnum)
close all;

%load('female_exp\away\exp_0.3927_fe_aw_fr4.mat');
tr1 = load(strcat('sub',num2str(subnum),'res1.mat'));
tr2 = load(strcat('sub',num2str(subnum),'res2.mat'));
tr3 = load(strcat('sub',num2str(subnum),'res3.mat'));
tr4 = load(strcat('sub',num2str(subnum),'res4.mat'));

res1 = tr1.(strcat('sub',num2str(subnum),'res1'));
to1 = res1(2:2:34,:);
aw1 = res1(1:2:34,:);

res2 = tr2.(strcat('sub',num2str(subnum),'res2'));
to2 = res2(2:2:34,:);
aw2 = res2(1:2:34,:);

res3 = tr3.(strcat('sub',num2str(subnum),'res3'));
to3 = res3(2:2:34,:);
aw3 = res3(1:2:34,:);

res4 = tr4.(strcat('sub',num2str(subnum),'res4'));
to4 = res4(2:2:34,:);
aw4 = res4(1:2:34,:);

towa = [to1,to2(:,3),to3(:,3),to4(:,3)];
away = [aw1,aw2(:,3),aw3(:,3),aw4(:,3)];

return;