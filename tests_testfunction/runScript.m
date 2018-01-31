maxFunEvals = 500;
starts = C.nStarts;
noise = false;

for j = 1:length(C.cell_solvers_local)
    runTests(C.cell_solvers_local{j},C.maxFunEvals{1},C.nStarts,noise);
end