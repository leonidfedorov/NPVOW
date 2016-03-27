function [adaptation, noise, suffix] = parseFieldFile( filename )

    nameparts = strsplit(filename, '_');
    
    adaptation = str2double(nameparts{1});
    noise = str2double(nameparts{2});
    suffix = char(strsplit(nameparts{3}, '.mat'));

end

