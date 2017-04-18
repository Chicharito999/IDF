# IDF
:point_down::fu:梯度下降法和牛顿法进行线性分类<br>
__________________________________________________________________________________________
Author:赵明福                                        Student ID：201400301087                            E-mail:1109646702@qq.com<br>
## 题目介绍
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片42.png)
## 题目分析
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片43.png)<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片44.png)<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片45.png)<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片46.png)<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片47.png)<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片48.png)<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片49.png)<br>
## 编程实现及注释
问题（a），梯度下降法LDF：<br>
```matlab
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
end
 
times=1:1:max_iter;
error_=error';
values = spcrv([[times(1) times times(end)];[error_(1) error_ error_(end)]],3);%平滑曲线
plot(values(1,:),values(2,:), 'g');%画出迭代次数-准则函数的平滑曲线
```
问题（a），牛顿法NM：<br>
```matlab
w0=input('w0=');
w1=input('w1=');
w2=input('w2=');%初始化权向量
 
iter=1;max_iter=20;%定义最大的迭代次数
error=zeros(max_iter,1);   %记录每次迭代的准则函数值
while iter<=max_iter%循环max_iter次
    change_w0=0;change_w1=0;change_w2=0;%初始化步长
    mori=zeros(3,3);%赫森矩阵
    den=0;%记录错分样本向量的平方值
    for i=1:20
        temp=train(i,3)*w0+train(i,1)*w1+train(i,2)*w2;%计算g（x）
        if temp<=0%如果错分
            den=train(i,3)^2+train(i,2)^2+train(i,1)^2;%计算错分样本向量的平方值
            change_w0=change_w0+((train(i,3)*(w0+1)+train(i,1)*w1+train(i,2)*w2)^2-(train(i,3)*(w0-1)+train(i,1)*w1+train(i,2)*w2)^2)/(4*den);
            change_w1=change_w1+((train(i,3)*w0+train(i,1)*(w1+1)+train(i,2)*w2)^2-(train(i,3)*w0+train(i,1)*(w1-1)+train(i,2)*w2)^2)/(4*den);
            change_w2=change_w2+((train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2+1))^2-(train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2-1))^2)/(4*den);%计算步长
            mori(1,1)=mori(1,1)+train(i,3)*train(i,3)/den;
            mori(2,2)=mori(2,2)+train(i,1)*train(i,1)/den;
            mori(3,3)=mori(3,3)+train(i,2)*train(i,2)/den;
            mori(1,2)=mori(1,2)+train(i,3)*train(i,1)/den;
            mori(1,3)=mori(1,3)+train(i,3)*train(i,2)/den;
            mori(2,3)=mori(2,3)+train(i,1)*train(i,2)/den;%计算赫森矩阵的上对角线元素值
            error(iter,1)=error(iter,1)+temp*temp/(2*den);%计算每次迭代的准则函数值
            %error=error+1;
        end
    end
    mori(2,1)=mori(1,2);mori(3,1)=mori(1,3);mori(3,2)=mori(2,3);%求赫森矩阵的其余元素
    mori=inv(mori);%对赫森矩阵求逆
    change_w=[change_w0,change_w1,change_w2]';
    w0=w0-mori(1,:)*change_w;
    w1=w1-mori(2,:)*change_w;
    w2=w2-mori(3,:)*change_w;%更新解向量
    
    iter=iter+1;
End

times=1:1:max_iter;
error_=error';
values = spcrv([[times(1) times times(end)];[error_(1) error_ error_(end)]],3);%平滑曲线
plot(values(1,:),values(2,:), 'g');%画出迭代次数-准则函数的平滑曲线
```
问题（c）LDFT：<br>
```matlab
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
```
## 结果分析
问题（a）：<br>
梯度下降法的迭代次数-准则函数曲线（初始解向量（1，1，1））：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片50.png)<br>
牛顿法的迭代次数-准则函数曲线（初始解向量（1，1，1））：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片51.png)<br>
观察两种方法的原始数据error，可以更清楚地看出两者的区别：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片52.png)<br>
　可以明显看出：牛顿法收敛速度相比梯度下降法很快，而且由于赫森矩阵的逆在迭代中不断减小，起到逐渐缩小步长的效果。牛顿法也比梯度下降算法在每一步都给出了更好的步长，但是牛顿法的缺点就是计算赫森矩阵的逆比较困难，消耗时间和计算资源。<br>
问题（b）：<br>
　从第一问的结果中可以看出，牛顿法相较于梯度下降法收敛地更快，这是因为牛顿法是二阶收敛的每次选择函数收敛最大的坡度，而且梯度下降在接近最优点时会有震荡，导致很难到达最小值。但是牛顿法需要每次迭代求一次赫森矩阵的逆，需要的时间，并且随着维数的增加运算量会急速上升。所以说牛顿法收敛速度更快所需的迭代次数少，但是每次迭代的计算量更大。对于本次实验，采取两种方法到达收敛条件时的所需时间：牛顿法>梯度下降法。<br>
问题（c）：<br>
学习率-迭代次数曲线（学习率：0.01:0.01:1，初始解向量：（1，1，1））：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片53.png)<br>
　在梯度下降算法中，学习率决定了每一次迭代的过程中，会往梯度下降的方向移动的距离。如果学习率很小，算法每步移动的距离很短，就会导致算法的收敛速度很慢；如果步长很大，算法会在局部最优点附近来回跳动，不会收敛。<br>
　结果曲线很好地印证了猜想，随着学习率由0.01向1增大时，算法每步移动的距离加大，算法收敛所需的迭代次数不断减小；但是当增大到0.42-0.43附近时，迭代次数开始变得很大（这里设置迭代次数最大值为20000，达到20000次会跳出循环），这是因为每次迭代的步长变得很大导致在局部最优点附近来回跳动无法收敛；而接下来曲线出现跳跃是因为，当学习率很大时有可能凑巧在迭代几次后恰好落到最优点附近，所以会出现曲线的上下波动。<br>

