function [fval] = testFunctionWrapper(fun,x)

fval = fun(x);

global y_arr_fval_trace;
y_arr_fval_trace = [yarr_fval_trace fval];

end