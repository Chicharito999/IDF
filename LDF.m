w0=input('w0=');
w1=input('w1=');
w2=input('w2=');%初始化权向量
learning_rate=input('learning_rate=');%初始化步长

iter=1;max_iter=20;%定义最大的迭代次数
error=zeros(max_iter,1); %记录每次迭代的准则函数值
while iter<=max_iter%循环max_iter次
    change_w0=0;change_w1=0;change_w2=0;%初始化步长
    for i=1:20
        temp=train(i,3)*w0+train(i,1)*w1+train(i,2)*w2;%计算g（x）
        if temp<=0%如果错分
            den=train(i,3)^2+train(i,2)^2+train(i,1)^2;%计算错分样本向量的平方值v
            change_w0=change_w0+((train(i,3)*(w0+1)+train(i,1)*w1+train(i,2)*w2)^2-(train(i,3)*(w0-1)+train(i,1)*w1+train(i,2)*w2)^2)/(4*den);
            change_w1=change_w1+((train(i,3)*w0+train(i,1)*(w1+1)+train(i,2)*w2)^2-(train(i,3)*w0+train(i,1)*(w1-1)+train(i,2)*w2)^2)/(4*den);
            change_w2=change_w2+((train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2+1))^2-(train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2-1))^2)/(4*den);%计算步长
            error(iter,1)=error(iter,1)+temp*temp/(2*den);%计算每次迭代的准则函数值
        end
    end
    
    w0=w0-learning_rate*change_w0;
    w1=w1-learning_rate*change_w1;
    w2=w2-learning_rate*change_w2;%更新解向量
    
    iter=iter+1;
    %if(learning_rate*sqrt(change_w0*change_w0+change_w1*change_w1+change_w2*change_w2)<0.000000001&&error<=5)
    %    break;
    %end
end

times=1:1:max_iter;
error_=error';
values = spcrv([[times(1) times times(end)];[error_(1) error_ error_(end)]],3);%平滑曲线
plot(values(1,:),values(2,:), 'g');%画出迭代次数-准则函数的平滑曲线





