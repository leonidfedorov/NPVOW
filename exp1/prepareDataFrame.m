function [filepath] = prepareDataFrame(folder)

reslist = dir(fullfile(folder, '*.mat'));

dataframe = [];
% angles = 0 : 11.25 : 180;
for i = 1:numel(reslist),
    te = load(fullfile(folder,reslist(i).name));
    resp = te.('resp');
    if size(resp, 1) == 576,
        resp(1:36, :) = [];
    end
%     shad = resp( ~isinf(resp(:, 1)), :);


    for j = 1 : size(resp, 1), %run through all rows
        ans_num = resp(j, 6); %read out the trial # of the current answer
        %read out the answer to the previous trial #
        prev_ans = resp( max( find(resp(:, 6) < ans_num)), 3);
        
        if numel(prev_ans) == 0,
            prev_ans = 2;
        end
        if resp(j,2) == 1,
            angle = resp(j,  1);
        elseif resp(j, 2) == 0,
            angle = 2*pi - resp(j,  1);
        end
        datarow = [i angle resp(j, 2:3) prev_ans];
        dataframe = cat(1, dataframe, datarow);
    end
end
%previously the walking direction response were encoded as 0 if its away
%and 1 if its towards;
%below we re-encode the responses as 1 if the walking direction is veridical,
%and as 0 if its not
counter = 0;
for k = 1 : size(dataframe,1),
    if dataframe(k, 3) == 0, % if the walking direction was away
        dataframe(k, 4) = 1 - dataframe(k, 4); %flip the bit in the original response
        if dataframe(k, 5) == 2, %if the previous response was empty just count how many times we encounter that to double-check
            counter = 1 + counter; 
        else %if the previous response was not empty, flip the bit too
            dataframe(k, 5) = 1 - dataframe(k, 5);
        end
    end
end
% counter
filepath = fullfile(folder, 'exp1_data.csv');
csvwrite(filepath, dataframe);


return
