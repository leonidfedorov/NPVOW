function [retval]=maskbygaitvariation(folder)
%maskbygaitvariation(patternpath) take shading pathway outputs present in
%               the given folder and compute the overall temporall variation per receptive
%               field. Return a bitmask of those receptive fields that passed the
%               threshold.
%
%               Version 0.9, 03 Aug 2015 by Leonid Fedorov.
%
%
%               Tested with MATLAB 8.4 on a Xeon E5 under Windows 7 64-bit
%
%

narginchk(1,1)

path_train = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\walker\test\joris\';

d = dir(folder);
isub = [d(:).isdir]; %# returns logical vector
folderList = {d(isub).name}';
folderList(ismember(folderList,{'.','..'})) = [];


respList = inf(numel(folderList),30,9,9,8);

for i = 1:numel(folderList),
    loaded = loadv1response(fullfile(folder,char(folderList(i))));
    respList(i,:,:,:,:) = loaded(1:30,:,:,:);
end


allResponses = reshape(respList,[5*30,9*9,8]);
sizeAll = size(allResponses);

d_all = inf(sizeAll(1),sizeAll(2));

ev = unityroots(sizeAll(3));%gives a vector of complex roots of unity
for i = 1:sizeAll(2),
    for t = 1:sizeAll(1),
        d_all(t,i) = ev*squeeze(allResponses(t,i,:)); %inner product of receptive field output at a given time with the unity vector
    end
end

FLTCMP=0.00000000001;
d_sum = sum(d_all)/sizeAll(1);%mean receptive field(distance) across time
figure; plot(d_sum,'.');%plot all mean rf distances
figure; plot(d_all,'.');%plot all distances together
d_all_backup = d_all;
for i = 1:sizeAll(2),%center the rf distances around the mean
    for t = 1:sizeAll(1),
        d_all(t,i) = (d_all(t,i)-d_sum(i))/sizeAll(1);
        d_all(t,i) = d_all(t,i)/(d_sum(i)+FLTCMP);
    end
end

figure; plot(d_all_backup-d_all,'o');%plot the difference between centered and uncentered rf distances
figure; plot(d_all,'.');
d_all = abs(d_all); %take absolute of complex vector
figure;imagesc(10*abs(d_all)');%see all activities
d_max = max(d_all,[],1); %select max over time per cell  

threshold = 1.0*mean(d_max);
figure; 
subplot(2,2,1); 
plot([1:81],d_max) ; hold on; plot([1:81],threshold,'r:'); hold off;%see selection as a plot
subplot(2,2,2); imagesc(reshape(d_max,[9 9])) %see selection as a grid

%threshold by the mean
idx = d_max>threshold; %have mask for what's above double mean
subplot(2,2,3); plot([1:nnz(idx)],d_max(idx))%see what's above threshold as a plot
d_max(~idx) = 0; %set what's below threshold to zero
subplot(2,2,4); imagesc(reshape(d_max,[9 9])) %see what's above mean as a grid
nnz(d_max) %check number of cells that passed the threshold

d_all(:,~idx) = 0; %set responses of cells that didn't pass the threshold to zero
%plot variance of absolutes across time
figure;
idgrid = reshape(1:sizeAll(2),9,[])';%create transposed indices for subplot
idgrid = idgrid(:);
for i = 1:sizeAll(2),
   % display(i)
    %tmp=squeeze(resp_aa(:,i,:));
    %subplot(respSize(2),respSize(3),idgrid(i));
    subaxis(9,9,idgrid(i),'Spacing',0,'Margin',0,'Padding',0); 
    plot(d_all(:,i));
end


%%save only what's under the thresholded mask
%resp_train = resp_both(1:3:60,:,:); %save every third frame only
resp_train = allResponses;
resp_train(:,~idx,:) = [];

output.mask = idx;
output.data = resp_train;
save(strcat(path_train,'output_fulljoris','.mat'), 'output');




display (1);
        






return