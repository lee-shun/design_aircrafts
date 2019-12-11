function [Y] = RK45(t,y,f,h,n)
%龙格库塔法
%输入：
%t，y 变量     
%f为函数     
%h为步长    
%n为迭代次数  用来记录Alpha_B和deltaz
K1=f(t,y,n);
K2=f(t+h/2,y+h/2*K1,n);
K3=f(t+h/2,y+h/2*K2,n);
K4=f(t+h,y+h*K3,n);
Y=y+h/6*(K1+2*K2+2*K3+K4);
end