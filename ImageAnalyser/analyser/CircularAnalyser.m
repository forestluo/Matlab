classdef CircularAnalyser
    properties (Access = private)
        %被分析的图形
        bitImage;
        %积分模板
        template;
    end
    
    methods
        %构造函数
        function object = ...
            CircularAnalyser(fileName,radius)
            %转换成整数
            radius = int32(radius);
            %检查数值
            if radius < 3
                error('CircularAnalyser半径必须不小于3');
            end
            %创建被分析的图形
            object.bitImage = BitImage(fileName);
            %创建圆积分模板
            object.template = ConcentricTemplate(radius);
        end
        
        %显示例子
        function ShowDemo(object)
            %创建
            handle = figure(1);
            %设置标题
            set(handle,'name','环状密度分析','Numbertitle','off');
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
                %清理窗口恢复原始状态
                figure(source); subplot(1,2,1);
                %设置标题
                set(source,'name','环状密度分析','Numbertitle','off');
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
        end
        %键盘事件相应
        function ButtonMotionFcn(object,source,event)
            %返回所有坐标架
            handle = findobj(source,'Type','axes');
            %从图像坐标架获得当前鼠标点
            pt = get(handle(2,1),'CurrentPoint');
            x = round(pt(1,1)); y = round(pt(1,2));
            %检查坐标值
            if y >= 1 && y <= object.bitImage.GetRow() ...
                && x >= 1 && x <= object.bitImage.GetColumn()
                %积分数值数组
                %使用常规算法
                result = object.template. ...
                    GetDensity(x,y,object.bitImage);
                %使用卷积算法
                fastResult = object.template. ...
                    GetFastDensity(x,y,object.bitImage);
                %用图表显示积分数值数组
                figure(source); subplot(1,2,2);
                hold off; plot(result,'g-'); hold on; plot(fastResult,'r--'); hold off;
                %设置图例
                legend('常规算法','卷积算法');
                %设置标题
                title('环状密度曲线图');
                %激活原窗口坐标系
                figure(source); subplot(1,2,1);
            end
        end
    end
end