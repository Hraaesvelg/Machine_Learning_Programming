clc;
clear;


% PATH
addpath("functions/part1")
addpath("functions/part3")
addpath("evaluation_functions/part1")
addpath("plot_functions")

% data loading
table = readtable("data/cryptocurrencies_prices.csv");
data = table2array(table)';

X = zeros(size(data(:,:)));
normalization = "Xmax";



if (normalization == "minmax" | normalization == "Xmax" )
    X(:,:) = (data - min(min(data)))/(max(max(data))-min(min(data)));
    param1 = min(min(data));
    param2 = max(max(data));
elseif(normalization == "zscore" | normalization == "std" )
    X = (data - mean(data, "all"))/std(data,0,"all");
    param1 = mean(data, "all");
    param2 = std(data,0,"all");    
elseif(normalization == "none" | normalization == 0)
    X = data;
    param1 = 0;
    param2 = 0;
else
    disp('You are using a normalization not supported by the programm')
end

