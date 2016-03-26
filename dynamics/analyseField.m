function success = analyseField(folder, suffix)

if isstr(suffix),

    simlist = dir(fullfile(folder,strcat('*_', suffix,'.mat')));

    for simind = 1:numel(simlist),
        file = simlist(simind);
        tic
        disp(sprintf('Will load field activity from: %s ; sized %0.5f Mb', file.name, file.bytes/(1024^2)));
        sim = load(fullfile(folder,file.name));

        display('Loaded field activity, will analyze percept times.');
        toc

        fieldact.ptimes = actanal2(sim.(suffix).('UST'));
        fieldact.adaptation = sim.(suffix).('adaptation');
        fieldact.noise = sim.(suffix).('noise');

        save(fullfile(folder, strcat(num2str(fieldact.adaptation), '_', num2str(fieldact.noise), '_fieldact.mat')), 'fieldact');

        display('Saved percept times.');
        toc
    end

    success = 1;

else 
    success = 0;
end

return
