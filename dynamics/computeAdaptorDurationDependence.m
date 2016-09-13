function success = computeAdaptorDurationDependance(folder, isi_cycles)%(folder, adrange, nrange)

    ad = 1.5;
    noise = 0.72;

    adaptor_durations = 2:2:30; %in cycles    
    
    reps = 60;
    max_test_cycles = 8;

    for repind = 1:reps,
        for adind = 1:numel(adaptor_durations)

            tic
            
            cycles = adaptor_durations(adind);
            [UST, SM] = travcomp_ad4(ad, noise, cycles, isi_cycles);
            double_peak_start = 50*cycles + 1
            double_peak_start + 50*max_test_cycles
            test_activity = UST(:, :, double_peak_start: double_peak_start + 50*max_test_cycles);
            
            
            fieldsim.test_activity = test_activity;
            %fieldsim.input = SM;
         	fieldsim.adaptation = ad;
            fieldsim.noise = noise;
            fieldsim.adsteps = cycles*50;
            fieldsim.isicycles = isi_cycles;
            
            save(fullfile(folder, strcat(num2str(cycles), '_', num2str(repind), '_fieldsim.mat')), 'fieldsim', '-v7.3')

            clear UST;
            clear SM;
            clear fieldsim;
            clear test_activity;
            
            toc
        end
    end
    
    success = 1;
    
return
