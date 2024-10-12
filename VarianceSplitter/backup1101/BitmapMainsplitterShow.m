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

% Last Modified by GUIDE v2.5 31-Oct-2019 21:04:14

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

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%读取图像
sampleImage = imread('wenzi.jpg');
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
plot(handles.axes1,xValues,yValues,'.');
hold on;

%获得分割结果
depth = str2num(handles.edit5.String);
[pointMarks,treeNodes] = MeanMainsplitter(xValues',yValues',depth);
%更新数据
handles.uitable1.Data = treeNodes;

%绘制枝叶
DrawSubdivisionTree(handles.axes1,treeNodes,depth);
%绘制分割点集凸包
DrawConvexHull(handles.axes1,xValues,yValues,pointMarks,depth);
hold off;

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
