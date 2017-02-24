function concatenateWalkerParts(folder)
narginchk(1,1)

d = dir(folder)
isub = [d(:).isdir];
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds, {'.', '..'})) = [];
mkdir(fullfile(folder, 'concatenation'));

listing = dir(fullfile(folder, '*.png'));
images = uint8(zeros(900, 900, 30));
for i = 1 : numel(nameFolds),
    interpFolderPart = strfind(nameFolds(i), 'interp');
    nameFolds{i}
    if(~isempty(interpFolderPart{1})),
        im_listing = dir(char(fullfile(folder, nameFolds(i), '*.png')));
        
        for j = 1 : numel(im_listing),
            nameparts = strsplit(im_listing(j).name, '.'); 
            im_num = str2num(char(nameparts{1}));
            im = imread(char(fullfile(folder, nameFolds(i), im_listing(j).name)));
            images(:, :, im_num) = images(:, :, im_num) + im;
        end
        
    end
end

% images( images < 100 ) = 100; 

vid = VideoWriter(char(fullfile(folder, 'concatenation', 'result.avi')),'Motion JPEG AVI');
set(vid, 'Quality', 100, 'FrameRate', 30);
open(vid);
for k = 1 : size(images, 3),
%     images(:, :, k) = imgaussfilt(images(:,:, k), 0.9);
    writeVideo(vid, images(:, :, k));
end

close(vid);
display(1)