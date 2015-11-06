function [ output_args ] = generateParts( )
% generateParts();
%          Generates videos of single walker part for each part, where a
%          walker is walking in 45, 315 directions.
%
%                Version 1.0,  06 November 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
output= []
partcolor = inf(1, 10);
partdisplay = inf(1,11);
partprefices = {'lua','rua','lul','rul','lll','rll','lla','rla','lb','ub','h'};
partarray = eye(11);

for ind = 1 : numel(partprefices),
    partdisplay = partarray(:, ind)
    prefix = partprefices{find(partdisplay)};
    generateWalker(16*pi/16, 315, [0.0 0.0 0.0], [900 900], strcat(prefix, '45' ), partcolor, partdisplay, [0 0])
    generateWalker(16*pi/16, 225, [0.0 0.0 0.0], [900 900], strcat(prefix, '315'), partcolor, partdisplay, [0 0])
end


return