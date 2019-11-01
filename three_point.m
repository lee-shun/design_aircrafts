function dy=three_point(t,yy,n) 
%从yy(1)到yy(7)分别为：
%VT    Theta_T    RT     VM        RM      Epsilon         m    
%输入为微分方程右端变量及迭代次数
%输出为微分方程左端微分
Parameters11;
interpolation11;
global Alpha_B
global deltaz
global f_y
dy=zeros(7,1);
Alpha_B(1)=0;
deltaz(1)=0;

q=0.5*Solve_rho(yy(5)*sin(yy(6)))*yy(4)*yy(4);                     %动压q=0.5*Rho*V*V
Cx=Solve_Cx(Alpha_B(n),yy(4));                         
Cy=Solve_Cy(Alpha_B(n),yy(4));
X=Cx*q*S;
Y=Cy*q*S;

%%%%%%%%%%代数方程%%%%%%%%%%
Eta_T=yy(6)-yy(2);                                                             %Eta_T=Epsilon-Theta_T
if   yy(4)==0
          Eta=0;
else
          Eta=asin(yy(1)*yy(5)/yy(3)/yy(4)*sin(Eta_T));              %Eta=asin(VT*RM/V/RT*sin(Eta_T))
end
Theta=yy(6)-Eta;                                                               %Theta=Epsilon-Eta



%%%%%%%%%%微分方程%%%%%%%%%%
dy(1)=0;                                                                                                           %VT
dy(2)=0;                                                                                                           %Theta_T
dy(3)=yy(1)*cos(Eta_T);                                                                                     %RT
dy(4)=(P*cos(Alpha_B(n))-X-yy(7)*g*sin(Theta))/yy(7);                                        %V
dy(5)=yy(4)*cos(Eta);                                                                                        %RM
dy(6)=-yy(1)*sin(Eta_T)/yy(3);                                                                            %Epsilon 
dy(7)=-Solve_mc(t);                                                                                          %m
   

%%%%%%%%%%求Alpha_B%%%%%%%%%%
if yy(3)==0||dy(5)==0||yy(4)==0||yy(1)==0
    Alpha_B(n+1)=0;
else
Alpha_B(n+1)=asin((yy(7)*yy(4)*(yy(5)*dy(3)*dy(2)/yy(3)/dy(5)+(2-2*yy(5)*dy(3)/yy(3)/dy(5)-yy(5)/yy(4)/dy(5)*dy(4))*dy(6)+dy(1)/yy(1)*tan(Theta-yy(6)))-Y+yy(7)*g*cos(Theta))/P);
                                                                  %mV*(RM*d_RT*d_Theta_T/RT/d_RM+(2-2*RM*d_RT/RT/d_RM-RM/VM/d_RM*(P*cos(Alpha_B)-X-mg*sin(theta)))*d_Epsilon+d_VT/VT*tan(theta-Epsilon))
                                                                  %  = P*sin(Alpha_B)+Y-mg*cos(theta)
end

%%%%%%%%%%粗求deltaz%%%%%%%%%%
%利用mzα*α=-mzδ*δ 找出mzδ*δ  在操纵力矩系数表中利用马赫数插值出对应的一行mzδ*δ  根据mzδ*δ插值出对应的舵偏角
mzalpha=Solve_mzAlpha(Alpha_B(n+1)*180/pi,yy(4));
hang=interphang(MaL,mzdeltazL,yy(4)/v_s);
deltaz(n+1)=interp1(hang,deltazL,mzalpha);


%%%%%%%%%%%%%%%%%求出theta_dot
 fun1 = 2*yy(5)*dy(3)/(yy(3)*dy(5));
 fun2 = yy(5)*dy(4)/(dy(5)*yy(4));

theta_dot = 0 +(2-fun1-fun2)*yy(6)+dy(1)/yy(1)*tan(-Eta);
 f_y(n+1) = theta_dot * yy(4)*pi/180;









