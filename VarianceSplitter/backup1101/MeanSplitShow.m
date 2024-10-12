function varargout = MeanSplitShow(varargin)
% MEANSPLITSHOW MATLAB code for MeanSplitShow.fig
%      MEANSPLITSHOW, by itself, creates a new MEANSPLITSHOW or raises the existing
%      singleton*.
%
%      H = MEANSPLITSHOW returns the handle to a new MEANSPLITSHOW or the handle to
%      the existing singleton*.
%
%      MEANSPLITSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEANSPLITSHOW.M with the given input arguments.
%
%      MEANSPLITSHOW('Property','Value',...) creates a new MEANSPLITSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MeanSplitShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MeanSplitShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MeanSplitShow

% Last Modified by GUIDE v2.5 31-Oct-2019 09:41:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MeanSplitShow_OpeningFcn, ...
                   'gui_OutputFcn',  @MeanSplitShow_OutputFcn, ...
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


% --- Executes just before MeanSplitShow is made visible.
function MeanSplitShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MeanSplitShow (see VARARGIN)

% Choose default command line output for MeanSplitShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MeanSplitShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MeanSplitShow_OutputFcn(hObject, eventdata, handles) 
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
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
    points1(:,1),points1(:,2),'ro', ...
    points2(:,1),points2(:,2),'b*',points3(:,1),points3(:,2),'g+');
hold on;
%将两个随机点群拼接成一个样本群
xValues = cat(1,points1(:,1),points2(:,1),points3(:,1));
yValues = cat(1,points1(:,2),points2(:,2),points3(:,2));
%获得分割结果
[xMean,yMean,beta,theta] = MeanSplit(xValues',yValues');
%绘制中心点
plot(handles.axes1,xMean,yMean,'o');
hold on;
%绘制分割线
k = tan(beta);
xLim = get(handles.axes1,'XLim');
y1 = (xLim(1) - xMean) * k + yMean;
y2 = (xLim(2) - xMean) * k + yMean;
plot(handles.axes1,xLim,[y1 y2],'--');
hold on;
%更新数值
handles.edit4.String = sprintf('%f',k);
handles.edit3.String = sprintf('%f',theta);
hold off;

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
