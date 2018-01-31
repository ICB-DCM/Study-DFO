function [fval] = testFunWrap(fun,maxFunEvals,starttime,x)


global y_arr_fval_trace;
global y_feval_counter;
global y_fbst;
global y_xbst;
global y_flag_time;
global y_flag_fevals;

fval = fun(x);

y_arr_fval_trace = [y_arr_fval_trace fval];
y_feval_counter = y_feval_counter + 1;

if fval < y_fbst
    y_fbst = fval;
    y_xbst = x;
end

% check termination criteria
ischover = false;
time_now = cputime;
if time_now - starttime > C.maxTime 
    y_flag_time = 1;
    ischover = true;
end
if y_feval_counter >= maxFunEvals
    y_flag_fevals = 1;
    ischover = true;
end
   
if ischover
    error('y:stop','testFunctionWrap: early stopping');
end

end