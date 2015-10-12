function computeFormToShade(pathkey)
% [FV1f, FV1c, FV4bar, MSTsd, MSTlmf, OFM] = genllr(SVM, MODS);
%          computes responses of the form pathway of the Giese-Poggio 2003
%          model to the stimuli of large shaded walkers. Takes pathkey as
%          an input - it should contain a list of PNGs representing the
%          relevant frames of the walker.
%
%                Version 0.9,  12 October 2015 by Leonid Fedorov.
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%

PXM = loadLFAPpxlarray(WalkerPath.getPath(pathkey));

timeSize = size(PXM, 3)
% create the Gabor function array
GABA = mkgaba;


for k = 1:timeSize,
   [FV1f(:, :, :, k), FV1c(:, :, :, k),  xgct, ygct] = cgabmul(squeeze(PXM(:, :, k)), GABA);
end;



%         rectify, normalize and threshold
thrFV1f = 20;        % threshold
nmfFV1f = 70;        % fixed normalization factor
thrFV1c = 20;        % threshold   
nmfFV1c = 70;        % fixed normalization factor
FV1f  = (FV1f - thrFV1f) .* (FV1f > thrFV1f) / nmfFV1f;
FV1c  = (FV1c - thrFV1c) .* (FV1c > thrFV1c) / nmfFV1c;

display(1)


%         CREATE THE V4 RESPONSES (BAR DETECTORS)

%         calculate the cell responses
for k = 1:timeSize,       % iterate over time steps
  % [FV4bar(:, :, :, k), xcv4, ycv4] = ...
  %         %V1r2V4rb(squeeze(FV1(:, :, :, k)), xgct, ygct);
   [FV4bar(:, :, :, k), xcv4, ycv4] =  V1mr2V4rb(squeeze(FV1f(:, :, :, k)), ...
                     squeeze(FV1c(:, :, :, k)), xgct, ygct);
end;

thrV4b = 0.4;         % threshold
nmfFV4bar = 1;         % fixed normalization factor
FV4bar = (FV4bar - thrV4b) .* (FV4bar > thrV4b) / nmfFV4bar;

display(1)