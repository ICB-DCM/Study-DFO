f = inline('x^3 + y^3 - 10*(x^2 + y^2)','x','y');
X = linspace(-5,10,101)';
Y = linspace(-5,10,101)';
for i = 1:length(X)
    for j = 1:length(Y)
        Z(i,j) = f(X(i),Y(j));
    end
end
surf(X,Y,Z);
