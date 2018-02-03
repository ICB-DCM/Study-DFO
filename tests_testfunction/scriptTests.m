solvers_local = C.cell_solvers_local;
for j = 1:length(solvers_local)
    runTests(solvers_local{j},2000,20,false);
    clear;
end
solvers_global = C.cell_solvers_global;
for j = 1:length(solvers_global)
    runTests(solvers_global{j},2000,20,false);
end
