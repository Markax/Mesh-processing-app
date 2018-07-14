function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 12-Jul-2018 20:09:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path] = uigetfile('../Models/*.*');
[filepath,name,ext] = fileparts(file);
            if isequal(file,0)
               disp('User selected Cancel');
            else
               global fpath;
               fpath = fullfile(path,file);
               disp(['User selected ', fullfile(path,file)]);
            end
            if (isequal(ext, '.obj'))
                obj = readObj(fullfile(path,file));
                set(handles.uipushtool2,'enable','on');
                set(handles.uitoggletool1,'enable','on');
                set(handles.uitoggletool3,'enable','on');
                set(handles.uitoggletool4,'enable','on');
                set(handles.MFileButton,'visible','on');
                set(handles.minL,'visible','on');
                set(handles.maxL,'visible','on');
                set(handles.maxText,'visible','on');
                set(handles.minText,'visible','on');
                trisurf(obj.f , obj.v(:,1), obj.v(:,2), obj.v(:,3),'FaceColor',[0.26,0.33,1.0 ]);
                shading interp
                colormap gray(256);
                lighting phong;
                %light('Position',[-1 0 0],'Style','local');
                camproj('perspective');
                axis square; 
                axis off;
                axis equal;
                axis tight;  
                camlight('headlight')
                cameratoolbar;
                rotate3d on;
            else
                [vertex_coords, faces] = read_freesurfer_surf(fullfile(path,file));
                set(handles.uipushtool2,'enable','on');
                set(handles.uitoggletool1,'enable','on');
                set(handles.uitoggletool3,'enable','on');
                set(handles.uitoggletool4,'enable','on');
                set(handles.MFileButton,'visible','on');
                set(handles.minL,'visible','on');
                set(handles.maxL,'visible','on');
                set(handles.maxText,'visible','on');
                set(handles.minText,'visible','on');
                trisurf(faces, vertex_coords(:,1), vertex_coords(:,2), vertex_coords(:,3),'FaceColor',[0.26,0.33,1.0 ]);
                shading interp
                colormap gray(256);
                lighting phong;
                %light('Position',[-1 0 0],'Style','local');
                camproj('perspective');
                axis square; 
                axis off;
                axis equal;
                axis tight;
                camlight('headlight');
                cameratoolbar;
                rotate3d on;
            end
           


% --------------------------------------------------------------------
function uitoggletool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotate3d on;


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(findall(gcf,'Type','light'));
camlight('headlight');


% --- Executes on button press in MFileButton.
function MFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to MFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

min = str2double(get(handles.minL, 'String'));
max = str2double(get(handles.maxL, 'String'));
fid = fopen('config.txt');
sigma = str2double(fgetl(fid));
numiter = str2double(fgetl(fid));
min_L_regression_Local = str2double(fgetl(fid));
max_L_regression_Local = str2double(fgetl(fid));
min_L_regression_Global = str2double(fgetl(fid));
max_L_regression_Global = str2double(fgetl(fid));

if (min > 0 && max > min && min_L_regression_Local < max_L_regression_Local && min <= min_L_regression_Local && max >= max_L_regression_Local && min_L_regression_Global < max_L_regression_Global && min <= min_L_regression_Global && max >= max_L_regression_Global)
    addpath(genpath('spharm'));
    addpath(genpath('hk_smoothing'));
    global fpath;
    [filepath,name] = fileparts(fpath);
    
    
    % convert to m file
    generate_m(fpath);
    
    % m file to Combine and Resize
    BATCH_MLCombineAndResize(strcat(filepath,'\',name,'_temp','\',name,'.m'), 0, 0, 0);
    
    % OL2_O2 file to MakeTemplate
    BATCH_MLMakeTemplate(strcat(filepath,'\',name,'_temp','\',name,'_OL_2O.mat'), 1, 1)
    
    % Rebuilding
    BATCH_genera_reconstrucciones(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_smo.mat'), min, max);
    
    % Generate Areas
    generate_areas_per_vertex_file(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_1_0_des_orig.surf'));
    
    %HK_Smooth
    hk_smooth_3dshfd(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_1_0_des_orig.surf_AREAS_SIN_SUAVIZAR.txt'), sigma, numiter);
    
    %Compute local SHFD
    compute_local_shfd(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_1_0_des_orig.surf_LOCAL_RESULTS_VERTICES_HKS_', int2str(sigma),'_', int2str(numiter),'.txt'), int32(min_L_regression_Local), int32(max_L_regression_Local));
    
    %Compute global SHFD
    compute_global_shfd(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_1_0_des_orig.surf'), int32(min_L_regression_Global), int32(max_L_regression_Global));
    
    %Visualice local map SHFD
    visualiza_mapa_local_shfd(strcat(filepath,'\',name,'_temp','\',name,'.m'), strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_1_0_des_orig.surf_LOCAL_RESULTS_VERTICES_HKS_',int2str(sigma),'_',int2str(numiter),'.local_shfd_',int2str(min_L_regression_Local),'_',int2str(max_L_regression_Local),'.txt'));
    
    fset = fopen(strcat(filepath,'\',name,'_temp','\template_',name,'_OL_2O_1_0_des_orig.surf_GLOBAL_SHFD_',int2str(min_L_regression_Global),'_',int2str(max_L_regression_Global),'.txt'));
    
     A = fgetl(fset);
    
    while ischar(A)
        A = fgets(fset);
        if (A~=-1)
            B = fscanf(fset, '%f');
        end
    end
    globalshfd = B(1:1);
    correlation = B(end:end);

    fclose(fset);
    
    set(handles.GlobalSHFD, 'String', globalshfd);
    set(handles.Correlation, 'String', correlation);
    set(handles.GlobalSHFD, 'Visible', 'on');
    set(handles.Correlation, 'Visible', 'on');
    set(handles.text6, 'Visible', 'on');
    set(handles.text7, 'Visible', 'on');
    
    disp('Done');
else 
    if (min < 1)
        errordlg('Error: Min L value must be 1 or greater', 'Min Value Error');
    end
    if (max < min)
        errordlg('Error: Max L value must be greater than Min L value', 'Max Value Error');
    end
    if (isnan(min))
        errordlg('Error: Min L value must be a interger number', 'Min Value Error');
    end
    if (isnan(max))
        errordlg('Error: Max L value must be a interger number', 'Max Value Error');
    end
    if (min_L_regression > max_L_regression)
        errordlg('Error: Max L Regression must be greater than Min L Regression', 'Regression Value Error');
    end
    if (min > min_L_regression_Local || min > min_L_regression_Global)
        errordlg('Error: Min L Regression value must be greater than Min L value', 'Regression Value Error');
    end
    if(max < max_L_regression_Local || max < max_L_regression_Global)
        errordlg('Error: Max L value must be greater than Max L Regression value', 'Regression Value Error');
    end
end




function maxL_Callback(hObject, eventdata, handles)
% hObject    handle to maxL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxL as text
%        str2double(get(hObject,'String')) returns contents of maxL as a double


% --- Executes during object creation, after setting all properties.
function maxL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minL_Callback(hObject, eventdata, handles)
% hObject    handle to minL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minL as text
%        str2double(get(hObject,'String')) returns contents of minL as a double


% --- Executes during object creation, after setting all properties.
function minL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function configmenu_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to configmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Config


% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exitdialog
