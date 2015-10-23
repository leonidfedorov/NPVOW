classdef WalkerPath 
    properties(Constant=true, Access = private)
        %All paths are independent from the generateWalker output or alike.
        %Therefore, to set up a new path:
        % 1) record it here as a new class property
        % 2) add a condition to the parseKey function
        StNW1_d_90_168 = 'NPVOW\walker\test\POSSIBLESTNW1as0.5ss0.3ds0.4se10_t30av10o5pl30o10m0\towa_168\';  
        StNW1_c_0_n = 'NPVOW\walker\test\newjoris\270\';
        StNW1_c_45_n = 'NPVOW\walker\test\newjoris\315\';
        StNW1_c_315_n = 'NPVOW\walker\test\newjoris\225\';
        StNW1_c_45_bw = 'NPVOW\walker\test\bwjoris\45\';
        StNW1_c_315_bw = 'NPVOW\walker\test\bwjoris\315\';
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
                case 'st-d-90-168'
                    dirpath = WalkerPath.StNW1_d_90_168;
                case 'st-c-0-n'
                    dirpath = WalkerPath.StNW1_c_0_n;
                case 'st-c-45-n'
                    dirpath = WalkerPath.StNW1_c_45_n;
                case 'st-c-315-n'
                    dirpath = WalkerPath.StNW1_c_315_n;
                case 'st-c-45-n-bw'
                    dirpath = WalkerPath.StNW1_c_45_bw;
                case 'st-c-315-n-bw'
                    dirpath = WalkerPath.StNW1_c_315_bw;
                otherwise%just display the error message, so {getPath} will just return the {userpath}
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