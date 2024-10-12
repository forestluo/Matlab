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
loadImageFile(strcat(imageName,'.jpg'),0);
%创建一个线性分析矩阵
linearDensityMatrix = ...
    zeros(row,column,range + 1);%包含中心点
%创建一个角度分析矩阵
angularDensityMatrix = ...
    zeros(row,column,4 * range);%包含中心点
%建立线性密度矩阵
buildDensityMatrix(strcat(imageName,'.mat'));

%线性矩阵
linearDensityContourMatrix = zeros(row,column);
%执行循环
for m = 1 : row
    for n = 1 : column
        %设置初始数值
        linearDensityContourMatrix(m,n) = 0;
        for k = 1 : range
            %检查线性密度
            if linearDensityMatrix(row - m + 1,n,k) < 0.8 break; end;
            %计算加和数值
            linearDensityContourMatrix(m,n) = ...
                linearDensityContourMatrix(m,n) + linearDensityMatrix(row - m + 1,n,k);
        end
    end
end

%显示图像
figure(1); 
%线性密度等高线矩阵
[y,x] = meshgrid(1:column,1:row);
%绘制等高线
contour(y,x,linearDensityContourMatrix);
%绘制图例说明
colorbar('south');
