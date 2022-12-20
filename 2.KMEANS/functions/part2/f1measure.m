function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M= size(cluster_labels,2);
nClasses = max(class_labels);
nClusters = max(cluster_labels);

ci= zeros(nClasses,1);
K =zeros(nClusters,1);
for i=1:nClasses
    ci(i) = length(find(class_labels==i)); 
end
for i=1:nClusters
    K(i) = length(find(cluster_labels==i));
end

lbl_cluster= unique(cluster_labels);
lbl_class=unique(class_labels);

P=zeros(nClusters,nClasses);
R=zeros(nClusters,nClasses);
F1=zeros(nClusters,nClasses);
F1_overall=0;

%initialisation

 for i=1:nClasses
     for j=1:nClusters
         Nik=0;
         for m=1:M
            if (cluster_labels(m)==lbl_cluster(j)&&class_labels(m)==lbl_class(i))
              Nik=Nik+1;
            end
         end
      P(j,i)=Nik/K(j);   
      R(j,i)=Nik/ci(i); 
      F1(j,i)=2*R(j,i)*P(j,i)/(R(j,i)+P(j,i));
     end
     F1_compared = max(F1(:,i));
     F1_overall = F1_overall+ci(i)/M*F1_compared;
 end
 
NAN_el = isnan(F1);
F1(NAN_el) = 0;

end
