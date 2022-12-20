function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Tailles
    [~,M] = size(y);

    S1 = 0;
    S2 = 0;
    S = 0;
    var = 0;
    MSE = 0;
    
    y_m = sum(y,2)/M;
    yest_m = sum(yest,2)/M;

    % Calcul des metriques
    for i = 1:M
        diff_y = y(:,i) - y_m;
        diff_yest = yest(:,i) - yest_m;

        S1 = S1 + diff_y^2;
        S2 = S2 + diff_yest^2;

        S = S + diff_y*diff_yest;
        var = var + diff_y^2/(size(y,2) - 1);
        MSE = MSE + (yest(:,i) - y(:,i))^2;
    end

    NMSE = MSE/(M*var);
    MSE = MSE/M;
    Rsquared = S^2/(S1*S2);
end


