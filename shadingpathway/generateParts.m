function [ output_args ] = generateParts( type )
% generateParts();
%          Generates videos of single walker part for each part, where a
%          walker is walking in 45, 315 directions.
%
%                Version 1.0,  06 November 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
output= []
%partcolor = inf(1, 10);%normal color
partdisplay = inf(1,11);
partprefices = {'lua','rua','lul','rul','lll','rll','lla','rla','lb','ub','h'};
partarray = eye(11);

dirdict = containers.Map; %a dictionary in MATLAB

if strcmp(type, 'LFAP-exp2-sim')
    dirdict('90') = 180;
    dirdict('270') = 0;
    partcolor = inf(1, 10); 
    bgcolor = [0.8 0.8 0.8];
elseif strcmp(type, 'joris-parts_on_bw')
    dirdict('45') = 315;
    dirdict('315') = 225;
    partcolor = ones(1, 10)*1.0;%while color
    bgcolor = [0.0 0.0 0.0];
end

directions = dirdict.values();
names = dirdict.keys();

for ind = 1 : numel(partprefices),
    partdisplay = partarray(:, ind)
    prefix = partprefices{find(partdisplay)};
   % generateWalker(16*pi/16, 315, [0.0 0.0 0.0], [900 900], strcat(prefix, '45' ), partcolor, partdisplay, [0 0])
   % generateWalker(16*pi/16, 225, [0.0 0.0 0.0], [900 900], strcat(prefix, '315'), partcolor, partdisplay, [0 0])
    
    generateWalker(17*pi/16, directions{1}, bgcolor, [900 900], strcat(prefix, names{1}), partcolor, partdisplay, [0 0])
    generateWalker(15*pi/16, directions{2}, bgcolor, [900 900], strcat(prefix, names{2}), partcolor, partdisplay, [0 0])
end

partdisplay = [0 0 0 0 0 0 1 1 0 0 0];
generateWalker(17*pi/16, directions{1}, bgcolor, [900 900], strcat(names{1},'arms'), partcolor, partdisplay, [0 0])
generateWalker(15*pi/16, directions{2}, bgcolor, [900 900], strcat(names{2},'arms'), partcolor, partdisplay, [0 0])


partdisplay = [0 0 1 1 0 0 0 0 0 0 0];
generateWalker(17*pi/16, directions{1}, bgcolor, [900 900], strcat(names{1},'thighs'), partcolor, partdisplay, [0 0])
generateWalker(15*pi/16, directions{2}, bgcolor, [900 900], strcat(names{2},'thighs'), partcolor, partdisplay, [0 0])

partdisplay = [0 0 0 0 1 1 0 0 0 0 0];
generateWalker(17*pi/16, directions{1}, bgcolor, [900 900], strcat(names{1},'legs'), partcolor, partdisplay, [0 0])
generateWalker(15*pi/16, directions{2}, bgcolor, [900 900], strcat(names{2},'legs'), partcolor, partdisplay, [0 0])


return


















