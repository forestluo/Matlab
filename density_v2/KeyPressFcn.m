function KeyPressFcn(src,event)
    %����ȫ�ֱ���
    global sample;
    
    %��õ�ǰ�ַ�
    key = get(gcf,'CurrentCharacter');
    %�����
    if key == 27
        figure(1); subplot(2,2,1); hold off;
        imshow(sample,'InitialMagnification','fit');
        figure(1); subplot(2,2,4); hold off; plot(1,1);
    end
    %����ԭ��������ϵ
    figure(1); subplot(2,2,1);
end
