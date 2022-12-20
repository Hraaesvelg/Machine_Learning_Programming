function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (height x width x 3), an image of size height x width over RGB channels
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x width x 3) The projection of the image on the eigenvectors
%       o ApList : (p x height x 3) The projection matrices for each channels
%       o muList : (height x 3) The mean vector for each channels

    cimg = zeros(p,size(img,2),3);
    ApList = zeros(p,size(img,1),3);
    muList = zeros(size(img,1),3);
    for i=1:3
        img1col = img(:,:,i);
        [Mu, ~, EigenVectors, ~] = compute_pca(img1col);
        [Yproj, Ap] = project_pca(img1col, Mu, EigenVectors, p);
        cimg(:,:,i) = Yproj;
        ApList(:,:,i) = Ap;
        muList(:,i) = Mu;
    end

end

