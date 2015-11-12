function [ resp ] = loadPathwayResp( pathkey, type )

if strcmp(type, 'form')
    dataname = 'formresp';
elseif strcmp(type, 'shading')
    dataname = 'xdata';
end
te = load(fullfile(WalkerPath.getPath(pathkey), strcat(dataname,'.mat')));
resp = te.(dataname);
clear te;

return
