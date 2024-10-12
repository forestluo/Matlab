function ButtonDownFcn(src,event)
    %定义全局变量
    global row;
    global column;
    %线性分析变量
    global range;
    global linearDensityMatrix;
    global angularDensityMatrix;
    
    %获得当前鼠标坐标
    pt = get(gca,'CurrentPoint');
    x = ceil(pt(1,1));
    y = ceil(pt(1,2));
    %fprintf('x = %d, y = %d\r\n',x,y);
    
    %检查范围
    if y > 0 && y <= row ...
        && x > 0 && x <= column
    
        %获得全向线性密度数组
        vector = zeros(1,range + 1);
        %逐一拷贝数组内容
        for k = 1 : range + 1
            %拷贝数组数值
            vector(1,k) = linearDensityMatrix(y,x,k);
        end
        %在记录结果在新图上
        figure(1); subplot(2,2,4); plot(vector);
        %清理变量
        clear vector;

        %全向角度密度数组
        vector = zeros(1,4 * range);
        %获得全向角度密度数组
        for k = 1 : 4 * range
            %拷贝数组数值（指数级放大）
            vector(1,k) = angularDensityMatrix(y,x,k);
        end
        %分析和显示傅立叶结果
        figure(1); subplot(2,2,3); stem(fftshift(fft(vector)));
        %用图表显示密度数组
        figure(1); subplot(2,2,4); hold on; plot(vector,'color','r'); hold off;
        %清理变量
        clear vector;
        
        %在原图上做标记
        %plotLinearCoffPixel(x,y);
        plotAngularCoffPixel(x,y);
        %figure(1); subplot(2,2,1); text(x,y,'*');
        
        %激活原窗口坐标系
        figure(1); subplot(2,2,1);
    end
end
