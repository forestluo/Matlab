function loadImageFile(imageName,keep)
    %全局变量
    global sample;
    global row;
    global column;
    
    %读取图像
    sample = imread(imageName);
    %检查变量
    if keep == 0
        %检查图像尺寸
        if row <= 0 || column <= 0
            %设置缺省数值
            row = 256;
            column = 256;
            %打印消息
            fprintf('Invalid row or column !\r\n');
        end
        %调整为256*256大小
        sample = imresize(sample,[row,column]);
    end
    %转换成灰度
    sample = im2bw(sample);
    %获得尺寸
    [row,column] = size(sample);
    %打印消息
    fprintf('Image file(%s) was loaded !\r\n',imageName);
    fprintf('\trow = %d\r\n',row);
    fprintf('\tcolumn = %d\r\n',column);
end