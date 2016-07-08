function [statsarr] = searchSection(folder, m1min, m1max, m2min, m2max, shapeX, shapeY)


shape = [shapeX shapeY];

%this will convert number of periods into seconds.
%for example, 1 discretization unit is 0.04 seconds
% and there are 50 discretization units in one period
UNITCONV = 0.04*50; 


simlist = dir(fullfile(folder,'*_fieldsec2.mat'));

means = inf(numel(simlist), 1);
stds = inf(numel(simlist), 1);
adaptation = inf(numel(simlist), 1);
noise = inf(numel(simlist), 1);

for simind = 1:numel(simlist),


    fname = fullfile(folder,simlist(simind).name)
    
    
    noslash = strsplit(fname, '\');
    last = noslash{end};
    nouds = strsplit(last, '_');
    adaptation(simind) = str2num(nouds{1});
    noise(simind) = str2num(nouds{2});
    clear last, nouds, noslash;
    
    te = load(fname);
    times = [te.fieldsec.leftCount,te.fieldsec.rightCount] * UNITCONV;
    means(simind) = mean(times);
    stds(simind) = std(times);
    clear te


end


msel = reshape(means, shape);
ssel = reshape(stds, shape);

msel = (msel > m1min).*(msel < m1max);
ssel = (ssel > m1min).*(ssel < m2max);

selection = msel.*ssel;

nret = noise(find(reshape(noise, shape) .* selection));
aret = adaptation(find(reshape(adaptation, shape) .* selection));

statsarr = [nret', aret']


return