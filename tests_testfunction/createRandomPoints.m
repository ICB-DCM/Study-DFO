function [ x0s ] = createRandomPoints( lb, ub, num )
% create latin hypercube points

dim = length(lb);

% x0s = zeros(dim,num);
% for j=1:num
%     x0s(:,j) = lb + rand(dim,1).*(ub-lb);
% end

x0s = bsxfun(@plus,lb,bsxfun(@times,ub-lb,lhsdesign(num,dim,'smooth','off')'));

end

