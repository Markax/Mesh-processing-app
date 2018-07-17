function varargout = rebuildsGUI(varargin)
% REBUILDSGUI MATLAB code for rebuildsGUI.fig
%      REBUILDSGUI, by itself, creates a new REBUILDSGUI or raises the existing
%      singleton*.
%
%      H = REBUILDSGUI returns the handle to a new REBUILDSGUI or the handle to
%      the existing singleton*.
%
%      REBUILDSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REBUILDSGUI.M with the given input arguments.
%
%      REBUILDSGUI('Property','Value',...) creates a new REBUILDSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rebuildsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rebuildsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rebuildsGUI

% Last Modified by GUIDE v2.5 17-Jul-2018 19:04:27

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rebuildsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @rebuildsGUI_OutputFcn, ...
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


% --- Executes just before rebuildsGUI is made visible.
function rebuildsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rebuildsGUI (see VARARGIN)

% Choose default command line output for rebuildsGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global fpath;
global minL;
global maxL;
global actualL;
[filepath, name] = fileparts(fpath);
fvis = fopen('actualview.txt');
fpath = fgetl(fvis);
minL = fgetl(fvis);
maxL = fgetl(fvis);
fclose(fvis);
actualL = minL;

visualiza_mapa_local_shfd(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_',actualL,'_0_des_orig.surf'));

% UIWAIT makes rebuildsGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rebuildsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
