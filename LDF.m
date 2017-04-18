w0=input('w0=');
w1=input('w1=');
w2=input('w2=');%��ʼ��Ȩ����
learning_rate=input('learning_rate=');%��ʼ������

iter=1;max_iter=20;%�������ĵ�������
error=zeros(max_iter,1); %��¼ÿ�ε�����׼����ֵ
while iter<=max_iter%ѭ��max_iter��
    change_w0=0;change_w1=0;change_w2=0;%��ʼ������
    for i=1:20
        temp=train(i,3)*w0+train(i,1)*w1+train(i,2)*w2;%����g��x��
        if temp<=0%������
            den=train(i,3)^2+train(i,2)^2+train(i,1)^2;%����������������ƽ��ֵv
            change_w0=change_w0+((train(i,3)*(w0+1)+train(i,1)*w1+train(i,2)*w2)^2-(train(i,3)*(w0-1)+train(i,1)*w1+train(i,2)*w2)^2)/(4*den);
            change_w1=change_w1+((train(i,3)*w0+train(i,1)*(w1+1)+train(i,2)*w2)^2-(train(i,3)*w0+train(i,1)*(w1-1)+train(i,2)*w2)^2)/(4*den);
            change_w2=change_w2+((train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2+1))^2-(train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2-1))^2)/(4*den);%���㲽��
            error(iter,1)=error(iter,1)+temp*temp/(2*den);%����ÿ�ε�����׼����ֵ
        end
    end
    
    w0=w0-learning_rate*change_w0;
    w1=w1-learning_rate*change_w1;
    w2=w2-learning_rate*change_w2;%���½�����
    
    iter=iter+1;
    %if(learning_rate*sqrt(change_w0*change_w0+change_w1*change_w1+change_w2*change_w2)<0.000000001&&error<=5)
    %    break;
    %end
end

times=1:1:max_iter;
error_=error';
values = spcrv([[times(1) times times(end)];[error_(1) error_ error_(end)]],3);%ƽ������
plot(values(1,:),values(2,:), 'g');%������������-׼������ƽ������





