classdef CoordinateList < SimpleList
    methods
        %��������
        function object = ...
            AddCoordinate(object,coordinate)
            %���Ӷ���
            object = object.AddElement(coordinate);
        end

        %�����е������ͼ��
        function Plot(object)
            %��ñ�����
            browser = object.GetBrowser();
            %��õ�ǰλ��
            position = browser.GetPosition();
            %ִ��ѭ��
            while ~isempty(position)
                %��õ�ǰ����
                coordinate = position.Data;
                %�ƶ�����һ��λ��
                browser = ...
                    browser.GetNextPosition();
                %��õ�ǰ����
                position = browser.GetPosition();
                %���������
                plot(coordinate.GetX(),coordinate.GetY(),'go'); hold on;
            end
        end
    end
end
