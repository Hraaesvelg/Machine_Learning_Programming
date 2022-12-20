clear

addpath(genpath("functions/part1"))


k = 4;

te = [4,5,3;5,3,2]
te(1,:)
sum(te,2)

Mu = [7.154260293367147,2.134663330874254,0.651695443446269,6.556145642069592;2.007448240009173,0.644054482129262,-4.660150524363638,1.884927205977923];
Mu_init = rand(2,4)*10;

norm(Mu - Mu_init)

diff = Mu - Mu_init


function [dist] = muNorm(Mu,Mu_previous)
    count = 0;
    for i=1:size(Mu,2)
        count = compute_distance(Mu(:,i),Mu_previous(:,i), 'L2');
    end 
    dist = count/size(Mu,2);
end