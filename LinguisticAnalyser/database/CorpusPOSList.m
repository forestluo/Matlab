classdef CorpusPOSList
    properties (Access = private)
        %数据库连接
        connection;
    end
    
    methods
        %关闭数据库链接
        function object = CorpusPOSList(connection)
            %检查变量是否为空
            if connection.IsValid() == 0 
                error('数据链接为空，数据库早已关闭！');
            end
            %设置数据库链接
            object.connection = connection;
        end
        
        %插入数据
        function Insert(object,code,name,remark)
            %检查链接是否有效
            if object.connection.IsValid() == 0
                error('无效的数据库链接！');
            end
            %生成SQL语句
            sqlString = ['INSERT INTO corpus_POS_list ' ...
                ' (code,name,remark) VALUES(''%s'',''%s'',''%s'')'];
            %格式化SQL语句
            sqlString = sprintf(sqlString,code,name,remark);
            %执行SQL语句
            object.connection.Execute(sqlString);
        end
        %创建数据表
        function CreateTable(object)
            %检查链接是否有效
            if object.connection.IsValid() == 0
                error('无效的数据库链接！');
            end
            %检查表是否存在
            disp('检查原表是否存在！');
            if object.connection.TableExist('corpus_POS_list') == 0
                disp('原数据表不存在！');
            else
                %删除原表
                disp('需要先删除原表！');
                object.connection.DropTable('corpus_POS_list');
            end
            %建表语句
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
            %执行建表语句
            disp('开始建立数据表！');
            object.connection.Execute(sqlString);
            disp('数据表已经建立！');
        end
        %预装数据集
        function Preinstall(object)
            %预装数据
            object.Insert('a','形容词','adjective');
            object.Insert('aq','性质形容词','adjective-quality');
            object.Insert('as','状态形容词','adjective-state');
            object.Insert('c','连词','conjunction');
            object.Insert('d','副词','adverb');
            object.Insert('e','叹词','exclamation');
            object.Insert('f','区别词','difference');
            object.Insert('g','语素词','“根”的汉语拼音首字母');
            object.Insert('ga','形容词性语素词','“根”的汉语拼音首字母-adjective');
            object.Insert('gn','名词性语素词','“根”的汉语拼音首字母-noun');
            object.Insert('gv','动词性语素词','“根”的汉语拼音首字母-verb');
            object.Insert('h','前接成分','head');
            object.Insert('i','习用语','idiom');
            object.Insert('ia','形容词性习用语','idiom-adjective');
            object.Insert('ic','连词性习用语','idiom-conjunction');
            object.Insert('in','名词性习用语','idiom-noun');
            object.Insert('iv','动词性习用语','idiom-verb');
            object.Insert('j','略缩语','“简”的汉语拼音首字母');
            object.Insert('ja','形容词性略缩语','“简”的汉语拼音首字母-adjective');
            object.Insert('jn','名词性略缩语','“简”的汉语拼音首字母-noun');
            object.Insert('jv','动词性略缩语','“简”的汉语拼音首字母-verb');
            object.Insert('k','后接成份','依据通常做法');
            object.Insert('m','数词','numeral');
            object.Insert('n','名词','noun');
            object.Insert('nd','方位名词','noun-direction');
            object.Insert('ng','普通名词','noun-general');
            object.Insert('nh','人名','noun-human');
            object.Insert('ni','机构词','noun-institution');
            object.Insert('nl','处所名','noun-location');
            object.Insert('nn','族词','noun-nation');
            object.Insert('ns','地名','noun-space');
            object.Insert('nt','时间名词','noun-time');
            object.Insert('nz','其他专有名词','noun-“专”的汉语拼音首字母');
            object.Insert('o','拟声词','onomatopoeia');
            object.Insert('p','介词','preposition');
            object.Insert('q','量词','quantity');
            object.Insert('r','代词','pronoun');
            object.Insert('u','助词','auxiliary');
            object.Insert('v','动词','verb');
            object.Insert('vd','趋向动词','verb-direction');
            object.Insert('vi','不及物动词','verb-intransitive');
            object.Insert('vl','联系动词','verb-link');
            object.Insert('vt','及物动词','verb-transitive');
            object.Insert('vu','能愿动词','verb-auxiliary');
            object.Insert('w','其他','依据通常做法');
            object.Insert('wp','标点符号','依据通常做法');
            object.Insert('ws','非汉字字符','“w”-string');
            object.Insert('wu','其他未知符号','“w”-unknown');
            object.Insert('x','非语素字','依据通常做法');
            %额外补充
            object.Insert('nhf','人名-姓','noun-human-familyname');
            object.Insert('nhs','人名-名','noun-human-surname');
            object.Insert('mq','数量词','numeral-quality');
        end
    end
end