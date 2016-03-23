function success = runField(folder, adrange, nrange)

for ad = adrange,
    for noise = nrange,
        tic
        disp(sprintf('Will simulate for adaptation: %0.5f ; noise level: %0.5f', ad, noise));
        fieldsim.UST = travcomp_ad2(ad, noise);
	    fieldsim.adaptation = ad;
	    fieldsim.noise = noise;
        save(fullfile(folder, strcat(num2str(ad), '_', num2str(noise), '_fieldsim.mat')), 'fieldsim');
        display('Saved simulation result.');
        toc
    end
end
