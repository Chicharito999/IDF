w0=input('w0=');
w1=input('w1=');
w2=input('w2=');%��ʼ��Ȩ����

iter=1;max_iter=20;%�������ĵ�������
error=zeros(max_iter,1);   %��¼ÿ�ε�����׼����ֵ
while iter<=max_iter%ѭ��max_iter��
    change_w0=0;change_w1=0;change_w2=0;%��ʼ������
    mori=zeros(3,3);%��ɭ����
    den=0;%��¼�������������ƽ��ֵ
    for i=1:20
        temp=train(i,3)*w0+train(i,1)*w1+train(i,2)*w2;%����g��x��
        if temp<=0%������
            den=train(i,3)^2+train(i,2)^2+train(i,1)^2;%����������������ƽ��ֵ
            change_w0=change_w0+((train(i,3)*(w0+1)+train(i,1)*w1+train(i,2)*w2)^2-(train(i,3)*(w0-1)+train(i,1)*w1+train(i,2)*w2)^2)/(4*den);
            change_w1=change_w1+((train(i,3)*w0+train(i,1)*(w1+1)+train(i,2)*w2)^2-(train(i,3)*w0+train(i,1)*(w1-1)+train(i,2)*w2)^2)/(4*den);
            change_w2=change_w2+((train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2+1))^2-(train(i,3)*w0+train(i,1)*w1+train(i,2)*(w2-1))^2)/(4*den);%���㲽��
            mori(1,1)=mori(1,1)+train(i,3)*train(i,3)/den;
            mori(2,2)=mori(2,2)+train(i,1)*train(i,1)/den;
            mori(3,3)=mori(3,3)+train(i,2)*train(i,2)/den;
            mori(1,2)=mori(1,2)+train(i,3)*train(i,1)/den;
            mori(1,3)=mori(1,3)+train(i,3)*train(i,2)/den;
            mori(2,3)=mori(2,3)+train(i,1)*train(i,2)/den;%�����ɭ������϶Խ���Ԫ��ֵ
            error(iter,1)=error(iter,1)+temp*temp/(2*den);%����ÿ�ε�����׼����ֵ
        end
    end
    mori(2,1)=mori(1,2);mori(3,1)=mori(1,3);mori(3,2)=mori(2,3);%���ɭ���������Ԫ��
    mori=inv(mori);%�Ժ�ɭ��������
    change_w=[change_w0,change_w1,change_w2]';
    w0=w0-mori(1,:)*change_w;
    w1=w1-mori(2,:)*change_w;
    w2=w2-mori(3,:)*change_w;%���½�����
    
    iter=iter+1;
    %if(learning_rate*sqrt(change_w0*change_w0+change_w1*change_w1+change_w2*change_w2)<0.000000001&&error<=5)
    %    break;
    %end
end

times=1:1:max_iter;
error_=error';
values = spcrv([[times(1) times times(end)];[error_(1) error_ error_(end)]],3);%ƽ������
plot(values(1,:),values(2,:), 'g');%������������-׼������ƽ������





