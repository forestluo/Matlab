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
global pointVector;
global distanceMatrix;

%ͼ������
imageName = '.\images\A';
%����ͼ��ĳߴ�
row = 256;
column = 256;
%װ��ͼ���ļ�
loadImageFile(strcat(imageName,'.jpg'),0);%����ԭ�ߴ�

%�����������
buildPointVector(strcat(imageName,'_pt.mat'));
%�����������
distanceCount = buildDistanceMatrix(strcat(imageName,'_dis.mat'));
%���ƾ������

%��ʾͼ��
figure(1);
subplot(2,2,1);
imshow(sample,'InitialMagnification','fit');
subplot(2,2,2);
%��þ������
distanceVector = zeros(1,distanceCount);
for n = 1 : distanceCount
    distanceVector(1,n) = distanceMatrix(n,1);
end
plot(distanceVector);
subplot(2,2,3); plot(1,1);
%��þ������
countVector = zeros(1,distanceCount);
for n = 1 : distanceCount
    countVector(1,n) = distanceMatrix(n,2);
end
plot(countVector);
subplot(2,2,4); plot(1,1);

