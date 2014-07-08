function [direction] = directionFromKey(key)
    if strcmp(key,'up')
        direction = 0;
    elseif strcmp(key,'down')
        direction = 1;
    else
        direction = NaN;
    end
    return