function [ x0s ] = createUniformRandomPoints( lb, ub, num )
% CREATERANDOMPOINTS creates uniformly distributed random points within
% bounds

% initialize the random number generator in order to have, for given
% dimension, bounds and number of starting points, always the same set of
% starting points
rng('default');
rng(0);

dim = length(lb);

x0s = zeros(dim,num);
for j=1:num
    x0s(:,j) = lb + rand(dim,1).*(ub-lb);
end

end

