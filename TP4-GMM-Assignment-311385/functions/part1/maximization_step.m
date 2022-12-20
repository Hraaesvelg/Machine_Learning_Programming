function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

    %data
    epsilon = 1e-5;
    
    %structures
    Priors=zeros(1,params.k);
    Mu=zeros(size(X,1),params.k);
    Sigma=zeros(size(X,1),size(X,1),params.k);
    
    for i=1:params.k
        Priors(1,i) = sum(Pk_x(i,:))/size(X,2);
        Mu(:,i) = (X*Pk_x(i,:)')/sum(Pk_x(i,:));

        if(strcmp(params.cov_type, 'full'))
            for j=1:size(X,2)
                Sigma(:,:,i)=Sigma(:,:,i)+Pk_x(i,j)*(X(:,j)-Mu(:,i))*(X(:,j)-Mu(:,i))'/sum(Pk_x(i,:));
            end
        elseif (strcmp(params.cov_type, 'diag'))
            for j=1:size(X,2)
                Sigma(:,:,i)=Sigma(:,:,i)+Pk_x(i,j)*(X(:,j)-Mu(:,i))*(X(:,j)-Mu(:,i))'/sum(Pk_x(i,:));
            end
            Sigma(:,:,i)=diag(diag(Sigma(:,:,i)));
        elseif (strcmp(params.cov_type, 'iso'))
            for j=1:size(X,2)
                Sigma(:,:,i)=Sigma(:,:,i)+Pk_x(i,j)*norm((X(:,j)-Mu(:,i)))^2/(size(X,1)*sum(Pk_x(i,:)));
            end
            Sigma(:,:,i)=diag(diag(Sigma(:,:,i)));
        else
            disp("The type specified isn't supported")
        end
    end
    
    Sigma=Sigma.*(1+epsilon);
end

