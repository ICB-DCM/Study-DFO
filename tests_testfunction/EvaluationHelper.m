classdef EvaluationHelper
    %EVALUATIONHELPER Some helper functions.
    
    properties
    end
    
    methods (Static)
        function [ cell_results_extended ] = f_createResultExtendedList( cell_results )
            n = length(cell_results);
            cell_results_extended = cell(n,1);
            for j=1:n
                cell_results_extended{j} = ResultExtended(cell_results{j});
            end
                
        end
        
        function [ cell_results_best ] = f_extractBestResults(cell_results_all)

            n = length(cell_results_all);
            
            % group by fun+dim+alg
            % we use that the entries are already ordered by fun+dim+alg

            index = 1;
            index_best = 1;
            while index <= n
                grpRes = cell_results_all{index};
                grpName = grpRes.name;
                grpDim = grpRes.dim;
                grpAlg = grpRes.alg;
                grpFval = grpRes.fval;
                index = index + 1;
                while (index <= n)
                    curRes = cell_results_all{index};
                    curName = curRes.name;
                    curDim = curRes.dim;
                    curAlg = curRes.alg;
                    curFval = curRes.fval;
                    if  isequal(grpName,curName) && isequal(grpDim,curDim) && isequal(grpAlg,curAlg) 
                        index = index + 1;
                        if (curFval < grpFval)
                            grpFval = curFval;
                            grpRes = curRes;
                        end
                    else
                        break;
                    end
                end
                cell_results_best{index_best,1} = grpRes;
                index_best = index_best + 1; 
            end
        end
        
        function [ map ] = f_getSolvedShare(cell_results)
            % map for counting successes
            map = containers.Map;
            % map for counting all
            map_total = containers.Map;
            
            nResults = length(cell_results);
            for j=1:nResults
               res = cell_results{j};
               % init keys
               if (~isKey(map_total,res.alg))
                   map_total(res.alg) = 0;
                   map(res.alg) = 0;
               end
               
               % update
               map_total(res.alg) = map_total(res.alg) + 1;
               if (res.fval < res.fbst + C.fval_tolerance)
                   map(res.alg) = map(res.alg) + 1;
               end
            end
            
            % get share
            cell_key = keys(map_total);
            nKeys = length(cell_key);
            for j=1:nKeys
                key = cell_key{j};
                map(key) = map(key) / map_total(key);
            end
        end
        
        function [ map ] = f_getAverageTimePerAlg(cell_results)
            map = containers.Map;
            map_total = containers.Map;
            
            nResults = length(cell_results);
            for j=1:nResults
               res = cell_results{j};
               
               % init keys
               if (~isKey(map_total,res.alg))
                   map_total(res.alg) = 0;
                   map(res.alg) = 0;
               end
               
               % update
               map_total(res.alg) = map_total(res.alg) + 1;
               map(res.alg) = map(res.alg) + res.time;
            end
            
            % get share
            cell_key = keys(map_total);
            nKeys = length(cell_key);
            for j=1:nKeys
                key = cell_key{j};
                map(key) = map(key) / map_total(key);
            end
        end
        
        function [ map ] = f_getAverageFevalsPerAlg(cell_results)
            map = containers.Map;
            map_total = containers.Map;
            
            nResults = length(cell_results);
            for j=1:nResults
               res = cell_results{j};
               
               % init keys
               if (~isKey(map_total,res.alg))
                   map_total(res.alg) = 0;
                   map(res.alg) = 0;
               end
               
               % update
               map_total(res.alg) = map_total(res.alg) + 1;
               map(res.alg) = map(res.alg) + res.funEvals;
            end
            
            % get share
            cell_key = keys(map_total);
            nKeys = length(cell_key);
            for j=1:nKeys
                key = cell_key{j};
                map(key) = map(key) / map_total(key);
            end
        end
        
        function [ cell_results_having ] = f_getAllHaving(cell_results,dim_lb,dim_ub,smooth,convex,unimodal)
            % 0: no, 1: yes, 2: both
            n = length(cell_results);
            index = 1;
            for j=1:n
                res = cell_results{j};
                if ( (smooth == 2 || res.smooth == smooth) ...
                        && (convex == 2 || res.convex == convex)...
                        && (unimodal == 2 || res.unimodal == unimodal)...
                        && res.dim >= dim_lb ...
                        && res.dim <= dim_ub )
                    cell_results_having{index} = res;
                    index = index + 1;
                end
            end
        end
        
    end
    
end

