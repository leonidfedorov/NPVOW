function [success] = simulateHysteresis_exp1(folder)%, suffix)

close all; clear all;
addpath('C:\Users\leonidf\Documents\MATLAB\NPVOW\external\intersections');


numbetas = 29;
numsamples = 100;

switchtimes = [];

for kk = 1 : numsamples,
    l = [];
    r = [];

%     figure;
%     plotind = 0;
    
    for beta1 = linspace(0, 1, numbetas),  
        tic
%         plotind = plotind + 1;
        [UST, SM] = travcomp_ad4(2, 0.6, 0, 1, beta1);
        rightmax = max(squeeze(max(UST(:, 26 : 50, :), [], 1)), [], 1);
        leftmax =  max(squeeze(max(UST(:, 1 : 25, :), [], 1)), [], 1);

        l = [l; leftmax];
        r = [r; rightmax];


%         subplot(3, 5, plotind); 
%         plot(leftmax, 'r'); hold on;
%         plot(rightmax, 'b');
%         xlim([-10 size(SM, 3) + 10])
%         ylim([-2.5 2.5])
        toc
    end
%     figure;
%     plotind = 0;
    gl = [];
    gr = [];
    switchesX = [];
    switchesY = [];
    for i = 1 : numbetas,
%         plotind = plotind + 1;
        gleft = filter(gausswin(30), 1, l(i, :));
        gright = filter(gausswin(30), 1, r(i,:));
        gl = [gl; gleft];
        gr = [gr; gright];    

%         subplot(3, 5, plotind);
%         plot(gleft, 'r'); hold on;
%         plot(gright, 'b');


        [X0, Y0] = intersections(1 : size(SM, 3), gl(i, :), 1 : size(SM, 3), gr(i, :));
        if numel(X0) ~= 0,
            switchesX = [switchesX, [X0; zeros(size(SM, 3) - numel(X0), 1)]]; 
            switchesY = [switchesY, [Y0; zeros(size(SM, 3) - numel(X0), 1)]]; 
        else
            switchesX = [switchesX, zeros(size(SM, 3), 1)]; 
            switchesY = [switchesY, zeros(size(SM, 3), 1)]; 
        end
%         plot(X0, Y0, 'gx', 'MarkerSize', 15.0)
%         xlim([-10 size(SM, 3) + 10])
%         ylim([-31 25])
    end

%     figure; imagesc(switchesX(1 : 60, :)')
    firstswitchtimes = [];
    for j = 1 : size(switchesX, 2)
        firstXtemplist = switchesX(find(switchesX(:, j)> 50), j);
        if numel(firstXtemplist) ~= 0,
            stableperceptind = find(diff(firstXtemplist) > 10);
            if numel(stableperceptind) ~= 0
                firstX = firstXtemplist(stableperceptind(1));
            else
                firstX = firstXtemplist(1);
            end
        else
            firstX = size(SM, 3);
        end
        firstswitchtimes = [firstswitchtimes; firstX];
    end

%     figure; plot(firstswitchtimes);
    
    switchtimes = [switchtimes, firstswitchtimes]

end
plot(linspace(0, 1, numbetas), mean(switchtimes/50,2), 'Marker', '.','MarkerSize', 15.0, 'LineWidth', 2.0, 'Color', 'black');
title('Model simulation of Experiment 1')
grid on;
xlim([-0.01 1.01]);
ylim([0, 61]);
set(gca, 'Color', [0.85 0.85 0.85], 'FontSize', 12.0)
xlabel('Hysteresys parameter (0 is favoring AWAY)', 'FontSize', 13.0)
ylabel('Time of first switch [s]', 'FontSize',13.0)
success = 1;

return
