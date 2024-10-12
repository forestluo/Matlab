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
global pointVector;
global distanceMatrix;

%图像名称
imageName = '.\images\A';
%设置图像的尺寸
row = 256;
column = 256;
%装载图像文件
loadImageFile(strcat(imageName,'.jpg'),0);%保持原尺寸

%建立点阵矩阵
buildPointVector(strcat(imageName,'_pt.mat'));
%建立距离矩阵
distanceCount = buildDistanceMatrix(strcat(imageName,'_dis.mat'));
%绘制距离矩阵

%显示图像
figure(1);
subplot(2,2,1);
imshow(sample,'InitialMagnification','fit');
subplot(2,2,2);
%获得距离计数
distanceVector = zeros(1,distanceCount);
for n = 1 : distanceCount
    distanceVector(1,n) = distanceMatrix(n,1);
end
plot(distanceVector);
subplot(2,2,3); plot(1,1);
%获得距离计数
countVector = zeros(1,distanceCount);
for n = 1 : distanceCount
    countVector(1,n) = distanceMatrix(n,2);
end
plot(countVector);
subplot(2,2,4); plot(1,1);

