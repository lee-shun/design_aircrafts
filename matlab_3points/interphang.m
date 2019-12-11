function xx = interphang(X,Y,x) %²åÖµÒ»ÐÐ
temp=floor(x*10)+1;
n=length(X);
if x>X(n)
     xx=Y(n,:)+(x-X(n))*(Y(n)-Y(n-1))*10;
else 
        a=x*10-temp;
        xx=Y(temp,:)*(1-a)+a*Y(temp+1,:);
end    
end