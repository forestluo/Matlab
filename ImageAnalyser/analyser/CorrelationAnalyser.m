classdef CorrelationAnalyser < handle
    properties (Access = private)       
        %��������ͼ��
        bitImage;
        %����ģ��
        template;
        %�ܶȾ���
        densityMatrix;

        %����
        sample;
        %�����
        correlations;
    end
    
    methods
        %���캯��
        function object = ...
            CorrelationAnalyser(fileName,radius)
            %ת��������
            radius = int32(radius);
            %�����ֵ
            if radius < 3
                error('CorrelationAnalyser�뾶���벻С��3');
            end
            %��ʾ
            disp('��ʼ��ʼ��CorrelationAnalyser');
            %������������ͼ��
            disp('����ͼ���ļ�'); tic();
            object.bitImage = BitImage(fileName);
            %����Բ����ģ��
            toc(); disp('����Բ����ģ��'); tic();
            object.template = ConcentricTemplate(radius);
            %�����ܶȾ���
            toc(); disp('����Բ�ܶȾ���'); tic();
            object.densityMatrix = ...
                DensityMatrix.GetImageMatrix(object.bitImage,object.template);
            %��ʾ
            toc(); disp('CorrelationAnalyser��ʼ������');
        end
        
        %��ʾ����
        function ShowDemo(object)
            %����
            handle = figure(1);
            %���ñ���
            set(handle,'name','��״�ܶȷ���(����㷨)','Numbertitle','off');
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
                %��������
                object.sample = [];
                %�����ڻָ�ԭʼ״̬
                figure(source); subplot(1,2,1);
                %���ñ���
                set(source,'name','��״�ܶȷ���(����㷨)','Numbertitle','off');
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
            elseif event.Character == 'c'
                %�������
                if ~isempty(object.sample)
                    %�����
                    row = object. ...
                        bitImage.GetRow();
                    %�����
                    column = object. ...
                        bitImage.GetColumn();
                    %�������ʸ��
                    sampleVector = object. ...
                            sample.GetVector();
                    %�������
                    [x,y] = object.sample.Get();
                    %��������
                    object.correlations = zeros(row,column);
                    %ѭ��
                    for i = 1 : row
                        for j = 1 : column
                            %���ʸ��
                            vector = object. ...
                                densityMatrix.GetVector(j,i);
                            %�������������ֵ
                            object.correlations(row - i + 1,j) = Corrcoef. ...
                                                GetCorrcoef(vector,sampleVector);
                        end
                    end
                    %��ʼ����ͼ��
                    %�����ڻָ�ԭʼ״̬
                    figure(source); subplot(1,2,1);
                    %���ñ���
                    set(source,'name','��״�ܶȷ���(����㷨)','Numbertitle','off');
                    %���¼���ͼ��
                    hold off; colormap;
                    contourf(1:column,1:row,object.correlations(:,:)); colorbar; hold off;
                    %���ñ���
                    title(sprintf('%d��%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                    %�����ͼ����
                    subplot(1,2,2);
                    %���Ƶ�ǰʸ���Ͳο�ʸ��
                    hold on; plot(sampleVector,'g-'); hold off;
                    %����ͼ��
                    legend('�ο�ֵ');
                    %���ñ���
                    title('��״�ܶ�����ͼ');
                    %����ԭ��������ϵ
                    figure(source); subplot(1,2,1);
                end
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
            %�������
            if y >= 1 && y <= object.densityMatrix.GetRow() ...
                && x >= 1 && x <= object.densityMatrix.GetColumn()
                %������ֵ����
                vector = object. ...
                    densityMatrix.GetVector(x,y);
                %��������ʸ��
                object.sample = Density(x,y,vector);
                %��ͼ����ʾ������ֵ����
                figure(source); 
                subplot(1,2,1);
                hold off;
                imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
                hold on; plot(x,y,'go'); hold off;
                %���ñ���
                title(sprintf('%d��%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                subplot(1,2,2);
                hold off; plot(vector,'r--');
                hold on; plot(vector,'g-'); hold off;
                %���ñ���
                title('��״�ܶ�����ͼ');
                %����ͼ��
                legend('��ǰֵ','�ο�ֵ');
                %����ԭ��������ϵ
                figure(source); subplot(1,2,1);
            end
        end
        %�����¼���Ӧ
        function ButtonMotionFcn(object,source,event)
            %�������������
            handle = findobj(source,'Type','axes');
            %��ͼ������ܻ�õ�ǰ����
            pt = get(handle(2,1),'CurrentPoint');
            x = round(pt(1,1)); y = round(pt(1,2));
            %�������
            if y >= 1 && y <= object.densityMatrix.GetRow() ...
                && x >= 1 && x <= object.densityMatrix.GetColumn()
                %������ֵ����
                vector = object. ...
                    densityMatrix.GetVector(x,y);
                %��ͼ����ʾ������ֵ����
                figure(source);
                %���ʸ��
                if isempty(object.sample)
                    %�����ͼ����
                    subplot(1,2,2);
                    %�����Ƶ�ǰʸ��
                    hold off; plot(vector); hold off;
                    %����ͼ��
                    legend('��ǰֵ');
                    %���ñ���
                    title('��״�ܶ�����ͼ');
                else
                    %�����ͼ����
                    subplot(1,2,1);
                    hold off;
                    imshow(object.bitImage.GetImage(),'InitialMagnification','fit');
                    %���ñ���
                    title(sprintf('%d��%d',object.bitImage.GetRow(),object.bitImage.GetColumn()));
                    %�������
                    [x,y] = object.sample.Get();
                    hold on; plot(x,y,'go'); hold off;
                    %�����ͼ����
                    subplot(1,2,2);
                    %���Ƶ�ǰʸ���Ͳο�ʸ��
                    hold off; plot(vector,'r--'); 
                    hold on; plot(object.sample.GetVector(),'g-'); hold off;
                    %����ͼ��
                    legend('��ǰֵ','�ο�ֵ');
                    %�����������
                    result = Corrcoef. ...
                        GetCorrcoef(vector,object.sample.GetVector());
                    %��ʾ���ϵ��
                    title(sprintf('��״�ܶ�����ͼ\r\n�������ϵ��=%f',result));
                end
                %����ԭ��������ϵ
                figure(source); subplot(1,2,1);
            end
        end
    end
end