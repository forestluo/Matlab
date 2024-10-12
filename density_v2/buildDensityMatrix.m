function buildDensityMatrix(fileName)
    
    %全局变量
    global sample;
    global row;
    global column;
    %全局变量
    global range;
    global linearDensityMatrix;
    global angularDensityMatrix;
    
    %打印消息
    fprintf('Corresponding data file(%s) of image !\r\n',fileName);
    
    %检查文件是否存在
    if exist(fileName,'file')
        %装载数据文件
        load(fileName,'linearDensityMatrix');
        %打印消息
        fprintf('Linear density matrix was loaded !\r\n');
        %装载数据文件
        load(fileName,'angularDensityMatrix');
        %打印消息
        fprintf('Angular density matrix was loaded !\r\n');
    else
        %对图像求反
        invertedSample = ~sample;
        %初始化数值
        for n = 1 : row
            %打印信息
            fprintf('Initialize line(%d) of density matrix !\r\n',n);
            %执行循环
            for m = 1 : column
                %求全向线性密度
                [vector] = getLinearDensityVector(invertedSample,m,n);
                %拷贝数组数值
                for k = 1 : range + 1
                    linearDensityMatrix(n,m,k) = vector(1,k); end
                %清理变量
                clear vector;
                
                %求全向角度密度
                [vector] = getAngularDensityVector(invertedSample,m,n);
                %拷贝数组数值
                for k = 1 : 4 * range
                    angularDensityMatrix(n,m,k) = vector(1,k); end
                %清理变量
                clear vector;
            end
        end
        %打印消息
        fprintf('Density matrix was created !\r\n');
        %保存密度矩阵文件
        save(fileName,'linearDensityMatrix','angularDensityMatrix');
    end
end