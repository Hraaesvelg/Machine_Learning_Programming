function [AIC_curve, BIC_curve] =  gmm_eval(X, K_range, repeats, params)
%GMM_EVAL Implementation of the GMM Model Fitting with AIC/BIC metrics.
%
%   input -----------------------------------------------------------------
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o repeats  : (1 X 1), # times to repeat k-means
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%           * max_iter: Max number of iterations for EM algorithm
%
%   output ----------------------------------------------------------------
%       o AIC_curve  : (1 X K), vector of min AIC values for K-range
%       o BIC_curve  : (1 X K), vector of min BIC values for K-range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = length(K_range);

log_data= zeros(1,repeats);
AIC_data = zeros(1, repeats);
BIC_data= zeros(1, repeats);

AIC_curve = zeros(1,K);
BIC_curve = zeros(1,K);

    for k=1:K
        params.k=K_range(k);
        for rep=1:repeats
            [Priors, Mu, Sigma, ~] = gmmEM(X,params);
            log_data(1,rep)=gmmLogLik(X, Priors, Mu, Sigma);
            [AIC_data(1,rep), BIC_data(1,rep)] = gmm_metrics(X, Priors, Mu, Sigma, params.cov_type);
        end
        [~, indice] = max(log_data);
        AIC_curve(1,k) = AIC_data(1,indice);
        BIC_curve(1,k) = BIC_data(1,indice);
    end
end
