function [fx] = degenerate(x)

c = ones(length(x),1);
fx = (x-c)'*(x-c)/2;
return
