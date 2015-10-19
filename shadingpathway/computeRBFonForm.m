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
patternMap = cellfun(@(x) reshape(x, [size(x,1)*size(x,2)*size(x,3), size(x,4)]), v4list,'UniformOutput', false); 

FLTCMP=0.00000000001;




return