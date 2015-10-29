function [pxlArray] = pixelMorph(pathkey1, pathkey2, lambda, savepathkey)
% pixelMorph(pathkey1, pathkey2, lambda, savepathkey)
%          Linearly combine walkers under pathley1, pathkey2 with the
%          lambda parameter as C = A*lambda + (1-lambda)*B, where A, B are
%          walker matrices retrieved and C is the resulting walker saved
%          under savepathkey.
%
%                Version 1.0,  29 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7


PXM1 = loadLFAPpxlarray( WalkerPath.getPath(pathkey1) );
PXM2 = loadLFAPpxlarray( WalkerPath.getPath(pathkey2) );
PXM2 = circshift(PXM2,floor(size(PXM2,3)/2),3);

PXM3 = PXM1.*lambda + PXM2.*(1-lambda);

%figure; 
% subplot(2,2,1); imshow(PXM1(:,:,1))
% subplot(2,2,3); imshow(PXM2(:,:,1))
% subplot(2,2,[2,4]); %imshow(PXM3(:,:,1))


f = figure;
fpos = get(f, 'position');

savepath = WalkerPath.getPath(savepathkey);
if ~isdir (savepath), mkdir(savepath); end


V=VideoWriter(fullfile(savepath,savepathkey),'Motion JPEG AVI');
set(V, 'Quality', 100, 'FrameRate', 25);
open(V);


for ind = 1:size(PXM3,3)
    framesize = size(PXM3(:,:,ind));
    if ~isequal([fpos(3), fpos(4)], framesize)
        set(f, 'position', [0 0 framesize])
    end
    imshow(PXM3(:,:,ind), 'Border', 'tight'); hold on;
    
    currFrame = getframe(gcf);
    imwrite(currFrame.cdata, fullfile(savepath,[num2str(ind),'.png']),'PNG');
    pause(0.015)
    writeVideo(V,currFrame);
    mmo(ind) = currFrame;
end


% save(fullfile(savepath, strcat(savepathkey,'.mat')), 'PXM3')
save(fullfile(savepath, [savepathkey,'.mat']),'mmo');
close(V);


% storeMATasAVI(savepath);

end