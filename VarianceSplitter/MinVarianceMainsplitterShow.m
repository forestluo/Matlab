function varargout = MinVarianceMainsplitterShow(varargin)
% MINVARIANCEMAINSPLITTERSHOW MATLAB code for MinVarianceMainsplitterShow.fig
%      MINVARIANCEMAINSPLITTERSHOW, by itself, creates a new MINVARIANCEMAINSPLITTERSHOW or raises the existing
%      singleton*.
%
%      H = MINVARIANCEMAINSPLITTERSHOW returns the handle to a new MINVARIANCEMAINSPLITTERSHOW or the handle to
%      the existing singleton*.
%
%      MINVARIANCEMAINSPLITTERSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MINVARIANCEMAINSPLITTERSHOW.M with the given input arguments.
%
%      MINVARIANCEMAINSPLITTERSHOW('Property','Value',...) creates a new MINVARIANCEMAINSPLITTERSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MinVarianceMainsplitterShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MinVarianceMainsplitterShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MinVarianceMainsplitterShow

% Last Modified by GUIDE v2.5 01-Nov-2019 18:30:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MinVarianceMainsplitterShow_OpeningFcn, ...
                   'gui_OutputFcn',  @MinVarianceMainsplitterShow_OutputFcn, ...
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


% --- Executes just before MinVarianceMainsplitterShow is made visible.
function MinVarianceMainsplitterShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MinVarianceMainsplitterShow (see VARARGIN)

% Choose default command line output for MinVarianceMainsplitterShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MinVarianceMainsplitterShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MinVarianceMainsplitterShow_OutputFcn(hObject, eventdata, handles) 
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

%获得当前数值
n = str2num(handles.edit1.String);
%检查数值结果
if n <= 0
    fprintf('无效的采样点数量（%d）！\n',n);
    return;
end

%生成随机点群
points1 = mvnrnd([-1 -4],[1.5 0;0 1],n);
points2 = mvnrnd([4 1],[1 0.5;0.5 2],n);
points3 = mvnrnd([0 0],[1.5 0.5;0.5 1],n);
%绘制随机点群
plot(handles.axes1, ...
    points1(:,1),points1(:,2),'.', ...
    points2(:,1),points2(:,2),'.',points3(:,1),points3(:,2),'.');
hold on;
%将两个随机点群拼接成一个样本群
xValues = cat(1,points1(:,1),points2(:,1),points3(:,1));
yValues = cat(1,points1(:,2),points2(:,2),points3(:,2));
%获得分割结果
depth = str2num(handles.edit5.String);
[pointMarks,treeNodes] = MinVarianceMainsplitter(xValues',yValues',depth);
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
