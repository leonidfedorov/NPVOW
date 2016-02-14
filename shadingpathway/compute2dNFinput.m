function [networkResp] = compute2dNFinput(pathkey)
% compute2dNFinput(pathkey);
%          takes a pathkey containing the snapshot neuron responses and
%          linearly maps it to the output, interpolating if neccesary.
%
%                Version 0.9,  26 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%

close all;

%%TODOTODO: GO HERE, LOAD PATHWAY OUTPUT AND REGRESS ONTO 50x50 FIELD INPUT

path_nf = 'C:\Users\leonidf\Documents\MATLAB\NPVOW\newNeurFs\';

% you have just 10 time moments of your D-dimensional examples:
T2=30; % number of your time points
D=60; % (for example) in your case D=10;
%X=ones(D,1)*[1:T2]/T2*10+randn(D,T2)/10; % your data
%figure; surf(X);

%%LOADING HIERARCHY OUTPUT HERE

respdata = load(fullfile(WalkerPath.getPath(pathkey),'networkResp.mat'));
nresp = respdata.networkResp.resp;
figure;


X_away = [nresp{1,1};nresp{2,1}];
X_away = level(X_away,0.6,1);

subplot(2,4,1);
surf(X_away);title(['315 population thresholded output ',respdata.networkResp.meta{1}])
view([-22 58]);% X_away = stim_away.thr_out_away;

X_towa = [nresp{1,2};nresp{2,2}];
X_towa = level(X_towa,0.6,1);
subplot(2,4,5);
surf(X_towa);title(['45 population thresholded output ',respdata.networkResp.meta{2}])
view([-22 58]);


% The problem is that we have to define the interpolation scheme
% for our 10 examples in time, since:
% we need inputs to NF at all 50 moments of time and the input strength
% integrated in time should be of the same overall strength as those in G. 
% An easiest but consistent way to do it, is to interpolate our data
% to the desired 50 moments of time before regression, e.g. by linear
% interpolation:
init_interv=[1:T2];
resl_interv=[0.6:0.6:(T2+0.4)]; % this has 5 times more points than init_interv
X2_away=zeros(D,5*T2/3); % 5*T2==T
X2_towa=zeros(D,5*T2/3);
for d=1:D,
     X2_away(d,:)=interp1(init_interv,X_away(d,:),resl_interv,'pchip','extrap');
     X2_towa(d,:)=interp1(init_interv,X_towa(d,:),resl_interv,'pchip','extrap');
end;
subplot(2,4,2);surf(X2_away);view([-22 58]);
title('[Away,below] interpolated');
subplot(2,4,6);surf(X2_towa);view([-22 58]);
title('[Towa,above] interpolated');

[mg, W_away,Y_away] = regress2FieldInput(X2_away);
[mg, W_towa,Y_towa] = regress2FieldInput(X2_towa);

% % % % % next, learn the mapping W from X2 onto G:
% % % % mx=sum(X2,2)/(5*T2); % mean value of input data
% % % % X2=X2-mx*ones(1,5*T2); % now X2 is zero-mean
% % % % mg=sum(G,2)/(T); % mean value of desired output
% % % % % estimate W in G=W*X2, as:
% % % % W=(G-mg*ones(1,T))*X2'*inv(X2*X2'+0.0001*eye(D));
% % % % % check
% % % % G2=W*X2+mg*ones(1,T); % in W-estim G was used as 0-mean above

subplot(2,4,3);surf(Y_away);view([-22 58]);
title({'[Away,above] lineraly mapped to idealized gaussians'});
subplot(2,4,7);surf(Y_towa);view([-22 58]);
title({'[Towa,above] lineraly mapped to idealized gaussians'});

save(strcat(path_nf,'Y_away','.mat'), 'Y_away');
save(strcat(path_nf,'Y_towa','.mat'), 'Y_towa');
%TODO: generalize for arbitrary number of patterns!!!!!


%TEST WITH BELOW LIGHTING
stim_away_below = load(strcat(path_nf,'thr_aa_to_below_full.mat'));
X_away_below = stim_away_below.thr_aa_to_below_full;
stim_towa_below = load(strcat(path_nf,'thr_ta_to_below_full.mat'));
X_towa_below = stim_towa_below.thr_ta_to_below_full;

figure;
subplot(2,4,1); surf(X_away_below);view([-22 58]);
subplot(2,4,5); surf(X_towa_below);view([-22 58]);

%interpolate below lighting responces too
X2_away_below=zeros(D,5*T2/3); % 5*T2==T
X2_towa_below=zeros(D,5*T2/3);
for d=1:D,
     X2_away_below(d,:)=interp1(init_interv,X_away_below(d,:),resl_interv,'pchip','extrap');
     X2_towa_below(d,:)=interp1(init_interv,X_towa_below(d,:),resl_interv,'pchip','extrap');
end;
subplot(2,4,2);surf(X2_away_below);view([-22 58]);
title('[Away,below] interpolated');
subplot(2,4,6);surf(X2_towa_below);view([-22 58]);
title('[Towa,below] interpolated');


%test learnt above lighting weights with below lighting responses
mx=sum(X2_away_below,2)/(5*10); % mean value of input data
X2_away_below=X2_away_below-mx*ones(1,5*10); % now X2_towa is zero-mean
Y_away_resp_below = (W_away)*X2_away_below+mg*ones(1,50); 

mx=sum(X2_towa_below,2)/(5*10); % mean value of input data
X2_towa_below=X2_towa_below-mx*ones(1,5*10); % now X2_towa is zero-mean
Y_towa_resp_below = (W_towa)*X2_towa_below+mg*ones(1,50); 


subplot(2,4,3); surf(Y_away_resp_below);view([-22 58]);
subplot(2,4,7); surf(Y_towa_resp_below);view([-22 58]);


save(strcat(path_nf,'Y_away_resp_below','.mat'), 'Y_away_resp_below');
save(strcat(path_nf,'Y_towa_resp_below','.mat'), 'Y_towa_resp_below');

