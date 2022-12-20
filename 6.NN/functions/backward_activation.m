function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function
    disp('In Backward_activation function')
    
    k = 0.01;
    if strcmp(Sigma, 'sigmoid')
        dZ = exp(-Z)./(1 + exp(-Z)).^2;
    elseif strcmp(Sigma, 'tanh')
        dZ = 1 - (exp(-Z) - exp(Z)).^2./(exp(-Z) + exp(Z)).^2;
    elseif strcmp(Sigma, 'relu')
        A=max(0,Z);
        dZ=diff(A);
    elseif strcmp(Sigma, 'leakyrelu')
        A=max(k*Z,Z);
        dZ=diff(A);
    else 
        disp('This type of activation function is not supported')
    end
end