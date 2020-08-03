%load smin198;
smin;
load lbub;
[cineq, ceq]= roverconstrDesOpt(smin);
ep1=1e-5;
if(max(abs(ceq))>=ep1)
    disp('equality constraints are not satisfied')
    return
end
if(max(cineq)>=ep1)
    disp('all inequality constraints are not satisfied')
    return
end
if(max(lb-smin)>=ep1)
    disp('some lb is violated')
    return
end
if(max(smin-ub)>=ep1)
    disp('some ub is violated')
    return
end
indexing= find(abs(cineq)<=ep1);
indexinglb= find(abs(smin-lb) <= ep1);
indexingub= find(abs(ub-smin) <= ep1);

ep2=1*10^-5;
gradceq=[]; gradcineq=[];
for i=1:261
    s=smin;
    s(i)=s(i)+ep2;
    [cineqp,ceqp]= roverconstrDesOpt(s);
    s(i)=s(i)-2*ep2;
    [cineqm,ceqm]= roverconstrDesOpt(s);
    gradceq=[gradceq (ceqp-ceqm)/(2*ep2)];
    gradcineq=[gradcineq (cineqp-cineqm)/(2*ep2)];
end
%gradient of obj fn.%
delf(261,1)=1;
ilb= size(indexinglb);
gradlb= zeros(261,ilb(1)); 
i=0;
while (i~=ilb(1))
    gradlb(indexinglb(i+1),(i+1))=-1;
    i=i+1;

end

iub= size(indexingub);
gradub= zeros(261,iub(1));
j=0;
while (j~=iub(1))
    gradub(indexingub(j+1),(j+1))=+1;
    j=j+1;
end

gradcineq= [gradcineq(indexing,:)]';

A=[gradlb gradub gradceq' gradcineq];

lambda= pinv(A'*A)*A'*delf;
%lambda= (1./(A'*A))*A'*delf;
norm_lambda=norm(A*lambda-delf);