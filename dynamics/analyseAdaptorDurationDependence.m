function success = analyseAdaptorDurationDependence(folder)%, suffix)

close all; clear all;

isi = 2;%:1:2;
durationvec = 2:2:30;
questions = 50:50:400;
repetitions = 20;



for isi_index = 1:numel(isi),
    questions = 50*isi(isi_index) + [50:50:300];
    folder = strcat('C:\Users\leonidf\Desktop\adaptor_duration\isi_',num2str(isi(isi_index)));
    simlist = dir(fullfile(folder,'*.mat'));

    
    resp = Inf(numel(questions), numel(durationvec), 20);
    for simind = 1:numel(simlist),


        fileparts = strsplit(simlist(simind).name,'_');
        duration = str2num(fileparts{1}); 
        repetition = str2num(fileparts{2});

        load(fullfile(folder, simlist(simind).name));
        rightmax = max(squeeze(max(fieldsim.test_activity(:,26:50,:),[],1)),[],1);
        leftmax =  max(squeeze(max(fieldsim.test_activity(:,1:25,:),[],1)),[],1);

        gright = filter(gausswin(30), 1, rightmax);
        gleft = filter(gausswin(30), 1, leftmax);
        plot([gright; gleft]')

        %adaptor is on the right
        for i = 1 : numel(questions);
            if gright(questions(i)) >= 9 && gleft(questions(i)) <= 8,
                resp(i, find(durationvec == duration), repetition) = 1;
            elseif gright(questions(i)) <= 8 && gleft(questions(i)) >= 9,
                resp(i, find(durationvec == duration), repetition) = 0;
            else
                resp(i, find(durationvec == duration), repetition) = 0.5;
            end
        end
    end
    
    te = mean(resp,3);
%     questions(2:6)
%     bar(mean(te(2:6,:)))
    questions(3) - 50*isi(isi_index)
    durationvec(1:2:end-3)
    bar(te(3, 1:2:end-3))
    ylim([0 1])
    grid on
    ax = gca;
    ax.GridLineStyle = '--';
    ax.LineWidth = 3;
%     hold on;
end
display(1)

return
