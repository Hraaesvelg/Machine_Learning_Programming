function [dZ, dW, dW0] = backward_pass(dE, W, A, Z, Sigmas)
%BACKWARD_PASS Perform a backward propogation through
%   inputs:
%       o dE (PxM) The derivative dE/dZL
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o b {Lx1} cell array containing the bias matrices for all the
%       layers
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contains the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o dZ {Lx1} cell array containing the derivatives dE/dZl values at
%       each layer
%       o dW {Lx1} cell array containing the derivatives of the weights at
%       each layer
%       o dW0 {Lx1} cell array containing the derivatives of the bias at
%       each layer
S = length(Sigmas);
dZ = cell(S, 1);
dW = cell(S, 1);
dW0 = cell(S, 1);
for i=S:-1:1
    if(i==length(Sigmas))
        dZ(length(Sigmas))={dE};
    else
        dZ(i)={transpose(W{i+1})*dZ{i+1}.*backward_activation(Z{i},Sigmas{i})};
    end

    dW(i)={(1/length(Sigmas))*dZ{i}*transpose(A{i})};
    dW0(i)={30};
end


end