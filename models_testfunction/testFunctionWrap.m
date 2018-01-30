function [fval] = testFunctionWrap(fun,x)

fval = fun(x);

global y_arr_fval_trace;
y_arr_fval_trace = [y_arr_fval_trace fval];

global y_time_start;
time_now = cputime;
if time_now - y_time_start > C.maxTime
    error('testFunctionWrap: time is up');
end

end