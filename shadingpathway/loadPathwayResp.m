function [ resp ] = loadPathwayResp( pathkey, type )

if strcmp(type, 'form')
    dataname = 'formresp';
    filename = 'formresp';
elseif strcmp(type, 'shading')
    dataname = 'xdata';
    filename = 'xdata';
elseif strcmp(type, 'shading-sel')
    dataname = 'vardata';
    filename = 'rfvar_shading';
end
te = load(fullfile(WalkerPath.getPath(pathkey), strcat(filename,'.mat')));
resp = te.(dataname);
clear te;

return
