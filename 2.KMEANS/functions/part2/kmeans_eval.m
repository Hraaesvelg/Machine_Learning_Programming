function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    RSS_curve = zeros(1,size(K_range,2));
    AIC_curve = zeros(1,size(K_range,2));
    BIC_curve = zeros(1,size(K_range,2));
    
    for k=K_range
        for rep=1:repeats
            [labels, Mu, ~, ~] = kmeans(X,k,init,type,MaxIter,false);
            [A,B,C] = compute_metrics(X,labels,Mu);
            RSS_curve(1,k) = RSS_curve(1,k) + A;
            AIC_curve(1,k) = AIC_curve(1,k) + B;
            BIC_curve(1,k) = BIC_curve(1,k) + C;
    
        end
    end
    RSS_curve = RSS_curve/repeats;
    AIC_curve = AIC_curve/repeats;
    BIC_curve = BIC_curve/repeats;

end
