function [ resp ] = loadFormResp( pathkey )

te = load(fullfile(WalkerPath.getPath(pathkey),'formresp.mat'))
resp = te.formresp;
clear te;

return

