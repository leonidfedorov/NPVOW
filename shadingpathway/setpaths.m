%Hi!
% I practiced anonymous functions, chars and cell arrays, cellfun and arrayfun.
% So there're some unnessesary steps for the task, and the below could be done
% much cleaner. But, exercise!
% -Leonid


% Returns a handle to a function that will apply a fixed {func} to a fixed
% {matrix} at a given row. For example, I can then do: 
% >> te = applyToGivenRow(myfoo,mymatrix)
% and so {te} will become the function that operates with fixed {myfoo} and
% {mymatrix}. Now {te} takes a row number as a parameter, such as:
% >> te(1) 
% will apply whatever {myfoo} was to the 1st row of {mymatrix}.
applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));


% We want to be able to apply some {func} to every row of some {matrix}.
% So read the below from the innermost clause.
% 1. Generate a list of integers from 1 to row number of the {matrix}.
% 2. Use MATLAB's {arrayfun} to apply {applyToGivenRow(func, matrix)} to the array from previous step.
% 3. This passes each row number to {applyToGivenRow()}.
% 4. Which is equivalent to applying {func} to each row of {matrix}.
% 5. But {func} and {matrix} are passed down externally to MATLAB's {arrayfun}.
% 6. So this means that I can call {newApplyToRows} with {func} and {matrix} as parameters.
% For example:
% >> newApplyToRows(myfoo,mymatrix)
% will basically apply myfoo to each row of mymatrix independently, and
% return the result as a matrix of the resulting rows, as we wanted!!!
newApplyToRows = @(func, matrix) arrayfun(applyToGivenRow(func, matrix), 1:size(matrix,1), 'UniformOutput', false)';



%takes a string and prefixes it with MATLAB's {userpath} without {pathsep}, followed by {filesep}
appendUserPath = @(a) strcat(strtok(userpath, pathsep), filesep, a);



%TODO: this one isn't quite working at the moment, because it uses cells. Not used.
takeAll = @(x) reshape([x{:}], size(x{1},2), size(x,1))';
%TODO: this one doesn't work but it should be more generic than {newApplyToRows}. Not used.
genericApplyToRows = @(func, matrix) takeAll(newApplyToRows(func, matrix));


%just a list of relative paths that I use
paths = char(...
            'NPVOW\computation',...
            'NPVOW\shadingpathway',...
            'NPVOW\stimuligenerator',...
            'NPVOW\Shapes\bioelectromagnetism\bioelectromagnetism',...
            'NPVOW\Shapes\bioelectromagnetism',...
            'NPVOW\Shapes',...
            'NPVOW\external\psignifit\dll',...
            'NPVOW\external\psignifit',...
            'NPVOW\newNeurFs',...
            'NPVOW\snippets',...
            'NPVOW\external\anova_rm',...
            'NPVOW\LFAP\exp1',...
            'NPVOW\external\shadedErrorBar',...
            'NPVOW\external\subaxis',...
            'NPVOW\external\csvimport',...
            'NPVOW\walker',...
            'NPVOW'...
            );
        
% Use a list of relative paths above to format them and add to MATLAB
%1. Generate a char array of proper paths from paths using {newApplyToRows}
%2. Implicitly convert it to cell array, i.e. a list of cells taking one char row as one list.
%3. Finally, we apply MATLAB's {addpath} to every path in that list using MATLAB's {cellfun}
cellfun(@(p) addpath(p), newApplyToRows(appendUserPath, paths))