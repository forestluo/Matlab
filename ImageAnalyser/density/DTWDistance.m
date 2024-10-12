classdef DTWDistance
    methods (Static = true)
        %��þ���
        function result = GetDistance(v1,v2)
            %�������е�֡��
            n = size(v1,1);
            m = size(v2,1);
            %֡ƥ��������
            d = zeros(n,m);
            for i = 1 : n
                for j = 1 : m
                    d(i,j) = sum((v1(i) - v2(j)).^2);
                end
            end
            %�ۻ��������
            D = ones(n,m) * realmax;
            D(1,1) = d(1,1);
            %��̬�滮
            for i = 2 : n
                for j = 1 : m
                    D1 = D(i - 1,j);
                    if j > 1
                        D2 = D(i - 1,j - 1);
                    else
                        D2 = realmax;
                    end
                    if j > 2
                        D3 = D(i - 1,j - 2);
                    else
                        D3 = realmax;
                    end
                    D(i,j) = d(i,j) + min([D1,D2,D3]);
                end
            end
            result = D(n,m);            
        end
    end
end