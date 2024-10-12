function [result] = integrateCirclePixel(image,x,y,r)
   
    %ȫ�ֱ���
    global row;
    global column;

    %��鷶Χ
    if y <= 0 || y > row ...
        || x <= 0 || x > column
        %���÷���ֵ
        result = 0; return;
    elseif r <= 0
        %���÷���ֵ
        result = image(y,x); return;
    end

    %����ȱʡ��ֵ
    result = 0;
    %��ʼ�������ص㣨�Ե�һ����Ϊ������
    for n = 0 : r
        %����������ֵ
        %�ò�����Բ���ϵ������
        m = getCircleCoordinate(r,n);
        %�������꣨��һ���ޣ�
        dx = x + n;
        dy = y + m;
        %���ģ�����
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %�ۻ�����ֵ
            result = result + image(dy,dx);
        end
        %�������꣨�ڶ����ޣ�
        dx = x - n;
        dy = y + m;
        %���ģ�����
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %�ۻ�����ֵ
            result = result + image(dy,dx);
        end
        %�������꣨�������ޣ�
        dx = x - n;
        dy = y - m;
        %���ģ�����
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %�ۻ�����ֵ
            result = result + image(dy,dx);
        end
        %�������꣨�������ޣ�
        dx = x + n;
        dy = y - m;
        %���ģ�����
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %�ۻ�����ֵ
            result = result + image(dy,dx);
        end
    end
    %��һ��������ֵ
    result = result / (2 * pi * r);
end