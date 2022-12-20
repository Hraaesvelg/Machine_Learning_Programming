function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization

    X = zeros(size(data));
    param1 = zeros(size(data,1),1);
    param2 = zeros(size(data,1),1);
    for i=1:size(X,1)
        if (normalization == "minmax" | normalization == "Xmax" )
            param1(i) = min(data(i,:));
            param2(i) = max(data(i,:));
            X(i,:) = (data(i,:) - param1(i))/(param2(i)-param1(i));
        elseif(normalization == "zscore" | normalization == "std" )
            param1(i) = mean(data(i,:));
            param2(i) = std(data(i,:),0);
            X(i,:) = (data(i,:) - param1(i))/param2(i);
        elseif(normalization == "none" | normalization == 0)
            X(i,:) = data(i,:);
            param1(i) = 0;
            param2(i) = 0;
        else
            disp('You are using a normalization not supported by the programm')
        end
    end
end

