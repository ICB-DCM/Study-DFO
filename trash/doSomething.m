function [] = doSomething()

global ylist;
ylist = [];
wrapper(1);
wrapper(2);
wrapper(3);

disp(ylist);

end

