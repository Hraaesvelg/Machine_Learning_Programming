function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Mu=zeros(size(X,1),k);
    
    if(strcmp(init, 'sample'))
        for i=1:k
            x = randsample(size(X,2),1);
            Mu(:,i) = X(:,x);
        end
    elseif(strcmp(init, 'range'))
        X_min = min(X,[],2);
        X_max = max(X,[],2);
        Mu = X_min + (X_max-X_min).*rand(size(X,1),k);
    else
        print("Sorry, the method selected doesn't exist or isn't supported");
    end

end