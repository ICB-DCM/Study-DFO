function [fx] = degenerate0(x)

c = zeros(length(x),1);
fx = (x-c)'*(x-c)/2;
return
