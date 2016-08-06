function [percount] = permutationExperiment(a, b, N, ratio)
%this experiment checks how many permutations are needed for a random
%Gaussian vector with [-3std, 3std] equal to [a, b] and length N to
%fullfill a "Saliency" condition.
%The "Saliency" conditions is that all consecutive pairs of elements in the 
%vector have a difference betweem them larger than epsilon. We parametrize 
%epsilon as a ratio of the given range.

m = (a + b) / 2; %mean of the Gaussian
d = (b - m) / 3; %standard deviation of the Gaussian



%we will want the difference between two consecutive numbers
%to be smaller than ration of the full range(e.g. 2% is ratio = 0.02)
epsilon = ratio * abs(a-b);

%we will run the experiment M
M = 10000;

percount = Inf(1, M); %this vector will contain the number of permutations 
%required in each experimental trial

pertime = Inf(1, M); % we will also compute the arithmetic average permutation time
%and display it - although this depends on hardware and the number of
%permutations is a better characteristic
for i = 1 : M,
    
    %generate a Gaussian random vector of length N
    vector = m + d .* randn(N, 1);

    percount(i) = 0;
    %here we will check our condition and do random permutations
    tic;
    for j = 1 : 1000000, %the number is arbitrary here - just a large number
        %check if there are any consecutive elements with difference
        %between each other smaller than epsilon
        if nnz(abs(diff(vector)) < epsilon) > 0, 
            %if there are, then we randomly permute the original vector
            vector = vector(randperm(numel(vector)));
            %and count that we did a permutation
            percount(i) = percount(i) + 1;
        else
            %if we reach the desired state then we quit
            break;
        end
    end
    pertime(i) = toc;
end

%We have performed the experiment M times and counted the
%number of permutations of a Gaussian random vector that was required to 
%satisfy the condition. The condition was that a random vector doesn't have
%two consecutive elements closer to each other than epsilon.
%Now visualize the number of permutations required by plotting a histogram.
%It is likely to be an exponential distribution, so we plot it over.
histfit(percount, floor(M/100), 'exponential');

%Similarly we visualize the time, although it should obviosly follows the 
%almost the same distribution, just in different units.
figure; histfit(pertime, floor(M/100), 'exponential');


return
