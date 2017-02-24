function createShadedSphereWalker(folder)
narginchk(1,1)

d = dir(folder)
isub = [d(:).isdir];
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.', '..'})) = [];
bg = 0.01;
fg = 0.98;

for kk = 1 : numel(nameFolds),
    partFoldername = char(nameFolds(kk));
    aviListing = dir(fullfile(folder, partFoldername, '*.avi'));
    partFilename = aviListing(1).name;
    partFilename_bw = strcat('bw_', partFilename);
    
    convert2BWwalker(fullfile(folder, partFoldername, partFilename), ...
                    fullfile(folder, partFoldername, partFilename_bw), ...
                    bg, fg);
    
    
    storeAVIasPNGset(fullfile(folder, partFoldername));
    
    partFoldername_interp = strcat('interp_', partFoldername);
    
    
    interpim_path = fullfile(fullfile(folder, partFoldername_interp));
    mkdir(fullfile(folder, partFoldername_interp))  
    maskim_path = fullfile(folder, partFoldername, partFilename_bw(1 : end - 4));
    grayim_path = fullfile(folder, partFoldername, partFilename(1 : end - 4));
    
    pngListing = dir(fullfile(maskim_path, '*.png'));
    for ii = 1 : numel(pngListing),
        maskim = fullfile(maskim_path, pngListing(ii).name);
        grayim = fullfile(grayim_path, pngListing(ii).name);
        interpim = fullfile(interpim_path, pngListing(ii).name);
        interpolate2Spheres(maskim, grayim, interpim);
    end
end

