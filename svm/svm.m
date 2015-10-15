function svm(C,P)
%
%   C How many c you want to do (default 10)
%   P Until what power you want (defaul 5)
%
global p1;
ct=10;
pt=5;
if (nargin == 1)
    ct=C;
end
if (nargin == 2)
    ct=C;
    pt=P;
end
kkk={'linear','poly','rbf'};
load('mydata.mat');
ind = crossvalind('Kfold', 100, 2);
xtr = X(ind ==1,:)
xtest = X(ind ==2,:)
ytr = Y(ind ==1,:)
ytest = Y(ind ==2,:)
nsv = zeros(100);
%alpha = zeros(10,50);
bias = zeros(100);
%predY = zeros(10,50);
lerr = zeros(100);
perr = zeros(ct*pt,1);
psvn = zeros(ct*pt,1);
pbias = zeros(ct*pt,1);
rerr = zeros(ct*pt,1);
rsvn = zeros(ct*pt,1);
rbias = zeros(ct*pt,1);
for indi = 1:length(kkk)
    switch kkk{indi}
        %case 'linear'
        %    for c = 1:100
        %        [nsv(c),alpha,bias(c)] = svc(xtr,ytr,'linear',c);
        %        %predY = svcoutput(xtr,ytr,xtest,'linear',alpha,bias(c));
        %        lerr(c) = svcerror(xtr,ytr,xtest,ytest,'linear',alpha,bias(c))
        %    end
        case 'poly'
            n=1;
            for c = 1:ct
                for p=1:pt
                    p1 = p;
                    [pnsv(n),alpha,pbias(n)] = svc(xtr,ytr,'poly',c);
                    %predY = svcoutput(xtr,ytr,xtest,'poly',alpha,bias(c));
                    perr(n) = svcerror(xtr,ytr,xtest,ytest,'poly',alpha,pbias(n))
                    n = n+1;
                end
            end            
        case 'rbf'
            n=1;
            for c = 1:ct
                for p=1:pt
                    p1 = p;
                    [rnsv(n),alpha,rbias(n)] = svc(xtr,ytr,'rbf',c);
                    %predY = svcoutput(xtr,ytr,xtest,'rbf',alpha,bias(c));
                    rerr(n) = svcerror(xtr,ytr,xtest,ytest,'rbf',alpha,rbias(n))
                    n=n+1;
                end
            end
    end
end
end