function [avercond] = averCondFromFilename(filename)
    pattern = '_[a-z]+_'; %match first four alphanumerical symbols within a filename
    stravercond = regexp(filename, pattern, 'match');
    strarr = strsplit(char(stravercond), '_');
    stravercond = char(strarr(2));%TODO: redo the parsing
    %names are after [cond1,cond2,..cond9]
    conditionnames = [{'bol'}, {'t'}, {'f'}, {'l'}, {'tl'}, {'ft'}, {'fl'}, {'nor'}, {'all'}];
    [temp, avercond] = ismember(stravercond,conditionnames);
    return