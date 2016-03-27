function [filename] = getFieldFilename( filename, suffix )
  %takes neural field data filename and returns the same but with changed suffix
    [a, n, s] = parseFieldFile(filename);
    filename = strcat(num2str(a), '_', num2str(n), '_', suffix, '.mat');
end

