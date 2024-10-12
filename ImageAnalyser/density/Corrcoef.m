classdef Corrcoef
    methods (Static = true)
        %������ϵ��
        function result = GetCorrcoef(v1,v2)
            %������֮��������
            value = corrcoef(v1,v2);
            %��ƽ��ֵ�ľ���ֵ
            result = (value(1,2) + value(2,1)) / 2.0;
        end
        
        %������ϵ��
        function result = GetCorrcoef2(v1,v2)
            %��鿪ʼ����
            if v1(1) == 0 && v2(1) == 0
                %ѭ��λ�ƣ�ȥ��ǰ������
                i = 0;
                while v1(1) == 0 && ...
                        i < size(v1,1)
                    i = i + 1;
                    v1 = circshift(v1,-1);
                end
                %ѭ��λ�ƣ�ȥ��ǰ������
                i = 0;
                while v2(1) == 0 && ...
                        i < size(v2,1)
                    i = i + 1;
                    v2 = circshift(v1,-1);
                end
            elseif v1(1) == 1 && v2(1) == 1
                %ѭ��λ�ƣ�ȥ��ǰ������
                i = 0;
                while v1(1) == 1 && ...
                        i < size(v1,1)
                    i = i + 1;
                    v1(1) = 0;
                    v1 = circshift(v1,-1);
                end
                %ѭ��λ�ƣ�ȥ��ǰ������
                i = 0;
                while v2(1) == 1 && ...
                        i < size(v2,1)
                    i = i + 1;
                    v2(1) = 0;
                    v2 = circshift(v2,-1);
                end
            end
            %������֮��������
            value = corrcoef(v1,v2);
            %��ƽ��ֵ�ľ���ֵ
            result = (value(1,2) + value(2,1)) / 2.0;
        end
    end
end
