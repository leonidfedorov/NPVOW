function success = runField(folder, adrange, nrange)

for ad = adrange,
    for noise = nrange,
        tic
        disp(sprintf('Will simulate for adaptation: %0.5f ; noise level: %0.5f', ad, noise));
        display(noise)
        UST = travcomp_ad(adrange, nrange);
        save(fullfile(folder, strcat(ad, '_', noise, '_UST.mat')), 'UST');
        display('Saved simulation result.');
        toc
    end
end
