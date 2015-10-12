function storeAVIasMAT(coavi)


covid = VideoReader(coavi)
frrate = get(covid,'FrameRate');
numofr = get(covid,'NumberOfFrames');
cofr = read(covid);

mmo(numofr).cdata = ones(get(covid,'Height'),get(covid,'Width'),3);
mmo(numofr).colormap = [];
for frindex = 1:numofr,
    mmo(frindex).cdata = cofr(:,:,:,frindex);
    %coframe = cofr(:,:,:,frindex);
end


save('mmo.mat', 'mmo');