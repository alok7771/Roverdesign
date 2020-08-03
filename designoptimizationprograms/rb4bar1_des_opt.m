
  % Analysis of Rocker Bogie suspension
 function [mu,smin,lb,ub,exitflag,output,lambda,grad,hessian]=rb4bar1_des_opt(s)
R1=s(1:15);N1=s(16:30); R2=s(31:45); N2=s(46:60);R3=s(61:75);N3=s(76:90); 
F1=s(91:105); F2=s(106:120);F3=s(121:135);F4=s(136:150);
F5=s(151:165);F6=s(166:180);F7=s(181:195);F8=s(196:210);
theta1f=s(211:215); theta2f=s(216:220); theta1m= s(221:225); theta2m=s(226:230); phiAC= s(231:235); theta2r=s(236:240); 
phiHI= s(241:245);gamma=s(246); alfa9=s(247); alfa10=s(248); L1=s(249); L2=s(250); L3=s(251); L4=s(252); L5=s(253);L7=s(254);
L9=s(255); L10=s(256); 
Xgg2_loc=s(257); Ygg2_loc=s(258);
phi=s(259); z=s(260); mu=s(261);

 r1=0.075;
SH=2*r1*1.5;

%[XY,beta1,beta2,beta3]= point_positions_opt(s);
%[cineq, ceq]= roverconstrDesOpt(s);
                % upper and lower  bounds for 261 variables
lb(1:15)=0;lb(16:30)=-Inf;lb(31:45)=0;lb(46:60)=-Inf;lb(61:75)=0;lb(76:90)=-Inf;lb(91:210)=-Inf;
lb(211:230)=-Inf; lb(231:235)=0.1; lb(236:240)=-Inf;lb(241:245)=0.1;lb(246)=-2;lb(247:248)=0.7853;
lb(249)=0.1; lb(250)=0.1;lb(251)=0.03;lb(252)=0.03;lb(253)=0.03;lb(254)=0.075;lb(255)=0.2;lb(256)=0.15;
lb(257)=-0.1;lb(258)=-0.1;lb(259)=0; lb(260)=0; lb(261)=-Inf;
lb=lb';


ub(1:15)=Inf;ub(16:30)=Inf;ub(31:45)=Inf; ub(46:60)=Inf; ub(61:75)=Inf; ub(76:90)=Inf;ub(91:210)=Inf;
ub(211:230)=Inf; ub(231:235)=2; ub(236:240)=Inf;ub(241:245)=3;ub(246)=-0.1;ub(247:248)=1.5707;
ub(249)=0.4; ub(250)=0.4;ub(251)=0.1;ub(252)=0.1;ub(253)=0.1;ub(254)=0.175;ub(255)=0.75;ub(256)=0.4;ub(257)=0.1;ub(258)=0.1;
ub(259)=1.5707; ub(260)=1; ub(261)=Inf;
ub=ub';


options=optimset('Display','iter','MaxFunEvals',50000,'MaxIter',50000,'Algorithm','sqp');
%options=optimset('Display','iter','MaxFunEvals',50000,'MaxIter',50000,'Algorithm','trust-region-reflective');
options=optimset(options,'GradConstr', 'off', 'GradObj','off');
tol=1e-18;
options.TolFun= tol; options.TolCon=tol; 
options.TolX=tol; 
options.TolGradFun= tol;options.TolGradCon=tol;
%options.TolConSQP=tol;options.TolGradCon=tol; options.TolPCG=tol;
%options.TolProjCG=tol; options.TolProjCGAbs=tol; options.TolRLPFun=tol; options.TolXInteger=tol;
 options.Display='iter';
% options.MaxFunEvals=20000;
% options.MaxIter=20000;
              
%keyboard
[smin,fval,exitflag,output,lambda,grad,hessian] = fmincon(@obj_fn,s,[],[],[],[],lb,ub,@roverconstrDesOpt,options);


mu=smin(261);

exitflag


end


