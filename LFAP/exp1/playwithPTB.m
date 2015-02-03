function [answer, time]=playwithPTB(filename)%, windowpointer)

%close all
%clear all
% clc

subjname = '_'; 
respnumber = 0;
eflag1 = 0;
eflag2 = 0;

subjname = input('Please insert the initials (of first and last names) of the participants: ', 's');
while isempty(subjname)
    subjname = input('Please insert the initials (of first and last names) of the participants: ', 's');
end
subjname = strcat(subjname,'_');

AssertOpenGL;
Screen('Preference', 'SkipSyncTests', 1) 
Screen('Preference', 'Verbosity', 0);
Screen('Preference', 'VisualDebugLevel', 3);
ListenChar(2);
screenNum = 0;
[res(1), res(2)] = Screen('WindowSize', screenNum);
%res(1) = res(1) / 2;
%res(2) = res(2) / 2;
clrdepth = 32;
[wPtr, rect] = Screen('OpenWindow', screenNum, 0);%, [100 100 res(1) res(2)], clrdepth);
black = BlackIndex( wPtr );
white = WhiteIndex( wPtr );
Screen( 'fillRect', wPtr, black );
Screen( 'TextSize', wPtr, 40 );
Screen( 'TextFont', wPtr, 'Windings3');
str='Please watch the following movies \n \n and identify the walking direction.';
[nx, ny, textbounds] = DrawFormattedText(wPtr, str , 'center', 'center', [255 255 255]);
Screen('Flip', wPtr);
tic; while toc<4,end

dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp1\conditions\current\';
listing = dir(dname);
listing(1:2) = []; %cut off references to parent folders, only keep the filenames


numfiles = numel(listing);
conditiontrials = 16; %number of trials per condition
%resp has number of rows same as number of conditions(movies) times number of trials per condition
%resp columns should be [angle, actual direction, respondent direction, time for trial] 
resp = inf(numfiles*conditiontrials, 7);


respnumber = 0;

for trial = 1:conditiontrials
    randomlist = randperm(numfiles); % random permutation of actual file indices

    for fileindex = randomlist,

        fname = listing(fileindex).name;
        walkdir = directionFromFilename(fname);
        lightang = lightAngleFromFilename(fname);
        recordindex = numfiles*(trial-1)+fileindex;
        
        resp(recordindex, 1) = lightang;
        resp(recordindex, 2) = walkdir;

        fullfname = strcat(dname, fname);
        %fname = 'testmov.mat';
        %Screen('Flip', wPtr);

        tm = load(fullfname);
        frames2 = {tm.mmo.cdata};
        for k=1:1:numel(frames2)
            mov1{1, k} = Screen('MakeTexture', wPtr, frames2{1,k});
        end

        displaystart = cputime;
        for k=1:1:numel(frames2)
            tic; while toc < 0.02, end
            Screen('DrawTexture', wPtr, mov1{1,k});
            Screen('Flip', wPtr);
        end
        displaytotal = cputime-displaystart;

        for frm=1:1:numel(frames2)
            Screen('Close', mov1{1,frm});
        end

        %Screen('fillRect',wPtr,black);
        str='What was the walking direction? \n \n Press [UP] key to indicate away direction and \n \n [DOWN] key to indicate it was towards';
        [nx, ny, textbounds] = DrawFormattedText(wPtr, str , 'center', 'center', [255 255 255]);
        Screen(wPtr, 'Flip');


        % Input from Kb
        t=cputime;
        ind=0;
        keyIsDown=0;
        while (keyIsDown == 0) || (ind == 0)
            [keyIsDown, secs, keyCode, deltasec] = KbCheck;
            kbNameResult = KbName(find(keyCode));
            if not(isempty(kbNameResult))==1
                %ratings(count,1)=str2double(kbNameResult);
                answer = kbNameResult;
                %times(count,1)=cputime-t;
                time = cputime-t;
                switch kbNameResult
                    case 'up'
                        ind = 1;
                        display (kbNameResult);
                    case 'down'
                        ind = 1;    
                    case 'space'
                        display('exited');
                        Screen('CloseAll');
                        eflag1 = 1;
                        break;
                    otherwise
                        Screen('fillRect', wPtr, black);
                        err_str = 'Please retry and press either \n \n [UP] key if you saw it walking away from you and \n \n [DOWN] key if you saw it walking towards you';
                        [nx, ny, textbounds] = DrawFormattedText(wPtr, err_str , 'center', 'center', [255 255 255]);
                        Screen(wPtr, 'Flip');
                end
            end
        end
        respnumber = respnumber + 1;
        resp(recordindex, 3) = directionFromKey(answer);
        resp(recordindex, 4) = time;
        resp(recordindex, 5) = trial;
        resp(recordindex, 6) = respnumber;
        resp(recordindex, 7) = displaytotal;
        %size(te(all(isfinite(te)'a),:),1) %determine number of non-infinite rows in one line
        save(strcat(subjname,'resp',num2str(respnumber),'.mat'), 'resp');
         
        if eflag1 == 1
            eflag2 = 1;
            break;
        end;
    end
    if eflag2 == 1
        break;
    end 
end
     
Screen('CloseAll');
%clc;
disp('Movie displayed successfully');
disp(answer);
disp(time);
ListenChar(0);  
return