function [res] = namevec(name, vector)
%accepts row vectors
    res = ['_',name, '-', strjoin(arrayfun(@(ind) num2str(vector(:, ind)), 1 : size(vector, 2),'UniformOutput', false),'-')];
return