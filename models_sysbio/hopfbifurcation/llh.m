function [ varargout ] = llh(x, D, simfun)

amiOptions = amioption;
amiOptions.sensi_meth = 'forward';
% amiOptions.atol = 1e-8;
% amiOptions.rtol = 1e-6;
% amiOptions.maxsteps = 1e5;

switch nargout
    case 1
        amiOptions.sensi = 0;
        llh = 0;
    case 2
        amiOptions.sensi = 1;
        llh = 0;
        sllh = 0;
end

nr = size(D.Y,3);
for jr = 1:nr
    clear amiData
    amiData.t = D.t;
    amiData.Y = D.Y(:,:,jr);
    amiData.condition = D.k;
    amiData = amidata(amiData);

    sol = simfun([],x,[],amiData,amiOptions);
    
    if sol.status ~= 0
        error('i to pi: be rational. pi to i: be real.');
    end
    
    llh = llh + sol.llh;
    if nargout > 1
        sllh = sllh + sol.sllh;
    end
end

varargout{1} = llh;
if nargout > 1
    varargout{2} = sllh;
end

end

