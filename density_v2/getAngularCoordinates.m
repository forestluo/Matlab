function [result] = getAngularCoordinates(angularCode)

    %全局变量
    %global linearRange;
    global angularRange;
    
    %局部持久变量
    persistent angularMatrix;

    %调试用
    linearRange = 2;
    %检查化持久变量
    if isempty(angularMatrix)
        %定义尺寸
        size = 2 * linearRange + 1;
        %初始化持久变量
        angularMatrix = zeros(size,size);
        %开始演算所有数据
        for dx = 1 : linearRange;
            %设置特殊角度编码数值
            angularMatrix(linearRange + 1,linearRange + dx + 1) = 1;
            angularMatrix(linearRange + 1,linearRange - dx + 1) = angularRange / 2;
        end
        for dy = 1 : linearRange;
            %设置特殊角度编码数值
            angularMatrix(linearRange + dy + 1,linearRange + 1) = angularRange / 4;
            angularMatrix(linearRange - dy + 1,linearRange + 1) = angularRange * 3 / 4;
            for dx = 1 : linearRange
                %检查偏差
                if dx * dx + dy * dy > linearRange * linearRange
                    %设置角度编码数值（第一象限）
                    angularMatrix(linearRange + dy + 1,linearRange + dx + 1) = 0;
                    %设置角度编码数值（第二象限）
                    angularMatrix(linearRange + dy + 1,linearRange - dx + 1) = 0;
                    %设置角度编码数值（第三象限）
                    angularMatrix(linearRange - dy + 1,linearRange - dx + 1) = 0;
                    %设置角度编码数值（第四象限）
                    angularMatrix(linearRange - dy + 1,linearRange + dx + 1) = 0;
                else
                    %换算成角度
                    angular = round(atan(dy / dx) * 180 / pi);
                    %获得索引数值
                    angularIndex = ceil((angular / 5 + 1) / 2);
                    %设置角度编码数值（第一象限）
                    angularMatrix(linearRange + dy + 1,linearRange + dx + 1) = angularIndex;
                    %设置角度编码数值（第二象限）
                    angularMatrix(linearRange + dy + 1,linearRange - dx + 1) = angularRange / 2 - angularIndex;
                    %设置角度编码数值（第三象限）
                    angularMatrix(linearRange - dy + 1,linearRange - dx + 1) = angularRange / 2 + angularIndex;
                    %设置角度编码数值（第四象限）
                    angularMatrix(linearRange - dy + 1,linearRange + dx + 1) = angularRange - angularIndex;
                end
            end
        end
    end

    %计数器
    count = 0;
    %生成不定长向量
    result = [];
    %增加中心点
    result(1,1) = 0;
    result(1,2) = 0;
    %检索整个数组
    for row = 1 : 2 * linearRange + 1
        for column = 1 : 2 * linearRange + 1
            %检索编码
            if angularMatrix(row,column) == angularCode
                %增加计数器
                count = count + 1;
                %设置数值
                result(count,1) = row - linearRange - 1; 
                result(count,2) = column - linearRange - 1;
            end
        end
    end   
end