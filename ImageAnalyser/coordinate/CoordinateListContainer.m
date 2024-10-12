classdef CoordinateListContainer < SimpleList
    methods
        %����ʸ��
        function object = ...
            AddVector(object,vector)
            %���Ӷ���
            object = object.AddElement(vector);
        end
        
        %��ʸ�����Ȼ�����ͼ��
        function Plot(object)
            %��ñ�����
            browser = object.GetBrowser();
            %��õ�ǰλ��
            position = browser.GetPosition();
            %ִ��ѭ��
            while ~isempty(position)
                %��õ�ǰ����
                vector = position.Data;
                %�ƶ�����һ��λ��
                browser = ...
                    browser.GetNextPosition();
                %��õ�ǰ����
                position = object.GetPosition();
                %����ͼ��
                plot(vector.GetRadius(),vector.GetLength(),'go'); hold on;
            end
            %���ñ��⼰�����ı���ʶ
            title('ʸ��������ȡ�����Ա�ͼ'); legend('ȡ����'); hold off;
        end        
    end
end