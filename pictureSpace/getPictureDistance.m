function [ distance_matrix ] = getPictureDistance( folder, distfun_name )
%takes a set of pictures from a folder and returns a distance matrix
%by the specified distance function name
%   %TODO: very drafty in loading the data (a little bit in processing it too)


listing = dir(fullfile(folder, 'tda2_*'));
listing = listing([listing.isdir]);


az_selection = [0:pi/15:2*pi-pi/15];
az_selection = az_selection(1:2:end);

el_selection = [0];

wlk_selection = 1:2:30

count = 0;

resolution = [256 256];

% images = Inf(numel(az_selection)*numel(el_selection)*numel(wlk_selection), resoluthelpion(1), resolution(2));
images = [];
for i = 1:numel(listing),
    dinfo = strsplit(listing(i).name, '_');
    azimuth = str2double(dinfo{2}(3:end));
    elevation = str2double(dinfo{3}(3:end));
    if isFloatInVec(elevation, el_selection, 0.001) && isFloatInVec(azimuth, az_selection, 0.001),
%         count = count + 1;
        listing(i).name
%         fnames = dir(fullfile(listing(i).name, '*.png'));
        for fi = wlk_selection,
            images = cat(3, images, imread(fullfile(folder,listing(i).name, [num2str(fi),'.png'])));
        end
    end
end

imvectors = reshape(images, [resolution(1)*resolution(2) size(images,3)]);
%hamming distance is very interesting: a percentage of coordinates that
%differ. In case of two deformations it is bimodal. I wonder if it'd be
%trimodal for three rotations
%spearman and regular correlation give right-skewed normal distros
%everything else suprisingly gives normal distribution
d = pdist(imvectors',distfun_name);
m = squareform(d,'tomatrix');
histfit(d);

[coeff,score,latent,tsquared,explained,mu] = pca(m);
figure; plot(latent);
explained(1:5)

distance_matrix = d;

end

