%����ռ�
clear;
close all;
%�ر���ʾ
echo off;

%����ȫ�ֱ���
global sample;
global row;
global column;
%��������
global range;
global linearDensityMatrix;
global angularDensityMatrix;

%���÷�����Χ
range = 32;
%ͼ������
imageName = '.\images\multiobject1';
%����ͼ��ĳߴ�
row = 256;
column = 256;
%װ��ͼ���ļ�
loadImageFile(strcat(imageName,'.jpg'),0);%����ԭ�ߴ�
%����һ�����Է�������
linearDensityMatrix = ...
    zeros(row,column,range + 1);%�������ĵ�
%����һ���Ƕȷ�������
angularDensityMatrix = ...
    zeros(row,column,4 * range);%�������ĵ�
%���������ܶȾ���
buildDensityMatrix(strcat(imageName,'.mat'));

%��ʾͼ��
figure(1);
subplot(2,2,1);
imshow(sample,'InitialMagnification','fit');
subplot(2,2,2); plot(1,1);
subplot(2,2,3); stem(1);
subplot(2,2,4); plot(1,1);
%�������ݴ���
subplot(2,2,1);
%���ü���������Ӧ
set(gcf,'KeyPressFcn',@KeyPressFcn);
%������갴����Ӧ
set(gcf,'WindowButtonDownFcn',@ButtonDownFcn);
%��������ƶ���Ӧ
set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn);
