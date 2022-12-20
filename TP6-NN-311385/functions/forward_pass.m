function [Y, A, Z] = forward_pass(X, W, W0, Sigmas)
%FORWARD_PASS This function calculate the forward pass of the network with
%   inputs:
%       o X (NxM) The input data
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o Y (PxM) The output of the network, result of the activation
%       function of the last layer
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contain the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer
    disp('In Forward_pass function')
    S = length(Sigmas);
    
    A = cell(S+1,1);
    Z = cell(S,1);
    
    A(1)={X};
    for i=1:S
        Z(i) = {W{i}*A{i}+W0{i}};
        A(i+1) = {forward_activation(Z(i),Sigmas(i))};
    end
    
    Y=A{(size(A,1))};
end