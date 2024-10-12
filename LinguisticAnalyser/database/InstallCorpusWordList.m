%建立数据库链接
dbConnection = SQLite3Connection();
%打开数据库链接
disp('打开数据库链接！');
dbConnection = dbConnection.Open();
disp('数据链接已经打开！');

%创建对象
dbTable = CorpusWordList(dbConnection);
%创建数据表
dbTable.CreateTable();
%加入预装数据
disp('开始预装数据！');
dbTable.Preinstall();
disp('数据预装完毕！');

%关闭数据库链接
dbConnection.Close();
disp('数据链接已经关闭！');

%清理对象
clear dbTable;
clear dbConnection;
disp('临时对象已清理完毕！');
