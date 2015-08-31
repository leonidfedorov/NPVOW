function [nfinput]=loadNFInput(path_nf, file1, file2, duration)
%loadNFinput(folder) loads the result of the mapping from the shading
%       pathway to idealized 2d-NF input, assuming there are only 2 walking 
%       directions, and creates an input array that could be fed in to the 
%       2D neural field. Takes pathname and 2 filenames for the 2 stimuli, 
%       and the duration of the input as parameters.
%        
%
%                Version 0.9,  31 August 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%


narginchk(4,4)

movie = 0;%1;

stim_away = load(fullfile(path_nf,file1));
stim_away = stim_away.Y_away;
stim_towa = load(fullfile(path_nf,file2));
stim_towa = stim_towa.Y_towa;


stim_away_population_away = stim_away(1:50,:);
stim_away_population_towa = stim_towa(51:100,:);

for i = 1:50,
%
    stim_away_population_away(i,:) = [stim_away_population_away(i,i+1:50),stim_away_population_away(i,1:i)];
    stim_away_population_towa(i,:) = [stim_away_population_towa(i,i+1:50),stim_away_population_towa(i,1:i)];
end



stim_away_population_away = circshift(stim_away_population_away,25,2);%TODO: here we set the peaks at fixed position,
stim_away_population_towa = circshift(stim_away_population_towa,25,2);%but it'd be different for more walking directions
rearranged = [stim_away_population_away,stim_away_population_towa];
surf(rearranged);



SM = zeros(50,100,duration);
if movie == 1,
    avi_name_SM = 'SM.avi';
    V_SM=VideoWriter(avi_name_SM,'Motion JPEG AVI');
    set(V_SM, 'Quality', 100,'FrameRate',25);
    open(V_SM);
end

for i = 1:duration-4,        
    mask = zeros(50,100);
    mask(1:5, :) = ones(5,100);
    window = circshift(mask.*circshift(rearranged,mod(i,50)),-mod(i,50));
    surf(window); view([-22 66])
    title(strcat( 't=', num2str(i),...
        ' max amplitude = ', num2str(max(window(:))))...
        ); %pause(0.05);
    SM(:,:,i)=window;
    if movie == 1,
        currFrame = getframe(gcf);
        writeVideo(V_SM,currFrame);
    end
end

if movie == 1,
    close(V_SM);
end

nfinput = SM;

return
