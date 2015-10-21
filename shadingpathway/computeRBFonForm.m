function [patternMap] = computeRBFonForm(varargin)
% computeRBFonForm(varargin);
%          takes a list of pathkeys containing form pathway output and
%          returns snapshot neuron outputs based on it.
%
%                Version 0.9,  19 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%

% Don't hate me for this code. It's MATLAB cell arrays that suck.
resplist = cellfun(@loadFormResp, varargin); %loads a structure array of responses, where each response structure is derived from varargin
v4list = arrayfun(@(x) getfield(x, 'v4'),resplist, 'UniformOutput', false);% returns a cell array of original v4 response arrays
% Same cell array of v4 responses, but response to one image are reshaped from a 3-dim array to a 1-dim vector:
v4resp = cellfun(@(x) reshape(x, [size(x,1)*size(x,2)*size(x,3), size(x,4)]), v4list,'UniformOutput', false); 


D = cell2mat(v4resp)' * cell2mat(v4resp);
beta = 10.0/sqrt(sum(D(:)/size(D,1)^2));%1.0%40

FLTCMP=0.00000000001;

r11 = computeRBFvalues(beta, v4resp{1}, v4resp{1}); figure; surf(r11);
r12 = computeRBFvalues(beta, v4resp{1}, v4resp{2}); figure; surf(r12);
r22 = computeRBFvalues(beta, v4resp{2}, v4resp{2}); figure; surf(r22);
r21 = computeRBFvalues(beta, v4resp{2}, v4resp{1}); figure; surf(r21);

% te = arrayfun(@(x) rbf_fn(beta,v4resp{1}', x), v4resp{1}', 'UniformOutput', false);
% 
% applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));
% 
% RBFrowdistrow = @(beta, matrix) @(col) rbf_fun(beta, matrix, matrix(:,col) )
% RBFrowdistmat = @(beta, matrix) arrayfun(RBFrowdistmat(beta, matrix) )
% 
% arrayfun(@(x) rbf_fn(beta,v4resp{1}, x), v4resp{1}(:,1), 'UniformOutput', false);
% arrayfun(@(x) rbf_fn(beta,v4resp{1}, x), v4resp{1}(:,2), 'UniformOutput', false);
% arrayfun(@(x) rbf_fn(beta,v4resp{1}, x), v4resp{1}(:,3), 'UniformOutput', false);
% 

rbfs = inf(size(v4resp{1}));
for ind = 1:size(v4resp{1},2),
    rbfs = rbf_fn(beta, v4resp{1}, v4resp{1}(:, ind));
end

for i=1:30,
    away_pattern(i,1:30) = rbf_fn(beta, away_out(1:30,:),away_out(i,:))';
    towa_pattern(i,1:30) = rbf_fn(beta_towa,towa_out(1:30,:),towa_out(i,:))';
    away_pattern_resp_towa(i,1:30) = rbf_fn(beta_away,away_out(1:30,:),towa_out(i,:))';
    towa_pattern_resp_away(i,1:30) = rbf_fn(beta_towa,towa_out(1:30,:),away_out(i,:))';
    
end


return