%�������ݿ�����
dbConnection = SQLite3Connection();
%�����ݿ�����
disp('�����ݿ����ӣ�');
dbConnection = dbConnection.Open();
disp('���������Ѿ��򿪣�');

%��������
dbTable = CorpusWordList(dbConnection);
%�������ݱ�
dbTable.CreateTable();
%����Ԥװ����
disp('��ʼԤװ���ݣ�');
dbTable.Preinstall();
disp('����Ԥװ��ϣ�');

%�ر����ݿ�����
dbConnection.Close();
disp('���������Ѿ��رգ�');

%�������
clear dbTable;
clear dbConnection;
disp('��ʱ������������ϣ�');
