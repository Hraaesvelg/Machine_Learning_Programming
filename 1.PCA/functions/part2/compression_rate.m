function [cr, compressedSize] = compression_rate(img,cimg,ApList,muList)
%COMPRESSION_RATE Calculate the compression rate based on the original
%image and all the necessary components to reconstruct the compressed image
%
%   input -----------------------------------------------------------------
%       o img : The original image   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o cr : The compression rate
%       o compressedSize : The size of the compressed elements


cr = 1 - (numel(cimg)+numel(ApList)+numel(muList))/numel(img);
compressedSize = (whos('cimg').bytes + whos('ApList').bytes+ whos('muList').bytes)*8; 

% convert the size to megabits
compressedSize = compressedSize / 1048576; 

end

