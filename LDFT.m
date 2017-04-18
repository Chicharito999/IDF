init_w0=input('init_w0=');
init_w1=input('init_w1=');
init_w2=input('init_w2=');%权向量的初始取值
learning_rate=0.01:0.01:1;%学习率的取值范围
iter=zeros(length(learning_rate),1);%记录不同学习率的迭代次数
for j=1:length(learning_rate)
    w0=init_w0;w1=init_w1;w2=init_w2;%初始化权向量
    while 1
        error=0;%记录一次迭代的样本错分数目
        change_w0=0;change_w1=0;change_w2=0;%初始化步长
        for i=1:20
            temp=train(i,3)*w0+train(i,1)*w1+train(i,2)*w2;%计算g（x）
            if temp<=0%如果错分
                change_w0=change_w0+((train(i,3)*(w0+1)+train(i,1)*w1+train(i,2)*w2)^2-(train(i,3)*(w0-1)+train(i,1)*w1+train(i,2)*w2)^2)/(4*(train(i,3)^2+train(i,2)^2+train(i,1)^2));
                change_w1=change_w1+((train(i,3)*w0+train(i,1)*(w1+1)+train(i,2)*w2)^2-(train(i,3)*w0+train(i,1)*(w1-1)+train(i,2)*w2)^2)/(4*(train(i,3)^2+train(i,2)^2+train(i,1)^2));
                change_w2=change_w2+((train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2+1))^2-(train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2-1))^2)/(4*(train(i,3)^2+train(i,2)^2+train(i,1)^2));%计算步长
                error=error+1;%更新每次迭代的错分数目
            end
        end
        
        w0=w0-learning_rate(j)*change_w0;
        w1=w1-learning_rate(j)*change_w1;
        w2=w2-learning_rate(j)*change_w2;%更新解向量
        
        iter(j,1)=iter(j,1)+1;%更新当前学习率的迭代次数
        if iter(j,1)>20000%如果当前学习率的迭代次数>2000，认为已经无法收敛，跳出循环
            break;
        end
        if(learning_rate(j)*sqrt(change_w0*change_w0+change_w1*change_w1+change_w2*change_w2)<0.000000001&&error<=5)%迭代停止条件
            break;
        end
    end
end

iter=iter';
values = spcrv([[learning_rate(1) learning_rate learning_rate(end)];[iter(1) iter iter(end)]],3);%曲线平滑
plot(values(1,:),values(2,:), 'g');%绘制学习率-迭代次数的平滑曲线






