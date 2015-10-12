function [response] = loadv1response(filename)
    data = load(fullfile(filename,'xdata.mat'));
    response = data.xdata;
return
