function [direction] = directionFromFilename(filename)
    pattern = '^[a-z]{4}'; %match first four alphanumerical symbols within a filename
    strdirection = regexp(filename, pattern, 'match');
    if strcmp(strdirection,'towa')
        direction = 1;
    elseif strcmp(strdirection,'away')
        direction = 0;
    end
    return