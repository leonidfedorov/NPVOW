function [armArray] = readArmData(pathkey)
% readArmData(pathkey)
%          Takes the pathkey and parses the arm data file. Returns an Nx15
%          array where N is the number of recorded time points and each row
%          is a list of coordinate triples of 5 points in R^3. The routine
%          makes use of external csv reader:
%          https://www.mathworks.com/matlabcentral/fileexchange/23573-csvimport
%
%                Version 0.8,  21 January 2016 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7

te = csvimport(WalkerPath.getPath(pathkey), 'delimiter', ';');
te = te(1 : 11, :)  = []

