function [xMean,yMean,beta,deviation] = MaxVarianceSplit(xValues,yValues)
    %Ԥ������
    count = length(xValues);
    if count <= 0
        fprintf('���������û��Ԫ�أ�\n');
        return;
    end
    if count ~= length(yValues)
        fprintf('�����X��Y���鳤�Ȳ�һ�£�\n');
        return;
    end
    %��X��Yƽ��ֵ
    xMean = mean(xValues);
    yMean = mean(yValues);
    %ƽ�����е������ĵ�λ��
    xNewValues = xValues - xMean;
    yNewValues = yValues - yMean;
    %���㼸��������ֵ
    xyNewValue = xNewValues * yNewValues';
    xxNewValue = xNewValues * xNewValues';
    yyNewValue = yNewValues * yNewValues';
    %����beta�Ƕ�
    beta = atan(2 * xyNewValue / (xxNewValue - yyNewValue)) / 2;
    %������׵����б�ʽ
    delta = - 2 * (xyNewValue * sin(2 * beta) + (xxNewValue - yyNewValue) * cos(2 * beta));
    %����б�ʽ
    if delta > 0
        %���׵��������㣬˵���Ǽ�Сֵ
        %����һ����ֱ������Ǽ���ֵ����
        beta = beta + pi / 2.0;
    end
    %��������
    %������������ڣ�0,pi��������
    if beta < 0
        beta = beta + pi;
    elseif beta > pi
        beta = beta - pi;
    end
    %����ͶӰ��֮��ı�׼��ֵ
    deviation = sqrt((cos(2 * beta) * (xxNewValue - yyNewValue) + 2 * sin(2 * beta) * xyNewValue + (xxNewValue + yyNewValue)) / (2 * count));
end