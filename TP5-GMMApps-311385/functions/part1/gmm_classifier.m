function [Yest] = gmm_classifier(Xtest, models, labels)
%GMM_CLASSIFIER Classifies datapoints of X_test using ML Discriminant Rule
%   input------------------------------------------------------------------
%
%       o Xtest    : (N x M_test), a data set with M_test samples each being of
%                           dimension N, each column corresponds to a datapoint.
%       o models    : (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels    : (1 x N_classes) unique labels of X_test.
%   output ----------------------------------------------------------------
%       o Yest  :  (1 x M_test), a vector with estimated labels y \in {0,...,N_classes}
%                   corresponding to X_test.
%%
N = size(labels, 2);
M = size(Xtest, 2);
gPDF = zeros(N, M);

for i=1:N
    for j=1:size(models(1, i).Priors, 2)
        gPDF(i, :) = gPDF(i, :) + models(1, i).Priors(1, j)*gaussPDF(Xtest, models(1, i).Mu(:, j), models(1, i).Sigma(:, :, j));
    end
end
gPDF = -log(gPDF);

[~, I]=min(gPDF, [], 1);
Yest=labels(I);

end

