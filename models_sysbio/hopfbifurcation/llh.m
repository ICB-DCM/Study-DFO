function [ varargout ] = llh(x, D, simfun)

amiOptions = amioption;
amiOptions.sensi_meth = 'forward';

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

