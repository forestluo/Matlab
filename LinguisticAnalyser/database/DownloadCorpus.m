url = 'http://www.aihanyu.org/cncorpus/CnCindex.aspx';
data = webread(url);

%options = weboptions('RequestMethod','POST','UserAgent','Mozilla/5.0');

%data = webread(url,'TextBoxCCkeywords','����','DropDownListPSize',500,'Button1','��  ��','1','RBindexword','2','RadionButton3','CheckBoxChuchu','on',options);