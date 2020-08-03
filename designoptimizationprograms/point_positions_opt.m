function [XY,beta1,beta2,beta3,Xc,Xd,Yc,Yd,Yg]= point_positions_opt(s)
%
%Inputs:
% s : []
%
%Outputs
% XY : 15x26 matrix. Columns are Xa,Ya,Xb,Yb,Xc,Yc,Xd,Yd,Xe,Ye,Xf,Yf,Xg,Yg,Xh,Yh,Xi,Yi,Xg2,Yg2,Xp,Yp,Xq,Yq,Xr,Yr

theta1f=s(211:215); theta2f=s(216:220); theta1m= s(221:225); theta2m=s(226:230); phiAC= s(231:235); theta2r=s(236:240); phiHI= s(241:245);
gamma=s(246); alfa9=s(247); alfa10=s(248); L1=s(249); L2=s(250); L3=s(251); L4=s(252); L7=s(254); L9=s(255); L10=s(256); 
 phi=s(259); z=s(260); mu=s(261);
Xgg2_loc=s(257); Ygg2_loc=s(258);
 
beta1=-90*pi/180; beta2=0*pi/180; beta3=0*pi/180; %deg to rad%
r1= 0.075; r2= 0.075; r3= 0.075; %wheel radius%
SH=2*r1*1.5; %step height%
    
Xaf1=r1;
Yaf1=r1;

Ybf1=r2;
argf1=(L10)^2-(Ybf1-Yaf1).^2;
if (argf1<0)
    disp('argf1 is neg')
    keyboard
end
Xbf1= sqrt(argf1)+Xaf1;                 
%phiABf1= pi+atan2((Ybf1-Yaf1),(Xbf1-Xaf1));
phiABf1= atan2((Ybf1-Yaf1),(Xbf1-Xaf1));

%Xcf1= Xaf1+L1*cos(alfa9+phiABf1+pi); 		Ycf1= Yaf1+L1*sin(alfa9+phiABf1+pi);
Xcf1= Xaf1+L1*cos(alfa9+phiABf1); 		Ycf1= Yaf1+L1*sin(alfa9+phiABf1);
%Xdf1= Xbf1+L2*cos(phiABf1-alfa10); 	Ydf1= Ybf1+L2*sin(phiABf1-alfa10);
Xdf1= Xbf1+L2*cos(phiABf1+pi-alfa10); 	Ydf1= Ybf1+L2*sin(phiABf1+pi-alfa10);
Xef1= Xcf1+L3*cos(theta2f(1)-pi); 		Yef1= Ycf1+L3*sin(theta2f(1)-pi);
Xff1= Xef1+L4*cos(theta1f(1));           Yff1= Yef1+L4*sin(theta1f(1));
Xif1= Xef1+z*(Xff1-Xef1);               Yif1= Yef1+z*(Yff1-Yef1);
Xgf1= Xif1+L7*cos(theta1f(1)+phi); 		Ygf1= Yif1+L7*sin(theta1f(1)+phi);
psi_loc=atan2(Ygg2_loc,Xgg2_loc);
theta_loc=2*pi-(atan2((Ygf1-Yif1),(Xgf1-Xif1))+pi);
psi=psi_loc+theta_loc;
argf2=Xgg2_loc^2+Ygg2_loc^2;
if (argf2<0)
    disp('argf2 is neg')
    keyboard
end
Lgg2=sqrt(argf2);



%values of all co cordinates with respect to global frame of reference%

Xwc= [r1 r1 r1 r1*cosd(45) 0]';
Ywc= [r1 r1+(SH-r1)/2 SH SH+r1*sind(45) SH+r1]';


%front wheel climbing

beta1=[-90 -90 -90 -45 0]';
beta2=[0 0 0 0 0]';
beta3=[0 0 0 0 0]';
beta1=beta1*pi/180; beta2=beta2*pi/180; beta3=beta3*pi/180; %deg to rad%



Xaf=Xwc;
Yaf=Ywc;

Ybf=[r2,r2,r2,r2,r2]';
argm1=(L10)^2-(Ybf-Yaf).^2;
if (argm1<0)
    disp('argm1 is neg')
    keyboard
