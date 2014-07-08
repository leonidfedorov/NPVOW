function [lightAngle] = lightAngleFromFilename(filename)
    pattern = '\d+.\d+'; %match decimal number within a filename
    s = regexp(filename, pattern, 'match');
    if strcmp(s,'1.101'),
            lightAngle = -Inf;
    elseif strcmp(s, '1.111'),
            lightAngle = Inf;
    else    
            lightAngle = str2double(s);
    end
%     if lightAngle > 3.1416,
%         lightAngle = lightAngle - pi;
%     end
return