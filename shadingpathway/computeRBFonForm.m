function [networkResp] = computeRBFonForm(varargin)
% computeRBFonForm(varargin);
%          takes a list of pathkeys containing form pathway output. Returns
%          a cell array where cell at (i, j) contains the RBF network 
%          response of population centered at pattern j to the input 
%          pattern at i. The last argument is the si
%
%          Meta-example:
%          We can call computeRBFonForm('pathkey1', 'pathkey2','simkey')
%          
%          It'll retrieve V4 responses stored under 2 keys, e.g. r1 and r2.
%
%          Then it'll create two populations of RBF neurons corresponding 
%          to response patterns r1 and r2, where each neuron will be
%          centered on a single frame output, e.g. pop1 and pop2.
%          
%          Then calculate all possible responses of pop1 and pop2 to itself
%          and to each other. One response is one rectanguilar matrix.
%          
%          Then return a structure with a cell array of population of 
%          response combinations, and original pathkeys, e.g.
%          networkResp.resp = 
%          [pop1 to pop1] [pop2 to pop1]
%          [pop1 to pop2] [pop2 to pop2]
%          
%          networkResp.meta = ['pathkey1', 'pathkey2']
%          
%          It will save the return result under 'simkey'.
%
%                Version 1.0,  29 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%

% Don't hate me for this code. It's MATLAB cell arrays that suck.

stimulikeys = varargin(1:end-1)%cell array of stimuli keys
simpathkey = varargin{end}%contents of the last cell is a char key

%Load a structure array of responses, where each response structure is derived from varargin
resplist = cellfun(@loadFormResp, stimulikeys); 

%From each structure element get V4 responses as a cell array
v4list = arrayfun(@(x) getfield(x, 'v4'),resplist, 'UniformOutput', false);

% Reshape V4 responses, so 3d response array to each image is a 1d array
v4resp = cellfun(@(x) reshape(x, [size(x,1)*size(x,2)*size(x,3), size(x,4)]), v4list, 'UniformOutput', false);

% Estimate to beta parameter of the RBF function
D = cell2mat(v4resp)' * cell2mat(v4resp);
beta = 0.2/sqrt(sum(D(:)/size(D,1)^2));%1.0%40

% FLTCMP = 0.00000000001;


%Number of populations will equal the number of patterns
popnum = numel(v4resp); 

%This function will take a pair of indices as a single argument, and call 
%rbfOfColumns with predefined coefficient beta on two elements of v4resp
%that have these given indices.
rbfPatternResp = @(x) rbfOfColumns(beta, v4resp{ x(1) }, v4resp{ x(2) });

%supply pairs of indices to rbfPatternResp to call it on each pair
patternList = cellfun(rbfPatternResp, listPairs(1:popnum), 'UniformOutput', false);

%an element at index (i,j) is the response of population j to pattern i
networkResp.resp = reshape(patternList, [popnum popnum]);
networkResp.meta = stimulikeys; % we save pathkeys to know what paths were used for the network

simpath = WalkerPath.getPath(simpathkey);
if ~exist(simpath, 'dir'), mkdir(simpath); end
save(fullfile(simpath, strcat('networkResp','.mat')),'networkResp')
savepath = strrep(datestr(datetime('now')), ':', '-');
mkdir(simpath, savepath);
save(fullfile(simpath, savepath, strcat('networkResp', '.mat')), 'networkResp');

%TODO: think about rearranging the frames??


return
