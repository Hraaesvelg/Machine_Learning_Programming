function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match Yd
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error
    disp('In cost_function')

    [~, M]= size(Y);

    if strcmp(type, 'LogLoss')
        E = 0;
        for i=1:M
            E =+ Yd(i)*log(Y(i)) + (1-Yd(i)*log(Y(i))); 
        end
        E = -1/M * E;
    else
        disp('This type of cost function is not supported')
    end

end