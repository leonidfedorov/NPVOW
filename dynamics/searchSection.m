function success = searchSection(folder)



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
    times = [te.fieldsec.leftCount,te.fieldsec.rightCount]*0.04*50;
    means(simind) = mean(times);
    stds(simind) = std(times);
    clear te


end


msel = reshape(means,[13 10]);
ssel = reshape(stds, [13 10]);

msel = (msel>16.8).*(msel<20.8);
ssel = (ssel>8.3).*(ssel<16.3);

selection = msel.*ssel;

noise(find(reshape(noise,[13 10]) .* selection))
adaptation(find(reshape(adaptation,[13 10]) .* selection))


success = 1;

return