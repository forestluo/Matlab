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
loadImageFile(strcat(imageName,'.jpg'),0);
%����һ�����Է�������
linearDensityMatrix = ...
    zeros(row,column,range + 1);%�������ĵ�
%����һ���Ƕȷ�������
angularDensityMatrix = ...
    zeros(row,column,4 * range);%�������ĵ�
%���������ܶȾ���
buildDensityMatrix(strcat(imageName,'.mat'));

%���Ծ���
linearDensityContourMatrix = zeros(row,column);
%ִ��ѭ��
for m = 1 : row
    for n = 1 : column
        %���ó�ʼ��ֵ
        linearDensityContourMatrix(m,n) = 0;
        for k = 1 : range
            %��������ܶ�
            if linearDensityMatrix(row - m + 1,n,k) < 0.8 break; end;
            %����Ӻ���ֵ
            linearDensityContourMatrix(m,n) = ...
                linearDensityContourMatrix(m,n) + linearDensityMatrix(row - m + 1,n,k);
        end
    end
end

%��ʾͼ��
figure(1); 
%�����ܶȵȸ��߾���
[y,x] = meshgrid(1:column,1:row);
%���Ƶȸ���
contour(y,x,linearDensityContourMatrix);
%����ͼ��˵��
colorbar('south');
