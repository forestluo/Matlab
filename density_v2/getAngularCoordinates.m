function [result] = getAngularCoordinates(angularCode)

    %ȫ�ֱ���
    %global linearRange;
    global angularRange;
    
    %�ֲ��־ñ���
    persistent angularMatrix;

    %������
    linearRange = 2;
    %��黯�־ñ���
    if isempty(angularMatrix)
        %����ߴ�
        size = 2 * linearRange + 1;
        %��ʼ���־ñ���
        angularMatrix = zeros(size,size);
        %��ʼ������������
        for dx = 1 : linearRange;
            %��������Ƕȱ�����ֵ
            angularMatrix(linearRange + 1,linearRange + dx + 1) = 1;
            angularMatrix(linearRange + 1,linearRange - dx + 1) = angularRange / 2;
        end
        for dy = 1 : linearRange;
            %��������Ƕȱ�����ֵ
            angularMatrix(linearRange + dy + 1,linearRange + 1) = angularRange / 4;
            angularMatrix(linearRange - dy + 1,linearRange + 1) = angularRange * 3 / 4;
            for dx = 1 : linearRange
                %���ƫ��
                if dx * dx + dy * dy > linearRange * linearRange
                    %���ýǶȱ�����ֵ����һ���ޣ�
                    angularMatrix(linearRange + dy + 1,linearRange + dx + 1) = 0;
                    %���ýǶȱ�����ֵ���ڶ����ޣ�
                    angularMatrix(linearRange + dy + 1,linearRange - dx + 1) = 0;
                    %���ýǶȱ�����ֵ���������ޣ�
                    angularMatrix(linearRange - dy + 1,linearRange - dx + 1) = 0;
                    %���ýǶȱ�����ֵ���������ޣ�
                    angularMatrix(linearRange - dy + 1,linearRange + dx + 1) = 0;
                else
                    %����ɽǶ�
                    angular = round(atan(dy / dx) * 180 / pi);
                    %���������ֵ
                    angularIndex = ceil((angular / 5 + 1) / 2);
                    %���ýǶȱ�����ֵ����һ���ޣ�
                    angularMatrix(linearRange + dy + 1,linearRange + dx + 1) = angularIndex;
                    %���ýǶȱ�����ֵ���ڶ����ޣ�
                    angularMatrix(linearRange + dy + 1,linearRange - dx + 1) = angularRange / 2 - angularIndex;
                    %���ýǶȱ�����ֵ���������ޣ�
                    angularMatrix(linearRange - dy + 1,linearRange - dx + 1) = angularRange / 2 + angularIndex;
                    %���ýǶȱ�����ֵ���������ޣ�
                    angularMatrix(linearRange - dy + 1,linearRange + dx + 1) = angularRange - angularIndex;
                end
            end
        end
    end

    %������
    count = 0;
    %���ɲ���������
    result = [];
    %�������ĵ�
    result(1,1) = 0;
    result(1,2) = 0;
    %������������
    for row = 1 : 2 * linearRange + 1
        for column = 1 : 2 * linearRange + 1
            %��������
            if angularMatrix(row,column) == angularCode
                %���Ӽ�����
                count = count + 1;
                %������ֵ
                result(count,1) = row - linearRange - 1; 
                result(count,2) = column - linearRange - 1;
            end
        end
    end   
end