end
Xbf= sqrt(argm1)+Xaf;                 
phiABf= pi+atan2((Ybf-Yaf),(Xbf-Xaf));
Xcf= Xaf+L1*cos(alfa9+phiABf+pi); 		Ycf= Yaf+L1*sin(alfa9+phiABf+pi);

Xdf= Xbf+L2*cos(phiABf-alfa10); 	Ydf= Ybf+L2*sin(phiABf-alfa10);

Xef= Xcf+L3*cos(theta2f-pi); 		Yef= Ycf+L3*sin(theta2f-pi);
Xff= Xef+L4*cos(theta1f);           Yff= Yef+L4*sin(theta1f);
Xif= Xef+z*(Xff-Xef);               Yif= Yef+z*(Yff-Yef);
Xgf= Xif+L7*cos(theta1f+phi); 		Ygf= Yif+L7*sin(theta1f+phi);
Xhf= Xif+L9*cos(gamma+theta1f); 	Yhf= Yif+L9*sin(gamma+theta1f);
Xg2f= Xgf+Lgg2*cos(theta1f+phi+pi+psi);Yg2f= Ygf+Lgg2*sin(theta1f+phi+pi+psi);
Xpf= Xaf+r1*cos((-pi/2)+beta1); 	Ypf= Yaf+r1*sin((-pi/2)+beta1);
Xqf= Xbf+r2*cos((-pi/2)+beta2); 	Yqf= Ybf+r2*sin((-pi/2)+beta2);
Xrf= Xhf+r3*cos((-pi/2)+beta3);		Yrf= Yhf+r3*sin((-pi/2)+beta3);

%middle wheel

beta2=[-90 -90 -90 -45 0]';
beta1=[0 0 0 0 0]';
beta3=[0 0 0 0 0]';
beta1=(beta1)*pi/180; beta2=(beta2)*pi/180; beta3=(beta3)*pi/180; %deg to rad%

Xbm=Xwc;
Ybm=Ywc;

Yam=[SH+r1,SH+r1,SH+r1,SH+r1,SH+r1]';
argr1=(L10)^2-(Ybm-Yam).^2;
if (argf1<0)
    disp('argr1 is neg')
    keyboard
end
Xam= Xbm-sqrt(argr1);

phiABm= pi+atan2((Ybm-Yam),(Xbm-Xam));

Xcm= Xam+L1*cos(alfa9+phiABm+pi);           Ycm= Yam+L1*sin(alfa9+phiABm+pi);
Xdm= Xbm+L2*cos(phiABm+pi-alfa10+pi);       Ydm= Ybm+L2*sin(phiABm+pi-alfa10+pi);

Xem= Xcm+L3*cos(theta2m-pi);            Yem= Ycm+L3*sin(theta2m-pi);
Xfm= Xem+L4*cos(theta1m);               Yfm= Yem+L4*sin(theta1m);
Xim= Xem+z*(Xfm-Xem);                   Yim= Yem+z*(Yfm-Yem);
Xgm= Xim+L7*cos(theta1m+phi);           Ygm= Yim+L7*sin(theta1m+phi);
Xhm =Xim+L9*cos(gamma+theta1m);         Yhm=Yim+L9*sin(gamma+theta1m);
Xg2m= Xgm+Lgg2*cos(theta1m+phi+pi+psi);Yg2m= Ygm+Lgg2*sin(theta1m+phi+pi+psi);
%Xg2m =Xgm-0.012993696996185;            Yg2m=Ygm+0.006563125942243;   
Xpm =Xam+r1*cos((-pi/2)+beta1);         Ypm=Yam+r1*sin((-pi/2)+beta1);
Xqm =Xbm+r2*cos((-pi/2)+beta2);         Yqm=Ybm+r2*sin((-pi/2)+beta2);
Xrm =Xhm+r3*cos((-pi/2)+beta3);         Yrm=Yhm+r3*sin((-pi/2)+beta3);

% %rear wheel

