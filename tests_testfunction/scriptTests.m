solvers_local = C.cell_solvers_local;
for j = 1:length(solvers_local)
	if ~ismember(solvers_local{j},{'gps','gss','mads'})
		runTests(solvers_local{j},2000,20,false);
		clear;
	end
end
solvers_global = C.cell_solvers_global;
for j = 1:length(solvers_global)
	if ~ismember(solvers_global{j},{'ga','particleswarm'})
		runTests(solvers_global{j},2000,20,false);
		clear;
	end
end
