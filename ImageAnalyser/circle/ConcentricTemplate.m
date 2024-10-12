classdef ConcentricTemplate
    properties (Access = private)
        %���뾶
        radius;
        %Բģ��
        circles;
    end
    
    methods
        %���캯��
        function object = ConcentricTemplate(radius)
            %�������
            radius = int32(radius);
            %�����
            if radius < 3
                error('ConcentricTemplate�뾶����С��3');
            end
            %���ð뾶
            object.radius = radius;
            %����Բģ��
            object.circles = ...
                repmat(CircleTemplate.empty,radius);
            %��������Բ����ģ��
            for i = 1 : radius
                %����Բ����ģ��
                object.circles(i) = CircleTemplate(i);
            end
        end

        %��ð뾶
        function radius = GetRadius(object)
            %���ذ뾶��ֵ
            radius = object.radius;
        end
        %���ģ��
        function circle = GetCircle(object,index)
            %�������
            index = int32(index);
            %�����
            if index < 1 || index > object.radius
                error('��������ģ��������Χ');
            end
            %����ģ��
            circle = object.circles(index);
        end

        %��õ�״�ܶ�ʸ��
        function vector = GetDensity(object,x,y,image)
            %�������
            x = int32(x); y = int32(y);
            %�������ֵ
            if y < 1 || y > image.GetRow() ...
                || x < 1 || x > image.GetColumn()
                error('���괦��ͼ��Χ֮��');
            end
            %������ֵ����
            vector = ...
                zeros(1,object.radius);
            %ִ��ѭ��
            for i = 1 : object.radius
                %��þ���
                circle = object.circles(i);
                %��õ���������ֵ
                vector(1,i) = circle.GetDensity(x,y,image);
            end
        end
        %��õ�״�ܶ�ʸ��
        function vector = GetFastDensity(object,x,y,image)
            %�������
            x = int32(x); y = int32(y);
            %�������ֵ
            if y < 1 || y > image.GetRow() ...
                || x < 1 || x > image.GetColumn()
                error('���괦��ͼ��Χ֮��');
            end
            %������ֵ����
            vector = ...
                zeros(1,object.radius);
            %ִ��ѭ��
            for i = 1 : object.radius
                %��þ���
                circle = object.circles(i);
                %��õ���������ֵ
                vector(1,i) = circle.GetFastDensity(x,y,image);
            end
        end
        
        %��ʸ�����Ȼ�����ͼ��
        function Plot(object)
            %ִ��ѭ��
            for i = 1 : object.radius
                %Բģ��
                circle = object.circles(i);
                %����ͼ��
                plot(circle.GetRadius(),circle.GetLength(),'go'); hold on;
            end
            %��ֱ��
            plot([1 object.radius],[2 * pi,2 * pi * object.radius],'r-');
            %���ñ��⼰��������ı���ʶ
            text(double(1 + object.radius) / 2 , ...
                pi * double(1 + object.radius),'Բ�ܳ���ʽ��C = 2\piR');
            title('Բģ�峤����ȡ�����Ա�ͼ'); legend('ȡ����'); hold off;
        end
    end
end
