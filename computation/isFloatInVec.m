function [answer] = isFloatInVec(x, vector, prec)
%checks if a floating point number is in the floating point vector
%with a given precision(doesn't work at high precision that pushes the MATLAB limits)


answer = any( abs(vector - x) < prec );

return
