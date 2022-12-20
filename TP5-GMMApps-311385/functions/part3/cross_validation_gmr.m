function [metrics] = cross_validation_gmr( X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tailles
[N,M] = size(X);
[P,~]= size(y);
K = size(k_range,2);

in = N;
out = N+1:(N+P);

% Initialisation des metriques 
MSE = zeros(1, F_fold);
NMSE = zeros(1, F_fold);
R2 = zeros(1, F_fold);
AIC = zeros(1, F_fold);
BIC = zeros(1, F_fold);

std_MSE = zeros(1, K);
std_NMSE = zeros(1, K);
std_R2 = zeros(1, K);
std_AIC = zeros(1, K);
std_BIC = zeros(1, K);

mean_MSE = zeros(1, K);
mean_NMSE = zeros(1, K);
mean_R2 = zeros(1, K);
mean_AIC = zeros(1, K);
mean_BIC = zeros(1,K);

% calcul de la moyenne des differentes metriques
for i = 1:K
    for j = 1:F_fold 
        [X_train, y_train, X_test, y_test] = split_regression_data(X,y,valid_ratio);
        params.k = k_range(i);
        [Priors, Mu, Sigma, ~] = gmmEM([X_train;y_train],params);
        [y_est, ~] = gmr(Priors,Mu,Sigma,X_test,in,out);
        [AIC(j), BIC(j)] =  gmm_metrics([X_train;y_train],Priors,Mu,Sigma,params.cov_type);
        [MSE(j), NMSE(j), R2(j)] = regression_metrics(y_est,y_test);
    end
    mean_MSE(i) = mean(MSE);
    mean_NMSE(i) = mean(NMSE);
    mean_R2(i) = mean(R2);
    mean_AIC(i) = mean(AIC);
    mean_BIC(i) = mean(BIC);

    std_MSE(i) = std(MSE);
    std_NMSE(i) = std(NMSE);
    std_R2(i) = std(R2);
    std_AIC(i) = std(AIC);
    std_BIC(i) = std(BIC);

end
metrics.mean_MSE = mean_MSE;
metrics.mean_NMSE = mean_NMSE;
metrics.mean_R2 = mean_R2;
metrics.mean_AIC = mean_AIC;
metrics.mean_BIC = mean_BIC;

metrics.std_MSE = std_MSE;
metrics.std_NMSE = std_NMSE;
metrics.std_R2 = std_R2;
metrics.std_AIC = std_AIC;
metrics.std_BIC = std_BIC;

end


