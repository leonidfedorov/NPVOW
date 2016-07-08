function [section, leftCount, rightCount] = poincareSection(fieldfile, echo)

close all;
te = load(fieldfile);
activity = te.('fieldsim').('UST');
clear te;

for ind = 2:50:36000,
    section((ind - mod(ind, 50)) / 50 + 1, :) = [activity(1, 1:25, ind), activity(26, 26:50, ind)];
end


map(:, :, :) = activity(:, :, 2:50:36000);

ptCount = Inf(size(section, 1), 2);
leftCount = [0];
rightCount = [0];

for i = 2:size(section,1),
    if and(max(section(i, 1:25) >= 0.1), max(section(i, 26:50) < 0.1)),
        ptCount(i, 1) = 1;
        if ptCount(i - 1, 1) == Inf,
            leftCount = [leftCount 1];
        else
            leftCount(end) = leftCount(end) + 1;
        end
    elseif and(max(section(i, 1:25) < 0.1), max(section(i, 26:50) >= 0.1)),
        ptCount(i, 2) = 1;
        if ptCount(i - 1, 2) == Inf,
            rightCount = [rightCount 1];
        else
            rightCount(end) = rightCount(end) + 1;        
        end
    else
        ptCount(i, :) = [1 1];
    end
end


if echo == 1,
    figure;
    subplot(2, 3, 1);
    surf(mean(map, 3)); title('Mean of Poincare Section');
    
    subplot(2, 3, 2); waterfall(section); view([-40 30]); title({'Spatial Section of Poincare Section'; 'at the supposed maximum position.'})
    subplot(2, 3, 3); waterfall(section); view([-60 90]); title('Same as left; -60, 90 view')


    subplot(2, 3, 4); 
    errorbar(mean(section, 1), std(section, 1)); title('Mean and Standard Error of iterations, matches the input distribution.')

    subplot(2, 3, 5);
    for i = 1:720, plot(section(i, :)); hold on; end
    title('Iterations plotted on top of each other.')

    subplot(2, 3, 6)
    qqplot([leftCount, rightCount], makedist( 'logistic'));    

    figure;
    te = [leftCount, rightCount];
    histfit(te, 30, 'gamma')
end





return