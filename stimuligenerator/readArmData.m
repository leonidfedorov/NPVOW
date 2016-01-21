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

%take a singleton cell with a German string representing a double and return an actual double
extractDouble = @(x) str2double(strrep(x{1}, ',', '.'));

%take a cell array and x,y coordinates of the upper-left corner of the
%sub-array which contains the data, and apply extractDouble to it
parseGermanCSV = @(arr, coords) arrayfun(extractDouble, arr(coords(1):end, coords(2):end));

%take a pathkey to the file and return an array of doubles as designed
armArray = parseGermanCSV(csvimport(WalkerPath.getPath(pathkey), 'delimiter', ';'), [12, 2]);
cd
return


