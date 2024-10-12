function buildDensityMatrix(fileName)
    
    %ȫ�ֱ���
    global sample;
    global row;
    global column;
    %ȫ�ֱ���
    global range;
    global linearDensityMatrix;
    global angularDensityMatrix;
    
    %��ӡ��Ϣ
    fprintf('Corresponding data file(%s) of image !\r\n',fileName);
    
    %����ļ��Ƿ����
    if exist(fileName,'file')
        %װ�������ļ�
        load(fileName,'linearDensityMatrix');
        %��ӡ��Ϣ
        fprintf('Linear density matrix was loaded !\r\n');
        %װ�������ļ�
        load(fileName,'angularDensityMatrix');
        %��ӡ��Ϣ
        fprintf('Angular density matrix was loaded !\r\n');
    else
        %��ͼ����
        invertedSample = ~sample;
        %��ʼ����ֵ
        for n = 1 : row
            %��ӡ��Ϣ
            fprintf('Initialize line(%d) of density matrix !\r\n',n);
            %ִ��ѭ��
            for m = 1 : column
                %��ȫ�������ܶ�
                [vector] = getLinearDensityVector(invertedSample,m,n);
                %����������ֵ
                for k = 1 : range + 1
                    linearDensityMatrix(n,m,k) = vector(1,k); end
                %�������
                clear vector;
                
                %��ȫ��Ƕ��ܶ�
                [vector] = getAngularDensityVector(invertedSample,m,n);
                %����������ֵ
                for k = 1 : 4 * range
                    angularDensityMatrix(n,m,k) = vector(1,k); end
                %�������
                clear vector;
            end
        end
        %��ӡ��Ϣ
        fprintf('Density matrix was created !\r\n');
        %�����ܶȾ����ļ�
        save(fileName,'linearDensityMatrix','angularDensityMatrix');
    end
end