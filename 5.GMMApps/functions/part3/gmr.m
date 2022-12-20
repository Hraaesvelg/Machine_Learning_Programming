function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tailles
P = size(out, 2);
[N, M] = size(X);
[D, K] = size(Mu);

y_est = zeros(P, M);
var_est = zeros(P, P, M);
probaXYTH = zeros(1,M);

% Création des Mu
MuX = Mu(1:N,:);
MuY = Mu(N+1:D,:);

% Création des Variances
Sxx = Sigma(1:N,1:N,:);
Syy = Sigma(N+1:D,N+1:D,:);
Sxy = Sigma(1:N,N+1:D,:);
Syx = Sigma(N+1:D,1:N,:);

for j=1:M
    sum = 0;
    % computing the joint density of the inputs and outputs through
    % gaussian PDF
    for i=1:K
        probaXYTH(j) = probaXYTH(j) + Priors(1,i)*gaussPDF(X(:, j), ...
            MuX(:, i), Sxx(:, :, i));
    end
    % Compute the Expectation and Variance of the Conditional density
    for k = 1:K

        beta = gaussPDF(X(:, j), MuX(:, k), Sxx(:, :, k)) * Priors(k);
        lrf = MuY(:, k) + Syx(:, :, k) / Sxx(:, :, k) * (X(:, ...
            j) - MuX(:, k));
        Var= (Syy(:, :, k) - (Syx(:, :, k))/ Sxx(:, :, k) * Sxy(:, :, k));
        y_est(:, j) = y_est(:, j) + (beta * lrf / probaXYTH(j));

        sum = sum + (beta*(lrf.^2 + Var) / probaXYTH(j));
    end
end
