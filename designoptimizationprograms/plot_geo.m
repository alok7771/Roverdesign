[XY,beta1,beta2,beta3]= point_positions_opt(smin);

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
i=15;

for i=1:1:15
    clf
axis equal;

Xbogie=[Xa(i);Xc(i);Xd(i);Xb(i)]; Ybogie=[Ya(i);Yc(i);Yd(i);Yb(i)];
% hold on;
X4bar=[Xc(i);Xe(i);Xf(i);Xd(i)]; Y4bar=[Yc(i);Ye(i);Yf(i);Yd(i)];
Xrocker=[Xi(i);Xg(i);Xh(i)]; Yrocker=[Yi(i);Yg(i);Yh(i)];

Xbox=[-1;1;1;-1]; Ybox=[0;0;1.5;1.5];
Xstep=[0;0;-1;-1]; Ystep=[0;0.225;0.225;0];
plot(Xbox,Ybox,Xstep,Ystep);
hold on;
plot(Xbogie,Ybogie,X4bar,Y4bar,Xrocker,Yrocker);

th=(-pi:pi/100:pi);
r1=0.075; r2=0.075; r3=0.075;
Xr1=r1*cos(th); Yr1=r1*sin(th);
Xr2=r2*cos(th); Yr2=r2*sin(th);
Xr3=r3*cos(th); Yr3=r3*sin(th);
%Wxf=Xa+Xr1; Wyf=Ya+Yr1;
plot(Xa(i)+Xr1,Ya(i)+Yr1,Xb(i)+Xr2,Yb(i)+Yr2,Xh(i)+Xr3,Yh(i)+Yr3);
plot(Xg2(i),Yg2(i),'o');
%plot(Xg(i),Yg(i),'o');
axis equal;
pause(1);
end
