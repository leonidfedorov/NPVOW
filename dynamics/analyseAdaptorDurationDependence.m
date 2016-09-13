function success = analyseAdaptorDurationDependence(folder)%, suffix)


folder = 'C:\Users\leonidf\Desktop\adaptor_duration\isi_0';

simlist = dir(fullfile(folder,'*.mat'));

durationvec = 2:2:30;
resp = Inf(3, numel(durationvec), 10);
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
    questions = [100, 200, 300, 400];
    for i = 1 : numel(questions);
        if gright(questions(i)) >= 9 && gleft(questions(i)) <= 8,
            resp(i, find(durationvec == duration), repetition) = 1;
        elseif gright(questions(i)) <= 8 && gleft(questions(i)) >= 9,
            resp(i, find(durationvec == duration), repetition) = 0;
        end
    end
end

