function [result] = integrateLinePixel(image,x,y,dx,dy)

    %ȫ�ֱ���
    global row;
    global column;
    %ȫ�ֱ���
    global range;

    %����ȱʡ��ֵ
    result = 0;
    %DDAֱ���㷨
    %���б��
    if abs(dx) > abs(dy)
        %����������Χ
        eps = abs(dx);
    else
        %����������Χ
        eps = abs(dy);
    end
    %�������
    ddx = dx / eps;
    ddy = dy / eps;
    %ѭ��ִ��
    for k = 0 : 1: eps
        %���ͼ���ϵ������
        ix = ceil(x + 0.5);
        iy = ceil(y + 0.5); 
        %��鷶Χ
        if iy > 0 && iy <= row ...
            && ix > 0 && ix <= column
            %�Ӻͽ����ֵ
            result = result + image(iy,ix);
        end
        %����������
        x = x + ddx; y = y + ddy;
    end
    %�Խ�����й�һ������
    result = result / range;
end