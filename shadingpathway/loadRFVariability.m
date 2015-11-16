function [ resp ] = loadRFVariability( pathkey, type )


te = load(fullfile(WalkerPath.getPath(pathkey), strcat('rfvar_', type,'.mat')));
resp = te.('vardata');
clear te;

return
