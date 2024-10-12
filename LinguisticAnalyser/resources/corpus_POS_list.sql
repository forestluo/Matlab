DROP TABLE IF EXISTS "corpus_POS_list";

CREATE TABLE IF NOT EXISTS "corpus_POS_list" (
  [code] VARCHAR2(2) NOT NULL UNIQUE,
  [name] VARCHAR2(255) NOT NULL,
  [remark] TEXT,
  [created] TIMESTAMP NOT NULL DEFAULT (DATETIME ('NOW')),
  [updated] TIMESTAMP,
  PRIMARY KEY([code]));

INSERT INTO corpus_POS_list (code,name,remark) VALUES ("a","形容词","adjective");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("aq","性质形容词","adjective-quality");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("as","状态形容词","adjective-state");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("c","连词","conjunction");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("d","副词","adverb");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("e","叹词","exclamation");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("f","区别词","difference");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("g","形容词","“根”的汉语拼音首字母");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ga","形容词性语素词","“根”的汉语拼音首字母-adjective");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("gn","名词性语素词","“根”的汉语拼音首字母-noun");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("gv","动词性语素词","“根”的汉语拼音首字母-verb");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("h","前接成分","head");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("i","习用语","idiom");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ia","形容词性习用语","idiom-adjective");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ic","连词性习用语","idiom-conjunction");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("in","名词性习用语","idiom-noun");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("iv","动词性习用语","idiom-verb");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("j","略缩语","“简”的汉语拼音首字母");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ja","形容词性略缩语","“简”的汉语拼音首字母-adjective");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("jn","名词性略缩语","“简”的汉语拼音首字母-noun");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("jv","动词性略缩语","“简”的汉语拼音首字母-verb");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("k","后接成份","依据通常做法");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("m","数词","numeral");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("n","名词","noun");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("nd","方位名词","noun-direction");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ng","普通名词","noun-general");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("nh","人名","noun-human");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ni","机构词","noun-institution");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("nl","处所名","noun-location");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("nn","族词","noun-nation");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ns","地名","noun-space");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("nt","时间名词","noun-time");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("nz","其他专有名词","noun-“专”的汉语拼音首字母");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("o","拟声词","onomatopoeia");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("p","介词","preposition");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("q","量词","quantity");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("r","代词","pronoun");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("u","助词","auxiliary");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("v","动词","verb");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("vd","趋向动词","verb-direction");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("vi","不及物动词","verb-intransitive");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("vl","联系动词","verb-link");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("vt","及物动词","verb-transitive");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("vu","能愿动词","verb-auxiliary");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("w","其他","依据通常做法");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("wp","标点符号","依据通常做法");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("ws","非汉字字符","“w”-string");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("wu","其他未知符号","“w”-unknown");
INSERT INTO corpus_POS_list (code,name,remark) VALUES ("x","非语素字","依据通常做法");

SELECT * FROM corpus_POS_list;