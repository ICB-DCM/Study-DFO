%*********************************************************************
% exampleP_N:  User-supplied function defining set of neighbors for a
%             a given vector of categorical variables p.
% --------------------------------------------------------------------
%   Variables:
%     iterate = iterate for whom discrete neighbor point will be found.
%     plist   = cell array of possible p values: p{i}{j}, i = variable, j = list
%     Problem = structure holding Omega(p)
%     N       = vector of iterates who are neighbors of p.
%*********************************************************************
function N = exampleP_N(Problem,iterate,plist,delta)

N(1).x = iterate.x;
for k = 1:length(iterate.p)
   N(1).p{k} = ~iterate.p{k};
end
return
