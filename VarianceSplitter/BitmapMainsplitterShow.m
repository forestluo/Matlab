function varargout = BitmapMainsplitterShow(varargin)
% BITMAPMAINSPLITTERSHOW MATLAB code for BitmapMainsplitterShow.fig
%      BITMAPMAINSPLITTERSHOW, by itself, creates a new BITMAPMAINSPLITTERSHOW or raises the existing
%      singleton*.
%
%      H = BITMAPMAINSPLITTERSHOW returns the handle to a new BITMAPMAINSPLITTERSHOW or the handle to
%      the existing singleton*.
%
%      BITMAPMAINSPLITTERSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BITMAPMAINSPLITTERSHOW.M with the given input arguments.
%
%      BITMAPMAINSPLITTERSHOW('Property','Value',...) creates a new BITMAPMAINSPLITTERSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BitmapMainsplitterShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BitmapMainsplitterShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BitmapMainsplitterShow

% Last Modified by GUIDE v2.5 01-Nov-2019 19:11:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BitmapMainsplitterShow_OpeningFcn, ...
                   'gui_OutputFcn',  @BitmapMainsplitterShow_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BitmapMainsplitterShow is made visible.
function BitmapMainsplitterShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BitmapMainsplitterShow (see VARARGIN)

% Choose default command line output for BitmapMainsplitterShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BitmapMainsplitterShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BitmapMainsplitterShow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function UpdateAxes(axes,table,depth)

%读取图像
sampleImage = imread('./img/zhong.jpg');
%转换成灰度
sampleImage = im2bw(sampleImage);
%找到索引点
[yValues,xValues] = find(sampleImage(:,:) == 0);
%[yValues,xValues] = find(sampleImage(:,:) == 1);
%颠倒下图像
yValues = 512 - yValues;

%旋转
% t = pi / 6;
% xTmpValues = xValues * cos(t) - yValues * sin(t);
% yTmpValues = xValues * sin(t) + yValues * cos(t);
% xValues = xTmpValues;
% yValues = yTmpValues;

%绘制随机点
plot(axes,xValues,yValues,'.');
hold on;
%获得分割结果
[pointMarks,treeNodes] = MinVarianceMainsplitter(xValues',yValues',depth);
%更新数据
table.Data = treeNodes;
%绘制枝叶
DrawSubdivisionTree(axes,treeNodes,depth);
%绘制分割点集凸包
DrawConvexHull(axes,xValues,yValues,pointMarks,depth);
hold off;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,1);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,2);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,3);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,4);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,5);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,6);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.uitable1,7);
