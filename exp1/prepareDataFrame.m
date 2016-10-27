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
            prev_ans = 2.718281828;
        end
        if resp(j,2) == 1,
            angle = rad2deg(resp(j,  1));
        elseif resp(j, 2) == 0,
            angle = 360 - rad2deg(resp(j,  1));
        end
        datarow = [i angle resp(j, 2:3) prev_ans];
        dataframe = cat(1, dataframe, datarow);
    end
end
filepath = fullfile(folder, 'exp1_data.csv');
csvwrite(filepath, dataframe);


return
