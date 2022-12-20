function [A] = forward_activation(Z, Sigma)
%FORWARD_ACTIVATION Compute the value A of the activation function given Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%
%   outputs:
%       o A (NXM) value of the activation function
    disp('In Forward_activation function')
    
    k = 0.01;
    Z = Z{1};
    if strcmp(Sigma, 'sigmoid')
        A = 1./(1+exp(-Z));
    elseif strcmp(Sigma, 'tanh')
        A = (exp(Z) - exp(-Z))./(exp(Z) + exp(-Z));
    elseif strcmp(Sigma, 'relu')
        A = max(0,Z);
    elseif strcmp(Sigma, 'leakyrelu')
        A = max(k*Z,Z);
    else 
        disp('This type of activation function is not supported')
    end
end