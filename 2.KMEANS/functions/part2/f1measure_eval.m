function [F1_curve] =  f1measure_eval(X, K_range, repeats, init, type, MaxIter, true_labels)
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
%       o true_labels : (1 x M) the real labels for the F1 measure
%                       computation
%
%   output ----------------------------------------------------------------
%       o F1_curve   : (1 X K_range), F1 values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    F1_curve = zeros(1,size(K_range,2));
    
    for k=K_range
        F1_count = 0;
        for rep=1:repeats
            [labels_pred, ~, ~, ~] = kmeans(X,k,init,type,MaxIter,false);
            [F1_overall, ~, ~, ~] = f1measure(labels_pred,true_labels);
            F1_count = F1_count +F1_overall;
        end
        F1_curve(1,k) = F1_count;
    end
    F1_curve = F1_curve/repeats;
end