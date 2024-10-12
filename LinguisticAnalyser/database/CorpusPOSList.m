classdef CorpusPOSList
    properties (Access = private)
        %���ݿ�����
        connection;
    end
    
    methods
        %�ر����ݿ�����
        function object = CorpusPOSList(connection)
            %�������Ƿ�Ϊ��
            if connection.IsValid() == 0 
                error('��������Ϊ�գ����ݿ����ѹرգ�');
            end
            %�������ݿ�����
            object.connection = connection;
        end
        
        %��������
        function Insert(object,code,name,remark)
            %��������Ƿ���Ч
            if object.connection.IsValid() == 0
                error('��Ч�����ݿ����ӣ�');
            end
            %����SQL���
            sqlString = ['INSERT INTO corpus_POS_list ' ...
                ' (code,name,remark) VALUES(''%s'',''%s'',''%s'')'];
            %��ʽ��SQL���
            sqlString = sprintf(sqlString,code,name,remark);
            %ִ��SQL���
            object.connection.Execute(sqlString);
        end
        %�������ݱ�
        function CreateTable(object)
            %��������Ƿ���Ч
            if object.connection.IsValid() == 0
                error('��Ч�����ݿ����ӣ�');
            end
            %�����Ƿ����
            disp('���ԭ���Ƿ���ڣ�');
            if object.connection.TableExist('corpus_POS_list') == 0
                disp('ԭ���ݱ����ڣ�');
            else
                %ɾ��ԭ��
                disp('��Ҫ��ɾ��ԭ��');
                object.connection.DropTable('corpus_POS_list');
            end
            %�������
            sqlString = ['CREATE TABLE IF NOT EXISTS ' ...
                '"corpus_POS_list" ' ...
                ' (' ...
                '   [code] VARCHAR2(8) NOT NULL UNIQUE, ' ...
                '   [name] VARCHAR2(255) NOT NULL, ' ...
                '   [remark] TEXT, ' ...
                '   [created] TIMESTAMP NOT NULL DEFAULT (DATETIME (''NOW'')), ' ...
                '   [updated] TIMESTAMP, ' ...
                '   PRIMARY KEY([code]) ' ...
                ' )'];
            %ִ�н������
            disp('��ʼ�������ݱ�');
            object.connection.Execute(sqlString);
            disp('���ݱ��Ѿ�������');
        end
        %Ԥװ���ݼ�
        function Preinstall(object)
            %Ԥװ����
            object.Insert('a','���ݴ�','adjective');
            object.Insert('aq','�������ݴ�','adjective-quality');
            object.Insert('as','״̬���ݴ�','adjective-state');
            object.Insert('c','����','conjunction');
            object.Insert('d','����','adverb');
            object.Insert('e','̾��','exclamation');
            object.Insert('f','�����','difference');
            object.Insert('g','���ش�','�������ĺ���ƴ������ĸ');
            object.Insert('ga','���ݴ������ش�','�������ĺ���ƴ������ĸ-adjective');
            object.Insert('gn','���������ش�','�������ĺ���ƴ������ĸ-noun');
            object.Insert('gv','���������ش�','�������ĺ���ƴ������ĸ-verb');
            object.Insert('h','ǰ�ӳɷ�','head');
            object.Insert('i','ϰ����','idiom');
            object.Insert('ia','���ݴ���ϰ����','idiom-adjective');
            object.Insert('ic','������ϰ����','idiom-conjunction');
            object.Insert('in','������ϰ����','idiom-noun');
            object.Insert('iv','������ϰ����','idiom-verb');
            object.Insert('j','������','���򡱵ĺ���ƴ������ĸ');
            object.Insert('ja','���ݴ���������','���򡱵ĺ���ƴ������ĸ-adjective');
            object.Insert('jn','������������','���򡱵ĺ���ƴ������ĸ-noun');
            object.Insert('jv','������������','���򡱵ĺ���ƴ������ĸ-verb');
            object.Insert('k','��ӳɷ�','����ͨ������');
            object.Insert('m','����','numeral');
            object.Insert('n','����','noun');
            object.Insert('nd','��λ����','noun-direction');
            object.Insert('ng','��ͨ����','noun-general');
            object.Insert('nh','����','noun-human');
            object.Insert('ni','������','noun-institution');
            object.Insert('nl','������','noun-location');
            object.Insert('nn','���','noun-nation');
            object.Insert('ns','����','noun-space');
            object.Insert('nt','ʱ������','noun-time');
            object.Insert('nz','����ר������','noun-��ר���ĺ���ƴ������ĸ');
            object.Insert('o','������','onomatopoeia');
            object.Insert('p','���','preposition');
            object.Insert('q','����','quantity');
            object.Insert('r','����','pronoun');
            object.Insert('u','����','auxiliary');
            object.Insert('v','����','verb');
            object.Insert('vd','���򶯴�','verb-direction');
            object.Insert('vi','�����ﶯ��','verb-intransitive');
            object.Insert('vl','��ϵ����','verb-link');
            object.Insert('vt','���ﶯ��','verb-transitive');
            object.Insert('vu','��Ը����','verb-auxiliary');
            object.Insert('w','����','����ͨ������');
            object.Insert('wp','������','����ͨ������');
            object.Insert('ws','�Ǻ����ַ�','��w��-string');
            object.Insert('wu','����δ֪����','��w��-unknown');
            object.Insert('x','��������','����ͨ������');
            %���ⲹ��
            object.Insert('nhf','����-��','noun-human-familyname');
            object.Insert('nhs','����-��','noun-human-surname');
            object.Insert('mq','������','numeral-quality');
        end
    end
end