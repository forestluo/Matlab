classdef SQLite3Connection
    properties (Access = private)
        %数据库连接
        connection;
    end
    
    methods
        %检查是否有效
        function result = IsValid(object)
            %检查是否有效
            result = 1 - isempty(object.connection);
        end
        %关闭数据库链接
        function object = Close(object)
            %检查变量是否为空
            if isempty(object.connection) == 1 
                error('数据链接为空，数据库早已关闭！');
            end
            %关闭数据库链接
            close(object.connection);
        end
        %打开数据库链接
        function object = Open(object)
            %检查变量是否为空
            if isempty(object.connection) == 0 
                error('数据链接不为空，数据库早已开启！');
            end
            %创建数据库链接
            %object.connection = sqlite('E:\Matlab\LinguisticAnalyser\database\linguistic.db');
            object.connection = database('linguistic.db','','','org.sqlite.JDBC','jdbc:sqlite:E:/Matlab/LinguisticAnalyser/database/linguistic.db');
            %检查链接
            if isempty(object.connection) == 0
                %检查链接状态
                ping(object.connection);
                %打印数据库信息
                disp(object.connection);
            else
                error('无法建立数据库链接！');
            end
        end
        
        %执行语句
        function Execute(object,sqlString)
            %检查链接
            if isempty(object.connection) == 1
                error('数据链接尚未成功建立！');
            end
            %执行SQL语句
            curs = exec(object.connection,sqlString);
            %打印结果信息
            disp(curs.Message);
        end
        
        %删除索引
        function DropIndex(object,indexName)
            %检查链接
            if isempty(object.connection) == 1
                error('数据链接尚未成功建立！');
            end
            %执行SQL语句
            exec(object.connection,sprintf('DROP INDEX IF EXISTS %s',indexName));
        end
        %删除表
        function DropTable(object,tableName)
            %检查链接
            if isempty(object.connection) == 1
                error('数据链接尚未成功建立！');
            end
            %执行SQL语句
            exec(object.connection,sprintf('DROP TABLE IF EXISTS %s',tableName));
        end       
        %检查表是否存在
        function result = TableExist(object,tableName)
            %检查链接
            if isempty(object.connection) == 1
                error('数据链接尚未成功建立！');
            end
            %执行SQL语句
            cursor = exec(object.connection,sprintf('SELECT COUNT(*) AS COUNT FROM sqlite_master WHERE type=''table'' and name=''%s''',tableName));
            %返回数据结果
            data = fetch(cursor);
            %转化成矩阵结果
            data = cell2mat(data.Data);
            %关闭游标
            close(cursor);
            %检查数据结果
            result = data(1,1);
        end
    end
end