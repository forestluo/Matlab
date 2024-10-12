%清理空间
clear;
close all;
%关闭显示
echo off;

%定义全局变量
global sample;
global row;
global column;
%分析变量
global range;
global linearDensityMatrix;
global angularDensityMatrix;

%设置分析范围
range = 32;
%图像名称
imageName = '.\images\multiobject1';
%设置图像的尺寸
row = 256;
column = 256;
%装载图像文件
loadImageFile(strcat(imageName,'.jpg'),0);%保持原尺寸
%创建一个线性分析矩阵
linearDensityMatrix = ...
    zeros(row,column,range + 1);%包含中心点
%创建一个角度分析矩阵
angularDensityMatrix = ...
    zeros(row,column,4 * range);%包含中心点
%建立线性密度矩阵
buildDensityMatrix(strcat(imageName,'.mat'));

%显示图像
figure(1);
subplot(2,2,1);
imshow(sample,'InitialMagnification','fit');
subplot(2,2,2); plot(1,1);
subplot(2,2,3); stem(1);
subplot(2,2,4); plot(1,1);
%激活数据窗口
subplot(2,2,1);
%设置键盘输入相应
set(gcf,'KeyPressFcn',@KeyPressFcn);
%设置鼠标按下响应
set(gcf,'WindowButtonDownFcn',@ButtonDownFcn);
%设置鼠标移动响应
set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn);
