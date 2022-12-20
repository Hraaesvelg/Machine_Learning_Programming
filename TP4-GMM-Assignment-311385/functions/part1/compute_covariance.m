function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%
    [N,M] = size(X);

    if(strcmp(type, 'iso'))
        sigma = 0;
        for i=1:M
            sigma = sigma + norm(X(:,i)-X_bar)^2;
        end
        Sigma = diag(sigma/(N*M)*ones(N,1));
    elseif (strcmp(type, 'full'))
        Sigma = 1/(M-1)*(X-X_bar)*transpose(X-X_bar);
    elseif (strcmp(type, 'diag'))
        Sigma = diag(diag(1/(M-1)*(X-X_bar)*transpose(X-X_bar)));
    else
        disp("The type specified isn't supported")
    end

end