beta3=[-90 -90 -90 -45 0]';
beta2=[0 0 0 0 0]';
beta1=[0 0 0 0 0]';
beta1=(beta1)*pi/180; beta2=(beta2)*pi/180; beta3=(beta3)*pi/180;

Xhr=Xwc;
Yhr=Ywc;

Xir= Xhr+L9*cos(phiHI);                 Yir= Yhr+L9*sin(phiHI);
theta1r=(phiHI+pi-gamma);
Xer= Xir-z*L4*cos(theta1r);             Yer=Yir-z*L4*sin(theta1r);
%Xer= Xir-z*L4*cos(phiHI-gamma);         Yer=Yir-z*L4*sin(phiHI-gamma);
%Xfr= Xir+(1-z)*L4*cos(phiHI-gamma);     Yfr=Yir+(1-z)*L4*sin(phiHI-gamma);
Xfr= Xer+L4*cos(theta1r);               Yfr=Yer+L4*sin(theta1r);
Xcr=Xer-L3*cos(theta2r-pi);             Ycr=Yer-L3*sin(theta2r+pi);
% Xcr=Xer+L3*cos(theta2r+pi);             Ycr=Yer+L3*sin(theta2r+pi);
Xar=Xcr-L1*cos(phiAC);                  Yar=Ycr-L1*sin(phiAC);
Xbr=Xar-L10*cos(phiAC-alfa9+pi);        Ybr=Yar-L10*sin(phiAC-alfa9+pi);

phiABr= pi+atan2((Ybr-Yar),(Xbr-Xar));
Xdr= Xbr+L2*cos(phiABr+pi-alfa10+pi);      Ydr= Ybr+L2*sin(phiABr+pi-alfa10+pi);
Xgr=Xir+L7*cos(theta1r+phi);            Ygr=Yir+L7*sin(theta1r+phi);
Xg2r=Xgr+Lgg2*cos(theta1r+phi+pi+psi);     Yg2r=Ygr+Lgg2*sin(theta1r+phi+pi+psi);
%Xg2r=Xgr-0.012993696996185;             Yg2r=Ygm+0.006563125942243;
Xpr=Xar+r1*cos((-pi/2)+beta1);          Ypr=Yar+r1*sin((-pi/2)+beta1);
Xqr=Xbr+r2*cos((-pi/2)+beta2);          Yqr=Ybr+r2*sin((-pi/2)+beta2);
Xrr=Xhr+r3*cos((-pi/2)+beta3);          Yrr=Yhr+r3*sin((-pi/2)+beta3);

% XY : 15x26 matrix. Columns are Xa,Ya,Xb,Yb,Xc,Yc,Xd,Yd,Xe,Ye,Xf,Yf,Xg,Yg,Xh,Yh,Xi,Yi,Xg2,Yg2,Xp,Yp,Xq,Yq,Xr,Yr

XY=[Xaf,Yaf,Xbf,Ybf,Xcf,Ycf,Xdf,Ydf,Xef,Yef,Xff,Yff,Xgf,Ygf,Xhf,Yhf,Xif,Yif,Xg2f,Yg2f,Xpf,Ypf,Xqf,Yqf,Xrf,Yrf];
XY=[XY; Xam,Yam,Xbm,Ybm,Xcm,Ycm,Xdm,Ydm,Xem,Yem,Xfm,Yfm,Xgm,Ygm,Xhm,Yhm,Xim,Yim,Xg2m,Yg2m,Xpm,Ypm,Xqm,Yqm,Xrm,Yrm];
XY=[XY; Xar,Yar,Xbr,Ybr,Xcr,Ycr,Xdr,Ydr,Xer,Yer,Xfr,Yfr,Xgr,Ygr,Xhr,Yhr,Xir,Yir,Xg2r,Yg2r,Xpr,Ypr,Xqr,Yqr,Xrr,Yrr];

betaf=[-90 -90 -90 -45 0]';
betam=[0 0 0 0 0]';

beta1=[betaf; betam; betam]*pi/180;
beta2=[betam; betaf; betam]*pi/180;
beta3=[betam; betam; betaf]*pi/180;

end
