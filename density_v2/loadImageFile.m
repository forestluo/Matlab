function loadImageFile(imageName,keep)
    %ȫ�ֱ���
    global sample;
    global row;
    global column;
    
    %��ȡͼ��
    sample = imread(imageName);
    %������
    if keep == 0
        %���ͼ��ߴ�
        if row <= 0 || column <= 0
            %����ȱʡ��ֵ
            row = 256;
            column = 256;
            %��ӡ��Ϣ
            fprintf('Invalid row or column !\r\n');
        end
        %����Ϊ256*256��С
        sample = imresize(sample,[row,column]);
    end
    %ת���ɻҶ�
    sample = im2bw(sample);
    %��óߴ�
    [row,column] = size(sample);
    %��ӡ��Ϣ
    fprintf('Image file(%s) was loaded !\r\n',imageName);
    fprintf('\trow = %d\r\n',row);
    fprintf('\tcolumn = %d\r\n',column);
end