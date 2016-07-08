function success = poincareAnalyseFolder(folder, suffix)

if isstr(suffix),

    simlist = dir(fullfile(folder,strcat('*_', suffix,'.mat')));


    for simind = 1:numel(simlist),
        tic
	
        file = simlist(simind);

	%if exist(fullfile(folder, getFieldFilename(file.name, 'fieldsec2')), 'file') ~=2,
		simfilename = fullfile(folder,file.name)
	
		[section, leftCount, rightCount] = poincareSection(simfilename, 0);
		fieldsec.leftCount = leftCount;
		fieldsec.rightCount = rightCount;
		fieldsec.section = section;

		toc

		display('Left half Mean:');
		display(mean(leftCount) * 0.04 * 50);
	
		display('Right half Mean:')
		display(mean(rightCount) * 0.04 * 50);


		secfilename = fullfile(folder, strcat(file.name, '_fieldsec2.mat'));

        	save(secfilename, 'fieldsec', '-v7.3');
		display('Saved section activity.');


        	toc
	%end
    end
end