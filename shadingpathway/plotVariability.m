function plotVariability(exp_type)

%plotVariability(expType) plots variability of RFs for each condition in
%       LFAP experiments, where the experiment type is specified.
%
%                Version 0.9,  12 November 2015 by Leonid Fedorov
%
%                Tested with MATLAB 8.4 on a Xeon E5-1620 3.6Ghz under W7
%
%

% TODO: check for exp_type and do different thigns based on its value
exp_type = 1;

condvars = containers.Map;

%we just add parts that were present for every condition and barplot all

condvars('body') = ...
    computeRFVariability ('st-d-h90','shading') + ...
    computeRFVariability ('st-d-h270','shading')+ ...
    computeRFVariability ('st-d-ub90','shading')+ ...
    computeRFVariability ('st-d-ub270','shading')+ ...
    computeRFVariability ('st-d-lb90','shading')+ ...
    computeRFVariability ('st-d-lb270','shading');

basecase = condvars('body') + ... %compute the base case, because upper arms are always present
    computeRFVariability ('st-d-lua90','shading') + ...
    computeRFVariability ('st-d-lua270','shading')+ ...
    computeRFVariability ('st-d-rua90','shading')+ ...
    computeRFVariability ('st-d-rua270','shading');

condvars('arms') = basecase + ...
    computeRFVariability ('st-d-rla90','shading')+ ...
    computeRFVariability ('st-d-rla270','shading')+ ...
    computeRFVariability ('st-d-lla90','shading') + ...
    computeRFVariability ('st-d-lla90','shading');

condvars('legs') = basecase + ...
    computeRFVariability ('st-d-rll90','shading')+ ...
    computeRFVariability ('st-d-rll270','shading')+ ...
    computeRFVariability ('st-d-lll90','shading') + ...
    computeRFVariability ('st-d-lll90','shading');

condvars('thighs') = basecase + ...
    computeRFVariability ('st-d-rul90','shading')+ ...
    computeRFVariability ('st-d-rul270','shading')+ ...
    computeRFVariability ('st-d-lul90','shading') + ...
    computeRFVariability ('st-d-lul90','shading');

%below we have mixed conditions, but we need to substract the base case
%because its then counted twice. Recall the probability of events with non-empty intersection =J
condvars('arms&legs') = condvars('arms') + condvars('legs') - basecase;
condvars('thighs&legs') = condvars('thighs') + condvars('legs') - basecase;
condvars('arms&thighs') = condvars('arms') + condvars('thighs') - basecase;


condvars('all') = condvars('arms') + condvars('thighs') + condvars('legs') - 2 * basecase;
figure;
bar([condvars('body'),condvars('arms'),condvars('legs'),condvars('thighs'),condvars('arms&legs'),condvars('thighs&legs'),condvars('arms&thighs'),condvars('all')])


return