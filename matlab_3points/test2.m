%�����е�������Ϊ��׫�����ܲ�������ʵ�ʣ���˴˵��ɲ����ԡ����ȶ��Ե�����ƫ�������ù��ؼ�С����ʼ�������޸Ŀ��ܻᵼ�¹��ع����޷�������
%������Ҫ��ע���㷨����ѧ΢�ַ��̵ļ��㼴��
%�����������㷨���򣬶��߿����Ķ�ѧϰ
global Alpha_B
global deltaz
global f_y
t0=0;
t1=10;
h=0.01;                                    %����
x0=[50,0,1200,50,0,1,40];
                                                %��ʼ���� �����ҷֱ�Ϊ
                                                %VT    Theta_T    RT     V        RM      Epsilon         m 
T=t0:h:t1;
X=zeros(length(x0),length(T));
X(:,1)=x0;
for j=1:length(T)-1 
    X(:,j+1)=RK45(T(j),X(:,j),@(t,x,n)three_point(t,x,n),h,j);   %ʹ����������� XΪ������
    if X(5,j+1)>X(3,j+1)                                                    %�趨��ֹ���� ��RT<RM
        break;
    end
end

for index=1:7
    figure(index)
    plot(T,X(index,:))%huatu 
    grid on;
end

plot(f_y);

