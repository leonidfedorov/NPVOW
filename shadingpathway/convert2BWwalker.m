function convert2BWwalker(coavi, bwavi, bg, fg)

close all;
covid = VideoReader(coavi)
frrate = get(covid,'FrameRate');
numofr = get(covid,'NumberOfFrames');
cofr = read(covid);

bwvid=VideoWriter(bwavi,'Motion JPEG AVI');
set(bwvid, 'Quality', 100,'FrameRate',frrate);
open(bwvid);


for frindex = 1:numofr,
    coframe = cofr(:,:,:,frindex);
    bwframe = double(im2bw(coframe,0.1));%writeVideo, unlike imshow, only accepts double
    bwframe = bwframe(81:800,251:650);
    h1 = imshow(imresize(bwframe,0.5)) %for debugging
    %Protecting against bg or fg being equal to 0 or 1 on input,
    %which could make bg and fg pixels euqal without user's intention.
    %It is still possible to make bg equal to fg, if intended, though.
    %Other options to do this would be either a bunch of if-clauses or 
    %through matrix multiplication.
    bwframe(bwframe == 0) = inf; 
    bwframe(bwframe == 1) = -inf;
    bwframe(bwframe == -inf) = fg(1);
    bwframe(bwframe == inf) = bg(1);
    h2 = imshow(imresize((bwframe),0.5));
    writeVideo(bwvid,bwframe);
end

close(bwvid);
