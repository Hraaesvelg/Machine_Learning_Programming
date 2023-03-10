function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix

    % test des moyenne par colonnes
    Mu = mean(X,2);
    X = X - Mu;
    
    % computation of the covariance matrix
    C = (1/(size(X,2)-1))*(X*X');
    
    %compute the eigenvalues/vectors
    [EigenVectors, EigenValues] = eig(C)
    [EigenValues,idx] = sort(diag(EigenValues), "descend");
    EigenVectors = EigenVectors(:,idx);
end


