function [section] = poincareSection(fieldfile)

% close all;
te = load(fieldfile);
activity = te.('fieldsim').('UST');
clear te;

% figure; 
% subplot(1, 4, 1); %surf(activity(1:50, 1:50, 20063)); 





for ind = 2:50:36000
    section((ind - mod(ind,50))/50 + 1, :) = [activity(1, 1:25, ind), activity(26, 26:50, ind)];
end

figure;
map(:,:,:) = activity(:,:,2:50:36000);
surf(mean(map, 3));

figure;
subplot(1, 4, 1); waterfall(section); view([-40 30]); title({'Iteration of neural activity with time period coinciding'; 'with the input period; -40, 30 view'})
subplot(1, 4, 2); waterfall(section); view([-20 65]); title('Same as left; -20, 65 view')


subplot(1, 4, 3); 
plot(mean(section,1)); title('Mean of iterations, matches the input distribution.')

subplot(1, 4, 4);
for i = 1:720, plot(section(i, :)); hold on; end
title('Iterations plotted on top of each other.')

% section = 0;

return
