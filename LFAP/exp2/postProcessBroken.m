function [fname] = postProcessBroken(path)

path = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\';

% % % % te1 = load(strcat(path, 'bjoernh\BH_resp641.mat'));
% % % % resp1 = te1.('resp');
% % % % resp1 = resp1(resp1(:,5)>1 & resp1(:,5)<18,:);
% % % % resp1(:,5) = resp1(:,5) - 1;
% % % % 
% % % % te2 = load(strcat(path, 'bjoernh\BH2_resp144.mat'));
% % % % resp2 = te2.('resp');
% % % % resp2 = resp2(resp2(:,5)<inf,:);
% % % % resp2(:,5) = resp2(:,5) + 16;
% % % % 
% % % % resp = cat(1,resp1,resp2);
% % % % 
% % % % [x,y] = size(resp)
% % % % 
% % % % save(strcat(path,'bjoernh\bjoernh_resp',num2str(x),'.mat'),'resp');
% % % % 
% % % % 
% % % % %%%%%%%%
% % % % path = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\';
% % % % 
% % % % te1 = load(strcat(path, 'erwinj\EJ_resp633.mat'));
% % % % resp1 = te1.('resp');
% % % % resp1 = resp1(resp1(:,5)>1 & resp1(:,5)<18,:);
% % % % resp1(:,5) = resp1(:,5) - 1;
% % % % 
% % % % te2 = load(strcat(path, 'erwinj\EJ2_resp144.mat'));
% % % % resp2 = te2.('resp');
% % % % resp2 = resp2(resp2(:,5)<inf,:);
% % % % resp2(:,5) = resp2(:,5) + 16;
% % % % 
% % % % resp = cat(1,resp1,resp2);
% % % % 
% % % % [x,y] = size(resp)
% % % % 
% % % % save(strcat(path,'erwinj\erwinj_resp',num2str(x),'.mat'),'resp');
% % % % 
% % % % 
% % % % %%%%%%%%
% % % % path = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\';
% % % % 
% % % % te1 = load(strcat(path, 'mariak\MariaKlebanova_resp72.mat'));
% % % % resp1 = te1.('resp');
% % % % resp1 = resp1(resp1(:,5)==2,:);
% % % % resp1(:,5) = resp1(:,5) - 1;
% % % % 
% % % % te2 = load(strcat(path, 'mariak\InaPetrovna_resp174.mat'));
% % % % resp2 = te2.('resp');
% % % % resp2 = resp2(resp2(:,5)<5,:);
% % % % resp2(:,5) = resp2(:,5) + 1;
% % % % 
% % % % te3 = load(strcat(path, 'mariak\Maria2_resp540.mat'));
% % % % resp3 = te3.('resp');
% % % % resp3 = resp3(resp3(:,5)<16,:);
% % % % resp3(:,5) = resp3(:,5) + 5;
% % % % 
% % % % 
% % % % resp = cat(1,resp1,resp2,resp3);
% % % % 
% % % % [x,y] = size(resp)
% % % % 
% % % % save(strcat(path,'mariak\mariak_resp',num2str(x),'.mat'),'resp');


% % % % %%%%%%%%
% % % % path = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\';
% % % % 
% % % % te1 = load(strcat(path, 'verenat\VT_resp274.mat'));
% % % % resp1 = te1.('resp');
% % % % resp1 = resp1(resp1(:,5)>1 & resp1(:,5)<8,:);
% % % % resp1(:,5) = resp1(:,5) - 1;
% % % % 
% % % % te2 = load(strcat(path, 'verenat\VT_resp473.mat'));
% % % % resp2 = te2.('resp');
% % % % resp2 = resp2(resp2(:,5)<14,:);
% % % % resp2(:,5) = resp2(:,5) + 6;
% % % % 
% % % % te3 = load(strcat(path, 'verenat\VT2_resp366.mat'));
% % % % resp3 = te3.('resp');
% % % % resp3 = resp3(resp3(:,5)<2,:);
% % % % resp3(:,5) = resp3(:,5) + 19;
% % % % 
% % % % 
% % % % resp = cat(1,resp1,resp2,resp3);
% % % % 
% % % % [x,y] = size(resp)
% % % % 
% % % % save(strcat(path,'verenat\verenat_resp',num2str(x),'.mat'),'resp');


% % % % %%%%%%%%
% % % % path = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\';
% % % % 
% % % % te1 = load(strcat(path, 'hanness\hs_resp648.mat'));
% % % % resp1 = te1.('resp');
% % % % resp1 = resp1(resp1(:,5)>1 & resp1(:,5)<19,:);
% % % % resp1(:,5) = resp1(:,5) - 1;
% % % % 
% % % % te2 = load(strcat(path, 'hanness\hs2_resp108.mat'));
% % % % resp2 = te2.('resp');
% % % % resp2 = resp2(resp2(:,5)<inf,:);
% % % % resp2(:,5) = resp2(:,5) + 17;
% % % % 
% % % % resp = cat(1,resp1,resp2);
% % % % 
% % % % [x,y] = size(resp)
% % % % 
% % % % save(strcat(path,'hanness\hanness_resp',num2str(x),'.mat'),'resp');


%%%%%%%%
path = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\';

te1 = load(strcat(path, 'hanness\hs_resp648.mat'));
te1 = load(strcat(path, 'ahmetd\AD_resp181.mat'));
resp1 = te1.('resp');
resp1 = resp1(resp1(:,5)>1 & resp1(:,5)<6,:);
resp1(:,5) = resp1(:,5) - 1;

te2 = load(strcat(path, 'ahmetd\AD2_resp648.mat'));
resp2 = te2.('resp');
%AhmetD was recorded in clean 4 + clean 18 rounds, so we only take first
%clean 4 in lines above, and then the next clean 16 ONLY, dropping the last 2 in the line below
resp2 = resp2(resp2(:,5)<17,:);
resp2(:,5) = resp2(:,5) + 4;

resp = cat(1,resp1,resp2);

[x,y] = size(resp)

save(strcat(path,'ahmetd\ahmetd_resp',num2str(x),'.mat'),'resp');



end