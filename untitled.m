function varargout = untitled(varargin)
%UNTITLED M-file for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to untitled_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      UNTITLED('CALLBACK') and UNTITLED('CALLBACK',hObject,...) call the
%      local function named CALLBACK in UNTITLED.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 14-Nov-2016 22:20:19

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Tnum_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Tnum_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tnum_edit as text
%        str2double(get(hObject,'String')) returns contents of Tnum_edit as a double


% --- Executes during object creation, after setting all properties.
function Tnum_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tnum_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in viewInfo_button.
function viewInfo_button_Callback(hObject, eventdata, handles)
% hObject    handle to viewInfo_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global executing_flag;
global focus_flag;
global focusTarget;
global aisData;
global selfAis;

if executing_flag == 0
    return;
end
Tnum = str2double(get(handles.Tnum_edit,'String'));
if isnan(Tnum) == 1
    errordlg('目标编号不能为空！');
    pause(2)
    return;
end
focusTarget=find(aisData(:,1)==Tnum);
if isempty(focusTarget)
    msgbox('没有找到该目标！');
    pause(2)
    return;
end
focus_flag = 1;
while focus_flag
    generateData();
    flushFlag=GetData();
    DisposeData();
    if flushFlag
        cla;
        R0 = GetXY_FromLonAndLat(selfAis.longitude,selfAis.latitude);
        draw_selfship(selfAis.heading,0,0,handles);
        R = GetXY_FromLonAndLat(aisData(focusTarget,2),aisData(focusTarget,3));
        draw_othership(aisData(focusTarget,1),(R(1)-R0(1))/10,(R(2)-R0(2))/10,handles);
    end
    
    set(handles.Longitude_edit,'String',aisData(focusTarget,2));
    set(handles.Latitude_edit,'String',aisData(focusTarget,3));
    %set(handles.distance_edit,'String',AIS.aisData(J(i)).TargetCourse);
    set(handles.speed_edit,'String',aisData(focusTarget,4));
    set(handles.direction_edit,'String',aisData(focusTarget,5));
    R = GetXY_FromLonAndLat(aisData(focusTarget,2),aisData(focusTarget,3));
    r = GetXY_FromLonAndLat(selfAis.longitude,selfAis.latitude);
    distance = sqrt((R(1)-r(1))^2+(R(2)-r(2))^2)/1000;
    set(handles.distance_edit,'String',distance);
    draw_track2(((R(1)-r(1))/10),((R(2)-r(2))/10),handles);
%     pause(0.01);
end
set(handles.Longitude_edit,'String',[]);
set(handles.Latitude_edit,'String',[]);
set(handles.distance_edit,'String',[]);
set(handles.speed_edit,'String',[]);
set(handles.direction_edit,'String',[]);



% --- Executes on button press in plotLine_button.
function plotLine_button_Callback(hObject, eventdata, handles)
% hObject    handle to plotLine_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global aisData;
global executing_flag;

if executing_flag == 1
    warndlg('请先结束实时监测','操作提示');
    pause(2)
    return;
end
Tnum = str2double(get(handles.Tnum_edit,'String'));
if isnan(Tnum) == 1
    errordlg('目标编号不能为空！');
    pause(2)
    return;
end
target=find(aisData(:,1)==Tnum);
if isempty(target)
    msgbox('没有找到该目标！');
    pause(2)
    return;
end
% h = waitbar(0,'绘制轨迹中...');
AISfid = fopen(['.\log\' num2str(Tnum) '.log']);
i=1;
AIS=textscan(AISfid,'%f',2,'delimiter',',');
AIS_Data=cell2mat(AIS)';
while 1
    if isempty(AIS_Data)
         break;
     end
     R = GetXY_FromLonAndLat(AIS_Data(1),AIS_Data(2));
     x(i) = R(1);
     y(i) = R(2);
     i=i+1;
     AIS=textscan(AISfid,'%f',2,'delimiter',',');
AIS_Data=cell2mat(AIS)';
%      waitbar(i/sum)
end
fclose(AISfid);
% close(h);
draw_track(x,y,handles);

function Longitude_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Longitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Longitude_edit as text
%        str2double(get(hObject,'String')) returns contents of Longitude_edit as a double


% --- Executes during object creation, after setting all properties.
function Longitude_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Longitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Latitude_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Latitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Latitude_edit as text
%        str2double(get(hObject,'String')) returns contents of Latitude_edit as a double


% --- Executes during object creation, after setting all properties.
function Latitude_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Latitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distance_edit_Callback(hObject, eventdata, handles)
% hObject    handle to distance_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distance_edit as text
%        str2double(get(hObject,'String')) returns contents of distance_edit as a double


% --- Executes during object creation, after setting all properties.
function distance_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distance_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function speed_edit_Callback(hObject, eventdata, handles)
% hObject    handle to speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed_edit as text
%        str2double(get(hObject,'String')) returns contents of speed_edit as a double


% --- Executes during object creation, after setting all properties.
function speed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function direction_edit_Callback(hObject, eventdata, handles)
% hObject    handle to direction_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of direction_edit as text
%        str2double(get(hObject,'String')) returns contents of direction_edit as a double


% --- Executes during object creation, after setting all properties.
function direction_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direction_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Functons_Callback(hObject, eventdata, handles)
% hObject    handle to Functons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button = questdlg('您确定要退出吗？','退出','退出','取消','取消');
if button == '退出'
        delete(handles.figure1);
end



% --------------------------------------------------------------------
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global exit_flag;
global executing_flag;
global selfAis;
global aisData;

executing_flag = 1;
exit_flag = 0;
axes(handles.axes1);
Initialize();
while exit_flag==0
    generateData();
    flushFlag=GetData();
    DisposeData();
    if flushFlag
        cla;
        R0 = GetXY_FromLonAndLat(selfAis.longitude,selfAis.latitude);
        draw_selfship(selfAis.heading,0,0,handles);
        for j = 1:size(aisData,1)
            R = GetXY_FromLonAndLat(aisData(j,2),aisData(j,3));
            draw_othership(aisData(j,1),(R(1)-R0(1))/10,(R(2)-R0(2))/10,handles);
        end
    end
%     pause(0.01);
end

% --------------------------------------------------------------------
function Finish_Callback(hObject, eventdata, handles)
global exit_flag;
global executing_flag;
global focus_flag;

exit_flag = 1;
executing_flag = 0;
focus_flag=0;
% hObject    handle to Finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cdata,map] = imread('wenhao2.jpg');

h = msgbox({'1. 功能——》开启监测   开启实时监测系统','2. 功能——》结束监测  关闭实时监测系统','2.在执行“显示船舶信息”之前，请先关闭实时监测系统！','3.动态显示指定目标编号的船舶信息时参考点（即坐标中心）是自身船舶的初始位置','4.绘制出的船舶航迹参考系为静止的大地！'},'操作帮助','custom',cdata,map);


% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
global focus_flag;
focus_flag = 0;
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function viewInfo_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viewInfo_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
i= imread('anniu1.jpg');
set(hObject,'cdata',i);


% --- Executes on key press with focus on viewInfo_button and none of its controls.
function viewInfo_button_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to viewInfo_button (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function plotLine_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotLine_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
i= imread('anniu1.jpg');
set(hObject,'cdata',i);


% --- Executes during object creation, after setting all properties.
function stop_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
i= imread('anniu2.jpg');
set(hObject,'cdata',i);


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
