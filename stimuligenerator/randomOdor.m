function [stimulus] = randomOdor(minDuration, maxDuration, minLvl, maxLvl, totalDuration)

%   Given the minDuration and maxDuration in units of choise(e.g. seconds),
%   and the minLvl, maxLvl as the stimuli range, and limited totalDuration,
%   can generate the random stimuli with Umiformly sampled durations and
%   levels. One does NOT need to worry about the units in the script: just
%   give the parameters in any of your assumed units to the function.
%
%   for Anton Parinov by Leonid Fedorov, 05 Aug 16

%The random odor level task that you described is similar to the so-called 
%Compound Poisson Process, but there is a theoretical difference from what
%we do, and we don't really want to complicate the concepts at this point. 
%

%First, we need a certain number of random durations from the interval,
%[minDuration, maxDuration].
%So we simply generate a random vector of durations from this interval.
%
%However, in the real experiment we are also limited by a full stimulus
%duration and we want that to be fixed -- as totalDuration.
%
%That's the maximum number of intervals that we can have in any case is 
%totalDuration/minDuration.

duration = minDuration + (maxDuration - minDuration) * rand(floor(totalDuration / minDuration), 1);

%Here, the duration variable now contains a usable random vector in the
%desired range, but still the sum of durations might be bigger than the
%total.


sum(duration) %just to see that it can be large

%That's why we simply cut it until it matches the total duration.

sumDuration = 0; % we will use it to count the total duration
for ind = 1 : numel(duration),
    sumDuration = sumDuration + duration(ind);
    %if sumDuration is still smaller than totalDuration, we continue;
    %but as soon as its not, we
    if sumDuration >= totalDuration,
        
        %for the result we use all intervals counted to this point
        duration = [duration(1:ind - 1); ...
            %and from the last interval we cut the excessive tail
            duration(ind) - sumDuration + totalDuration];       
        
        break;
    end
end

sum(duration)% just to see that now its the same as total Duration.

%accordingly, we simply generate a bunch of random levels in the range.
%(we don't have a problem with the total sum of all levels though)
%the number of levels is the same as the number of duration intervals

levels = minLvl + (maxLvl - minLvl) * rand(numel(duration),1);

%Now we can generate the actual stimulus vector:

stimulus = [0]; %we start with zero just for convenience, it has no meaning

step = 0.001; %this is the "time resolution" of how precise will the intervals
%be generated. You can increase it WITHOUT any effect on the stimuli units,
%but decreasing it will give discretization artifacts!

for i = 1:size(duration, 1),
    %for every level, we simply add a bunch of numbers of that exact value
    %at the end of the vector. And the number of these numbers that we add
    %depends on the corresponding duration
    stimulus = [stimulus levels(i) * ones(1, floor(duration(i)/step))];%[stimulus stimulus(end) : 0.01 : stimulus(end) + duration(i)]

end

plot(stimulus) % optionally visualize the result

display(1) %just for debugging

return
