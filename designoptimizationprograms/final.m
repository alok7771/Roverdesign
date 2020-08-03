
count=1;
s=smin;
[mu,smin,lb,ub,exitflag]=rb4bar1_des_opt(s);
while (smin~=3.1)
    s=smin;
    [mu,smin,lb,ub,exitflag]=rb4bar1_des_opt(s);
         save('smin','smin');
         disp('solution achieved')
        % keyboard
       
    count=count+1;
        
end
      
        smin
