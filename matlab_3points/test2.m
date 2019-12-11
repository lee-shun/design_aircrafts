%程序中导弹参数为杜撰，可能并不符合实际，因此此弹可操纵性、静稳定性等性能偏弱，需用过载极小，初始条件的修改可能会导致过载过大无法输出结果
%读者主要关注三点法动力学微分方程的计算即可
%另附工程用三点法程序，读者可以阅读学习
global Alpha_B
global deltaz
global f_y
t0=0;
t1=10;
h=0.01;                                    %步长
x0=[50,0,1200,50,0,1,40];
                                                %初始条件 从左到右分别为
                                                %VT    Theta_T    RT     V        RM      Epsilon         m 
T=t0:h:t1;
X=zeros(length(x0),length(T));
X(:,1)=x0;
for j=1:length(T)-1 
    X(:,j+1)=RK45(T(j),X(:,j),@(t,x,n)three_point(t,x,n),h,j);   %使用龙格库塔法 X为输出结果
    if X(5,j+1)>X(3,j+1)                                                    %设定截止条件 即RT<RM
        break;
    end
end

for index=1:7
    figure(index)
    plot(T,X(index,:))%huatu 
    grid on;
end

plot(f_y);

