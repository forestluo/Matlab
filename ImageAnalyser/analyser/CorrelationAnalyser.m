classdef CorrelationAnalyser < handle
    properties (Access = private)       
        %被分析的图形
        bitImage;
        %积分模板
        template;
        %密度矩阵
        densityMatrix;

        %样本
        sample;
        %相关性
        correlations;
    end
    
    methods
        %构造函数
        function object = ...
            CorrelationAnalyser(fileName,radius)
            %转换成整数
            radius = int32(radius);
            %检查数值
            if radius < 3
                error('CorrelationAnalyser半径必须不小于3');
            end
            %显示
            disp('开始初始化CorrelationAnalyser');
            %创建被分析的图形
            disp('加载图像文件'); tic();
            object.bitImage = BitImage(fileName);
            %创建圆积分模板
            toc(); disp('建立圆积分模板'); tic();
            object.template = ConcentricTemplate(radius);
            %生成密度矩阵
            toc(); disp('建立圆密度矩阵'); tic();
            object.densityMatrix = ...
                DensityMatrix.GetImageMatrix(object.bitImage,object.template);
            %显示
            toc(); disp('CorrelationAnalyser初始化结束');
        end
        
        %显示例子
        function ShowDemo(object)
            %创建
            handle = figure(1);
            %设置标题
            set(handle,'name','环状密度分析(卷积算法)','Numbertitle','off');
            %创建子区域
            subplot(1,2,1);
            %显示被装载的图形
            imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
            %设置标题
            title(sprintf('%d×%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
            %创建子区域
            subplot(1,2,2); plot(1,1);
            %设置标题
            title('环状密度曲线图');
            %激活数据窗口
            subplot(1,2,1);

            %设置键盘输入相应
            set(handle,'KeyPressFcn',{@KeyPressFcn,object});
            %设置鼠标按下响应
            set(handle,'WindowButtonDownFcn',{@ButtonDownFcn,object});
            %设置鼠标移动响应
            set(handle,'WindowButtonMotionFcn',{@ButtonMotionFcn,object});
        end
        %键盘事件相应
        function KeyPressFcn(object,source,event)
            %检查按下的字符
            if event.Character == 27 %ESC
                %清理样本
                object.sample = [];
                %清理窗口恢复原始状态
                figure(source); subplot(1,2,1);
                %设置标题
                set(source,'name','环状密度分析(卷积算法)','Numbertitle','off');
                %重新加载图像
                hold off;
                imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
                %设置标题
                title(sprintf('%d×%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                %重新绘制坐标
                figure(source); subplot(1,2,2); hold off; plot(1,1);
                %设置标题
                title('环状密度曲线图');
                %激活原窗口坐标系
                figure(source); subplot(1,2,1);
            elseif event.Character == 'c'
                %检查样本
                if ~isempty(object.sample)
                    %获得行
                    row = object. ...
                        bitImage.GetRow();
                    %获得列
                    column = object. ...
                        bitImage.GetColumn();
                    %获得样本矢量
                    sampleVector = object. ...
                            sample.GetVector();
                    %获得坐标
                    [x,y] = object.sample.Get();
                    %创建矩阵
                    object.correlations = zeros(row,column);
                    %循环
                    for i = 1 : row
                        for j = 1 : column
                            %获得矢量
                            vector = object. ...
                                densityMatrix.GetVector(j,i);
                            %设置线性相关数值
                            object.correlations(row - i + 1,j) = Corrcoef. ...
                                                GetCorrcoef(vector,sampleVector);
                        end
                    end
                    %开始绘制图形
                    %清理窗口恢复原始状态
                    figure(source); subplot(1,2,1);
                    %设置标题
                    set(source,'name','环状密度分析(卷积算法)','Numbertitle','off');
                    %重新加载图像
                    hold off; colormap;
                    contourf(1:column,1:row,object.correlations(:,:)); colorbar; hold off;
                    %设置标题
                    title(sprintf('%d×%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                    %激活绘图区域
                    subplot(1,2,2);
                    %绘制当前矢量和参考矢量
                    hold on; plot(sampleVector,'g-'); hold off;
                    %设置图列
                    legend('参考值');
                    %设置标题
                    title('环状密度曲线图');
                    %激活原窗口坐标系
                    figure(source); subplot(1,2,1);
                end
            end
        end
        %键盘事件相应
        function ButtonDownFcn(object,source,event)
            %返回所有坐标架
            handle = findobj(source,'Type','axes');
            %从图像坐标架获得当前鼠标点
            pt = get(handle(2,1),'CurrentPoint');
            x = round(pt(1,1)); y = round(pt(1,2));
            %打印当前鼠标点的位置
            %fprintf('Current Point : x = %d, y = %d\r\n',x,y);
            %检查坐标
            if y >= 1 && y <= object.densityMatrix.GetRow() ...
                && x >= 1 && x <= object.densityMatrix.GetColumn()
                %积分数值数组
                vector = object. ...
                    densityMatrix.GetVector(x,y);
                %设置样本矢量
                object.sample = Density(x,y,vector);
                %用图表显示积分数值数组
                figure(source); 
                subplot(1,2,1);
                hold off;
                imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
                hold on; plot(x,y,'go'); hold off;
                %设置标题
                title(sprintf('%d×%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                subplot(1,2,2);
                hold off; plot(vector,'r--');
                hold on; plot(vector,'g-'); hold off;
                %设置标题
                title('环状密度曲线图');
                %设置图列
                legend('当前值','参考值');
                %激活原窗口坐标系
                figure(source); subplot(1,2,1);
            end
        end
        %键盘事件相应
        function ButtonMotionFcn(object,source,event)
            %返回所有坐标架
            handle = findobj(source,'Type','axes');
            %从图像坐标架获得当前鼠标点
            pt = get(handle(2,1),'CurrentPoint');
            x = round(pt(1,1)); y = round(pt(1,2));
            %检查坐标
            if y >= 1 && y <= object.densityMatrix.GetRow() ...
                && x >= 1 && x <= object.densityMatrix.GetColumn()
                %积分数值数组
                vector = object. ...
                    densityMatrix.GetVector(x,y);
                %用图表显示积分数值数组
                figure(source);
                %检查矢量
                if isempty(object.sample)
                    %激活绘图区域
                    subplot(1,2,2);
                    %仅绘制当前矢量
                    hold off; plot(vector); hold off;
                    %设置图列
                    legend('当前值');
                    %设置标题
                    title('环状密度曲线图');
                else
                    %激活绘图区域
                    subplot(1,2,1);
                    hold off;
                    imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
                    %设置标题
                    title(sprintf('%d×%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                    %获得坐标
                    [x,y] = object.sample.Get();
                    hold on; plot(x,y,'go'); hold off;
                    %激活绘图区域
                    subplot(1,2,2);
                    %绘制当前矢量和参考矢量
                    hold off; plot(vector,'r--'); 
                    hold on; plot(object.sample.GetVector(),'g-'); hold off;
                    %设置图列
                    legend('当前值','参考值');
                    %求线性相关性
                    result = Corrcoef. ...
                        GetCorrcoef(vector,object.sample.GetVector());
                    %显示相关系数
                    title(sprintf('环状密度曲线图\r\n样本相关系数=%f',result));
                end
                %激活原窗口坐标系
                figure(source); subplot(1,2,1);
            end
        end
    end
end