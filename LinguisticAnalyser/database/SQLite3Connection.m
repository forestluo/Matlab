classdef SQLite3Connection
    properties (Access = private)
        %���ݿ�����
        connection;
    end
    
    methods
        %����Ƿ���Ч
        function result = IsValid(object)
            %����Ƿ���Ч
            result = 1 - isempty(object.connection);
        end
        %�ر����ݿ�����
        function object = Close(object)
            %�������Ƿ�Ϊ��
            if isempty(object.connection) == 1 
                error('��������Ϊ�գ����ݿ����ѹرգ�');
            end
            %�ر����ݿ�����
            close(object.connection);
        end
        %�����ݿ�����
        function object = Open(object)
            %�������Ƿ�Ϊ��
            if isempty(object.connection) == 0 
                error('�������Ӳ�Ϊ�գ����ݿ����ѿ�����');
            end
            %�������ݿ�����
            %object.connection = sqlite('E:\Matlab\LinguisticAnalyser\database\linguistic.db');
            object.connection = database('linguistic.db','','','org.sqlite.JDBC','jdbc:sqlite:E:/Matlab/LinguisticAnalyser/database/linguistic.db');
            %�������
            if isempty(object.connection) == 0
                %�������״̬
                ping(object.connection);
                %��ӡ���ݿ���Ϣ
                disp(object.connection);
            else
                error('�޷��������ݿ����ӣ�');
            end
        end
        
        %ִ�����
        function Execute(object,sqlString)
            %�������
            if isempty(object.connection) == 1
                error('����������δ�ɹ�������');
            end
            %ִ��SQL���
            curs = exec(object.connection,sqlString);
            %��ӡ�����Ϣ
            disp(curs.Message);
        end
        
        %ɾ������
        function DropIndex(object,indexName)
            %�������
            if isempty(object.connection) == 1
                error('����������δ�ɹ�������');
            end
            %ִ��SQL���
            exec(object.connection,sprintf('DROP INDEX IF EXISTS %s',indexName));
        end
        %ɾ����
        function DropTable(object,tableName)
            %�������
            if isempty(object.connection) == 1
                error('����������δ�ɹ�������');
            end
            %ִ��SQL���
            exec(object.connection,sprintf('DROP TABLE IF EXISTS %s',tableName));
        end       
        %�����Ƿ����
        function result = TableExist(object,tableName)
            %�������
            if isempty(object.connection) == 1
                error('����������δ�ɹ�������');
            end
            %ִ��SQL���
            cursor = exec(object.connection,sprintf('SELECT COUNT(*) AS COUNT FROM sqlite_master WHERE type=''table'' and name=''%s''',tableName));
            %�������ݽ��
            data = fetch(cursor);
            %ת���ɾ�����
            data = cell2mat(data.Data);
            %�ر��α�
            close(cursor);
            %������ݽ��
            result = data(1,1);
        end
    end
end