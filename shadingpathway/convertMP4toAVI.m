function convertMP4toAVI(mp4file, top, left, bgcolor, resx, resy)

[~, fileBase, fileExt] = fileparts(mp4file);
reader = VideoReader(mp4file);
writer = VideoWriter(strcat(fileBase,'.avi'),'Motion JPEG AVI')
writer.FrameRate = reader.FrameRate;
set(writer, 'Quality', 100);
open(writer);

while hasFrame(reader)
   img = readFrame(reader);
   img(:, :, 2:3) = [];
   img(:, end - 20 : end) = bgcolor;
   [imgx, imgy] = size(img);
   normalized = [bgcolor * ones(imgx, left), img, bgcolor * ones(imgx, resy - left - imgy)];
   [imgx, imgy] = size(normalized);
   normalized = [bgcolor * ones(top, imgy); normalized; bgcolor * ones(resx - top- imgx, imgy)];
%    normalized = 125.0 * ones(resx, resy);
%    normalized(top + 1 : top + size(img, 1), left + 1 : left + size(img, 2)) = img;
   imshow(normalized, 'Border', 'tight');
   writeVideo(writer, normalized);
end

close(writer);
