classdef CircularAnalyser
    properties (Access = private)
        %��������ͼ��
        bitImage;
        %����ģ��
        template;
    end
    
    methods
        %���캯��
        function object = ...
            CircularAnalyser(fileName,radius)
            %ת��������
            radius = int32(radius);
            %�����ֵ
            if radius < 3
                error('CircularAnalyser�뾶���벻С��3');
            end
            %������������ͼ��
            object.bitImage = BitImage(fileName);
            %����Բ����ģ��
            object.template = ConcentricTemplate(radius);
        end
        
        %��ʾ����
        function ShowDemo(object)
            %����
            handle = figure(1);
            %���ñ���
            set(handle,'name','��״�ܶȷ���','Numbertitle','off');
            %����������
            subplot(1,2,1);
            %��ʾ��װ�ص�ͼ��
            imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
            %���ñ���
            title(sprintf('%d��%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
            %����������
            subplot(1,2,2); plot(1,1);
            %���ñ���
            title('��״�ܶ�����ͼ');
            %�������ݴ���
            subplot(1,2,1);

            %���ü���������Ӧ
            set(handle,'KeyPressFcn',{@KeyPressFcn,object});
            %������갴����Ӧ
            set(handle,'WindowButtonDownFcn',{@ButtonDownFcn,object});
            %��������ƶ���Ӧ
            set(handle,'WindowButtonMotionFcn',{@ButtonMotionFcn,object});
        end
        %�����¼���Ӧ
        function KeyPressFcn(object,source,event)
            %��鰴�µ��ַ�
            if event.Character == 27 %ESC
                %�����ڻָ�ԭʼ״̬
                figure(source); subplot(1,2,1);
                %���ñ���
                set(source,'name','��״�ܶȷ���','Numbertitle','off');
                %���¼���ͼ��
                hold off;
                imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
                %���ñ���
                title(sprintf('%d��%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                %���»�������
                figure(source); subplot(1,2,2); hold off; plot(1,1);
                %���ñ���
                title('��״�ܶ�����ͼ');
                %����ԭ��������ϵ
                figure(source); subplot(1,2,1);
            end
        end
        %�����¼���Ӧ
        function ButtonDownFcn(object,source,event)
            %�������������
            handle = findobj(source,'Type','axes');
            %��ͼ������ܻ�õ�ǰ����
            pt = get(handle(2,1),'CurrentPoint');
            x = round(pt(1,1)); y = round(pt(1,2));
            %��ӡ��ǰ�����λ��
            %fprintf('Current Point : x = %d, y = %d\r\n',x,y);
        end
        %�����¼���Ӧ
        function ButtonMotionFcn(object,source,event)
            %�������������
            handle = findobj(source,'Type','axes');
            %��ͼ������ܻ�õ�ǰ����
            pt = get(handle(2,1),'CurrentPoint');
            x = round(pt(1,1)); y = round(pt(1,2));
            %�������ֵ
            if y >= 1 && y <= object.bitImage.GetRow() ...
                && x >= 1 && x <= object.bitImage.GetColumn()
                %������ֵ����
                %ʹ�ó����㷨
                result = object.template. ...
                    GetDensity(x,y,object.bitImage);
                %ʹ�þ���㷨
                fastResult = object.template. ...
                    GetFastDensity(x,y,object.bitImage);
                %��ͼ����ʾ������ֵ����
                figure(source); subplot(1,2,2);
                hold off; plot(result,'g-'); hold on; plot(fastResult,'r--'); hold off;
                %����ͼ��
                legend('�����㷨','����㷨');
                %���ñ���
                title('��״�ܶ�����ͼ');
                %����ԭ��������ϵ
                figure(source); subplot(1,2,1);
            end
        end
    end
end