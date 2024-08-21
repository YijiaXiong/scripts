X = [mvnrnd(mu1,Sigma1,1000);mvnrnd(mu2,Sigma2,1000)];
xx=X(:,1);

gmdist = fitgmdist(xx, 2);
gmsigma = sqrt( gmdist.Sigma); %fitgmdist was designed for multivariate distribution so the Sigma are covariance. 
%since we are using it to fit for one variate data, the sigma should be
%the sqrt of the Sigma.
gmmu = gmdist.mu;
gmwt = gmdist.ComponentProportion;
x = min(xx):0.001:max(xx); 
p = pdf('Normal', x, gmmu(1), gmsigma(1));
q = pdf('Normal', x, gmmu(2), gmsigma(2));
histogram(xx,20, 'Normalization', 'pdf') %, 'EdgeColor', 'none')
xlim([0,8])
hold on;
plot(x, pdf(gmdist, x'), 'r','LineWidth',2)

plot(x, p*gmwt(1),'g--','LineWidth',2)
plot(x, q*gmwt(2),'b--','LineWidth',2)
hold off;