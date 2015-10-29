classdef WalkerPath 
    properties(Constant=true, Access = private)
        %All paths are independent from the generateWalker output or alike.
        %Therefore, to set up a new path:
        % 1) record it here as a new class property
        % 2) add a condition to the parseKey function
        
        %walkers with diamond parts
        StNW1_d_90_168 = 'NPVOW\walker\test\POSSIBLESTNW1as0.5ss0.3ds0.4se10_t30av10o5pl30o10m0\towa_168\';  
        
        %walkers with cylindrical parts
        StNW1_c_0_n = 'NPVOW\walker\test\newjoris\270\';
        StNW1_c_45_n = 'NPVOW\walker\test\newjoris\315\';
        StNW1_c_315_n = 'NPVOW\walker\test\newjoris\225\';
        StNW1_c_90_n = 'NPVOW\walker\test\newjoris\0\';
        StNW1_c_270_n = 'NPVOW\walker\test\newjoris\180\';        
        
        %black and white walkers with cylindrical parts
        StNW1_c_45_bw = 'NPVOW\walker\test\bwjoris\45\';
        StNW1_c_315_bw = 'NPVOW\walker\test\bwjoris\315\';
        
        %morphed paths
        Morph_StNW1_c_45_315_l05 = 'NPVOW\walker\test\pxlmorph\c_45_315_la0.5';
        Morph_StNW1_c_0_0_l05 = 'NPVOW\walker\test\pxlmorph\c_0_0_la0.5';
        Morph_StNW1_c_90_270_l05 = 'NPVOW\walker\test\pxlmorph\c_90_270_la0.5';

        %simulation keys
        Sim_c_45_315_n = 'NPVOW\walker\simres\c_45-315_n\';
        Sim_c_45_315_bw = 'NPVOW\walker\simres\c_45-315_bw\';
        Sim_c_45_315_n_bw = 'NPVOW\walker\simres\c_45-315_n_bw\';
    end
    
    methods(Static, Access = public)
        %class users can call this method as WalkerPath.getPath(pathkey)
        %e.g. WalkerPath.getPath('st-d-t-168-m') will give a path to:
        %st: StNW1 walker
        %d: rendered with diamond parts
        %t: walking towards
        %168: lit at 168 angle with a vertical meridian
        %m: arbitrary meta if neccessary
        function dirpath = getPath (pathkey)
            path = WalkerPath.parseKey(pathkey);
            dirpath = fullfile(formCorePath, path);
        end
    end
    
    methods(Static, Access = private)
        function dirpath = parseKey (pathkey)
            %NOTE: simply returns the full path by easily-typed key 
            %(which is the whole point of this class).
            %but if I ever want more sophisticated key parsing, I would
            %only need to rewrite this method to parse it and nothing else 
            %(which is also another useful point of having this class).
            switch pathkey
                %walkers with diamond parts
                case 'st-d-90-168'
                    dirpath = WalkerPath.StNW1_d_90_168;
                    
                %walkers with cylindrical parts
                case 'st-c-0-n'
                    dirpath = WalkerPath.StNW1_c_0_n;
                case 'st-c-45-n'
                    dirpath = WalkerPath.StNW1_c_45_n;
                case 'st-c-315-n'
                    dirpath = WalkerPath.StNW1_c_315_n;
                case 'st-c-90-n'
                    dirpath = WalkerPath.StNW1_c_90_n;
                case 'st-c-270-n'
                    dirpath = WalkerPath.StNW1_c_270_n;                    
                
                %black and white walkers with cylindrical parts
                case 'st-c-45-n-bw'
                    dirpath = WalkerPath.StNW1_c_45_bw;
                case 'st-c-315-n-bw'
                    dirpath = WalkerPath.StNW1_c_315_bw;
                    
                %pathkeys for the morphs
                case 'morph-c-45-315-n-la0.5'
                    dirpath = WalkerPath.Morph_StNW1_c_45_315_l05;
                case 'morph-c-0-0-n-la0.5'
                    dirpath = WalkerPath.Morph_StNW1_c_0_0_l05;    
                case 'morph-c-90-270-n-la0.5'
                    dirpath = WalkerPath.Morph_StNW1_c_90_270_l05;      
                    
                %simulation results for RBF networks pathkeys
                case 'sim-c-45-315-n'
                    dirpath = WalkerPath.Sim_c_45_315_n;
                case 'sim-c-45-315-bw'
                    dirpath = WalkerPath.Sim_c_45_315_bw;                 
                case 'sim-c-45-315-n-bw'
                    dirpath = WalkerPath.Sim_c_45_315_n_bw;
                    
                %just display the error message, so {getPath} will just return the {userpath}    
                otherwise
                    display('WARNING: Requested unknown path, returning the {userpath}')
                    dirpath = '';
            end
        end
    end
    
end

%Get the working path to which I right-concatenate the inner path
function corepath = formCorePath
    corepath = strcat(strtok(userpath,';'),filesep);
end