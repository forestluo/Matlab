function KeyPressFcn(src,event)
    %定义全局变量
    global sample;
    
    %获得当前字符
    key = get(gcf,'CurrentCharacter');
    %检查结果
    if key == 27
        figure(1); subplot(2,2,1); hold off;
        imshow(sample,'InitialMagnification','fit');
        figure(1); subplot(2,2,4); hold off; plot(1,1);
    end
    %激活原窗口坐标系
    figure(1); subplot(2,2,1);
end
