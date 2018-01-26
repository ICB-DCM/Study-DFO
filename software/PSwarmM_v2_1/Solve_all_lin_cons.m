function solve_all()

problems = char('antenna2', 'avgasa', 'avgasb', 'bc4', 'biggsc4',...
    'bunnag1','bunnag2','bunnag3','bunnag4','bunnag5',...
    'bunnag6','bunnag7','bunnag8','bunnag9','bunnag10','bunnag11',...
    'bunnag12','bunnag13', 'ex2_1_1', 'ex2_1_10', 'ex2_1_2',...
    'ex2_1_3', 'ex2_1_4', 'ex2_1_5', 'ex2_1_6', 'ex2_1_7', 'expfita',...
    'expfitb', 'expfitc', 'fir_linear', 'g01', 'genocop07', 'genocop09',...
    'genocop10', 'genocop11', 'goffin', 'gtm', 'hatfldh', 'himmelbi',...
    'hs021', 'hs024', 'hs035', 'hs036', 'hs037', 'hs044', 'hs076',...
    'hs086', 'hs118', 'hs21mod', 'hs268', 'hs35mod', 'hs44new',...
    'hubfit', 'Ji1', 'Ji2', 'Ji3', 'ksip', 'liswet1', 'liswet10',...
    'liswet11', 'liswet12', 'liswet2', 'liswet3', 'liswet4', 'liswet5',...
    'liswet6', 'liswet7', 'liswet8', 'liswet9', 'lowpass', 'lsqfit',...
    'makela4', 'Michalewicz1', 'nuffield_continuum', 'oet1', 'oet3',...
    'pentagon', 'powell20', 'pt', 's224', 's231', 's232', 's250',...
    's251', 's253', 's268', 's277', 's278', 's279', 's280', 's331',...
    's340', 's354', 's359', 's392', 'simpllpa', 'simpllpb', 'sipow1',...
    'sipow1m', 'sipow2', 'sipow2m', 'sipow3', 'sipow4', 'stancmin',...
    'structure2', 'tfi2', 'weapons', 'yao', 'zecevic2');


%problems = char('avgasa');

[nprobs,xx]=size(problems);

nl_path='.\models\';



for j=1:1 % ten runs
    for i=1:nprobs % for all problems
%        try
            disp(problems(i,:));
            [x,fx,nfo,deg,nit,npoll,spoll,nModels,RBFSuc]=RunPSwarm(strcat(nl_path,problems(i,:)),2000);
            fid=fopen(strcat('results_pswarm',num2str(j),'.tex'),'a');
            fprintf(fid,'%s & %d & %d & %d & %d & %d & %d & %d & %d\\\\\n', problems(i,:), nfo, fx, deg, nit, npoll, spoll,nModels,RBFSuc);
            fclose(fid);
%        catch
%            fid=fopen(strcat('results_pswarm',num2str(j),'.tex'),'a');
%            fprintf(fid,'%s & --- & --- & --- & --- & --- & --- & --- & ---\\\\\n', problems(i,:));
%            fclose(fid);
%        end
    end
end
