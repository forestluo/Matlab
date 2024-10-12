function plotLinearCoffPixel(x,y)
    %全局变量
    global sample;
    global row;
    global column;
    %线性分析变量
    global range;
    global linearDensityMatrix;
    
    %检查输入点范围
    if y > 0 && y <= row ...
        && x > 0 && x <= column
    
        %全向线性密度数组
        vector = zeros(1,range);
        %获得全向线性密度数组
        for k = 1 : range
            %拷贝数组数值
            vector(1,k) = linearDensityMatrix(y,x,k);
        end
        %激活原图形并打点
        figure(1); subplot(2,2,1);
        imshow(sample,'InitialMagnification','fit');
        hold on; scatter(x,y,1);
        
        %全部检验
        for n = 1 : row
            %打印信息
            fprintf('Analyse line(%d) !\r\n',n);
            for m = 1 : column
                %全向线性密度数组
                vector1 = zeros(1,range);
                %获得全向线性密度数组
                for k = 1 : range
                    %拷贝数组数值
                    vector1(1,k) = linearDensityMatrix(n,m,k);
                end
                %求两者之间的相关性
                value = corrcoef(vector,vector1);
                %求平均值的绝对值
                value = (value(1,2) + value(2,1)) / 2.0;
                %在原图上打点（表达高相关性数据点）
                if value >= 0.90
                    scatter(m,n,1); end
            end
        end
        hold off;
        %清理变量
        clear vector;
        clear vector1;
    end
end