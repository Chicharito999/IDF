init_w0=input('init_w0=');
init_w1=input('init_w1=');
init_w2=input('init_w2=');%Ȩ�����ĳ�ʼȡֵ
learning_rate=0.01:0.01:1;%ѧϰ�ʵ�ȡֵ��Χ
iter=zeros(length(learning_rate),1);%��¼��ͬѧϰ�ʵĵ�������
for j=1:length(learning_rate)
    w0=init_w0;w1=init_w1;w2=init_w2;%��ʼ��Ȩ����
    while 1
        error=0;%��¼һ�ε��������������Ŀ
        change_w0=0;change_w1=0;change_w2=0;%��ʼ������
        for i=1:20
            temp=train(i,3)*w0+train(i,1)*w1+train(i,2)*w2;%����g��x��
            if temp<=0%������
                change_w0=change_w0+((train(i,3)*(w0+1)+train(i,1)*w1+train(i,2)*w2)^2-(train(i,3)*(w0-1)+train(i,1)*w1+train(i,2)*w2)^2)/(4*(train(i,3)^2+train(i,2)^2+train(i,1)^2));
                change_w1=change_w1+((train(i,3)*w0+train(i,1)*(w1+1)+train(i,2)*w2)^2-(train(i,3)*w0+train(i,1)*(w1-1)+train(i,2)*w2)^2)/(4*(train(i,3)^2+train(i,2)^2+train(i,1)^2));
                change_w2=change_w2+((train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2+1))^2-(train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2-1))^2)/(4*(train(i,3)^2+train(i,2)^2+train(i,1)^2));%���㲽��
                error=error+1;%����ÿ�ε����Ĵ����Ŀ
            end
        end
        
        w0=w0-learning_rate(j)*change_w0;
        w1=w1-learning_rate(j)*change_w1;
        w2=w2-learning_rate(j)*change_w2;%���½�����
        
        iter(j,1)=iter(j,1)+1;%���µ�ǰѧϰ�ʵĵ�������
        if iter(j,1)>20000%�����ǰѧϰ�ʵĵ�������>2000����Ϊ�Ѿ��޷�����������ѭ��
            break;
        end
        if(learning_rate(j)*sqrt(change_w0*change_w0+change_w1*change_w1+change_w2*change_w2)<0.000000001&&error<=5)%����ֹͣ����
            break;
        end
    end
end

iter=iter';
values = spcrv([[learning_rate(1) learning_rate learning_rate(end)];[iter(1) iter iter(end)]],3);%����ƽ��
plot(values(1,:),values(2,:), 'g');%����ѧϰ��-����������ƽ������






