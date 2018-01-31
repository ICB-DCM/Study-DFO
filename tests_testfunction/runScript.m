for gen = 1:2
    
    for noise = {false,true}

        for j = 1:length(C.cell_solvers_local)
            runTests(C.cell_solvers_local{j},C.maxFunEvals{gen},C.nStarts,noise);
        end

        for j = 1:length(C.cell_solvers_global)
            runTests(C.cell_solvers_global{j},C.maxFunEvals{gen},C.nStarts,noise);
        end 
    end
    
end