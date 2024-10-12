function varargout = HSVMainsplitterShow(varargin)
% HSVMAINSPLITTERSHOW MATLAB code for HSVMainsplitterShow.fig
%      HSVMAINSPLITTERSHOW, by itself, creates a new HSVMAINSPLITTERSHOW or raises the existing
%      singleton*.
%
%      H = HSVMAINSPLITTERSHOW returns the handle to a new HSVMAINSPLITTERSHOW or the handle to
%      the existing singleton*.
%
%      HSVMAINSPLITTERSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HSVMAINSPLITTERSHOW.M with the given input arguments.
%
%      HSVMAINSPLITTERSHOW('Property','Value',...) creates a new HSVMAINSPLITTERSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HSVMainsplitterShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HSVMainsplitterShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HSVMainsplitterShow

% Last Modified by GUIDE v2.5 02-Nov-2019 14:40:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HSVMainsplitterShow_OpeningFcn, ...
                   'gui_OutputFcn',  @HSVMainsplitterShow_OutputFcn, ...
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


% --- Executes just before HSVMainsplitterShow is made visible.
function HSVMainsplitterShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HSVMainsplitterShow (see VARARGIN)

% Choose default command line output for HSVMainsplitterShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HSVMainsplitterShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HSVMainsplitterShow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function UpdateAxes(axes1,axes2,depth)
%读取图像
rgbImage = imread('nature.jpg');
imshow(rgbImage,'Parent',axes1);
% 转换成HSV图像
hsvImage = rgb2hsv(rgbImage);
hueImage = hsvImage(:,:,1);
satureImage = hsvImage(:,:,2);
xValues = hueImage(:);
yValues = satureImage(:);
%绘制随机点
plot(axes2,xValues',yValues','.');
hold on;
%获得分割结果
[pointMarks,treeNodes] = MinVarianceMainsplitter(xValues',yValues',depth);
%绘制枝叶
DrawSubdivisionTree(axes2,treeNodes,depth);
%绘制分割点集凸包
DrawConvexHull(axes2,xValues,yValues,pointMarks,depth);
hold off;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,1);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,2);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,3);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,4);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,5);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,6);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateAxes(handles.axes1,handles.axes2,7);
