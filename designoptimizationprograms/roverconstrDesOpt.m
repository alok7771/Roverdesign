function [cineq, ceq]= roverconstrDesOpt(s)


R1=s(1:15);N1=s(16:30); R2=s(31:45); N2=s(46:60);R3=s(61:75);N3=s(76:90); 
F1=s(91:105); F2=s(106:120);F3=s(121:135);F4=s(136:150);
F5=s(151:165);F6=s(166:180);F7=s(181:195);F8=s(196:210);
L1=s(249); L2=s(250); L3=s(251); L4=s(252); L7=s(254); L9=s(255); L10=s(256); Xgg2_loc=s(257); Ygg2_loc=s(258);

L5=s(253); mu=s(261);

% ro1=5.792092809768779; ro6= -2.340478697140846; ro2=  4.137725370483302;%FW butt
% ro3=0; ro5=0;        %%%%%%%%%old ro values%%%%%%%%
% ro4=4; ro7=5; ro8=6;

% ro1=6; ro6= 6; ro2= 6;%design opt values%
% ro3=4; ro5=4;
% ro4=6; ro7=6; ro8=6;

ro1=0; ro6= 0; ro2= 0;%design opt values%
ro3=0; ro5=0;
ro4=0; ro7=0; ro8=0;

m1= 1.5; m2= 1.5; m3= 1.5;g=10; 
%F17=  13.784475000000000*10;
F17=14*10;

r1= 0.075; r2= 0.075; r3= 0.075; %wheel radius%
SH=2*r1*1.5; %step height%



%[XY,beta1,beta2,beta3]= point_positions(s);
[XY,beta1,beta2,beta3]= point_positions_opt(s);

Xa=XY(:,1);     Ya=XY(:,2);
Xb=XY(:,3);     Yb=XY(:,4);
Xc=XY(:,5);     Yc=XY(:,6);
Xd=XY(:,7);     Yd=XY(:,8);
Xe=XY(:,9);     Ye=XY(:,10);
Xf=XY(:,11);    Yf=XY(:,12);
Xg=XY(:,13);    Yg=XY(:,14);
Xh=XY(:,15);    Yh=XY(:,16);
Xi=XY(:,17);    Yi=XY(:,18);
Xg2=XY(:,19);   Yg2=XY(:,20);
Xp=XY(:,21);    Yp=XY(:,22);
Xq=XY(:,23);    Yq=XY(:,24);
Xr=XY(:,25);    Yr=XY(:,26);

%CG location for each link
XL1G= Xa+ 0.5*(Xc-Xa); 
XL2G= Xb+0.5*(Xd-Xb);
XL6G= Xc+0.5*(Xd-Xc);
XL3G= Xc+0.5*(Xe-Xc);
XL4G= Xe+0.5*(Xf-Xe);
XL5G= Xf+0.5*(Xd-Xf);
XL7G= Xi+0.5*(Xg-Xi);
XL8G= Xg+0.5*(Xh-Xg);



% CG force on each link
% F9= sqrt((Xc-Xa).^2+(Yc-Ya).^2)*ro1*g;
% F10= sqrt((Xd-Xc).^2+(Yd-Yc).^2)*ro6*g;
% F11= sqrt((Xd-Xb).^2+(Yd-Yb).^2)*ro2*g;
% F12= sqrt((Xe-Xc).^2+(Ye-Yc).^2)*ro3*g;
% F13= sqrt((Xd-Xf).^2+(Yd-Yf).^2)*ro5*g;
% F14= sqrt((Xf-Xe).^2+(Yf-Ye).^2)*ro4*g;
% F15= sqrt((Xg-Xi).^2+(Yg-Yi).^2)*ro7*g;
% F16= sqrt((Xg-Xh).^2+(Yg-Yh).^2)*ro8*g;

L6=sqrt((Xd-Xc).^2+(Yd-Yc).^2);
L8=sqrt((Xg-Xh).^2+(Yg-Yh).^2);
F9= L1*ro1*g;
F10= L6(1)*ro6*g;
F11= L2*ro2*g;
F12= L3*ro3*g;
F13= L5*ro5*g;
F14= L4*ro4*g;
F15= L7*ro7*g;
F16= L8(1)*ro8*g;



% Equalities related to equilibrium eqautions, 180 in number
ceq= R1.*cos(beta1+pi/2)+N1.*cos(beta1)+R2.*cos(beta2+(pi/2))+N2.*cos(beta2)+F1+F3;
ceq= [ceq; R1.*sin(beta1+pi/2)+N1.* sin(beta1)+R2.*sin(beta2+(pi/2))+N2.* sin(beta2)+F2+F4-(m1*g+m2*g+F9+F10+F11)];
ceq= [ceq; R1.*(sin(beta1+(pi/2)).*Xp-cos(beta1+(pi/2)).*Yp)+ N1.*(sin(beta1).*Xp-cos(beta1).*Yp)+ R2.*(sin(beta2+(pi/2)).*Xq-cos(beta2+(pi/2)).*Yq)+N2.*(sin(beta2).*Xq-cos(beta2).*Yq)-F1.*Yc+F2.*Xc-F3.*Yd+F4.*(Xd)-(m1*g*Xa+m2*g*Xb+F9.*XL1G+(F10).*(XL6G)+F11.*XL2G)];
ceq= [ceq; -F1+F5];
ceq= [ceq; -F2-F12+F6];
ceq= [ceq; F1.*Yc-F2.*Xc-F12.*XL3G+F6.*Xe-F5.*Ye];
ceq= [ceq; -F3+F7];
ceq= [ceq; -F4-F13+F8];
ceq= [ceq; F3.*Yd-F4.*Xd-F13.*XL5G+F8.*Xf-F7.*Yf];
ceq= [ceq; -F5-F7+R3.*cos(beta3+(pi/2))+N3.*cos(beta3)];
ceq= [ceq; -F6-F14-F8-F15-F16-F17+R3.*sin(beta3+(pi/2))+N3.*sin(beta3)-m3*g];
ceq= [ceq; F5.*Ye-F6.*Xe-F14.*XL4G-F8.*Xf+F7.*Yf-F15.*XL7G-F16.*XL8G-F17.*Xg2+R3.*(sin(beta3+(pi/2)).*Xr-cos(beta3+(pi/2)).*Yr)+N3.*(sin(beta3).*Xr-cos(beta3).*Yr)-m3*g*Xh];

%Equalities related to geometry
ceq= [ceq; L5-sqrt(((Xd-Xf).^2+(Yd-Yf).^2))]; %15 equalities
ceq= [ceq; Yh(1:10)-r3]; %10 equalities
ceq= [ceq; Ya(11:15)-(SH+r1); Yb(11:15)-(SH+r2)]; %10 equalities
ceq=[ceq; Xgg2_loc; Ygg2_loc];

%Inequalities
cineq= [-N1-mu*R1; N1-mu*R1; -N2-mu*R2; N2-mu*R2; -N3-mu*R3; N3-mu*R3]; %90 inequalities
%cineq= [-N1-mu*R1  N1-mu*R1  -N2-mu*R2  N2-mu*R2  -N3-mu*R3  N3-mu*R3] %90 inequalities
cineq=[cineq; Xh(1)-Xa(1)-0.5625];
cineq=[cineq; Xa-Xb-0; Xb-Xh-0];%%30 inequalities%%
cineq=[cineq; r3-Xh(6:10);r2-Xb(1:5)];
cineq=[cineq; 0.293760731297352-Yg(1)];
cineq=[cineq; 0.05-sqrt((Xd-Xc).^2+(Yd-Yc).^2)];




            
end
