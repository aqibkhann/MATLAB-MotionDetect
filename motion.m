% REQUIRES THE FOLLOWING ADD-ONS INSTALLED:
% IMAGE ACQUISITION TOOLBOX, SUPPORT PACKAGE FOR OS GENERIC VIDEO
% INTERFACE, MATLAB SUPPORT PACKAGE FOR USB WEBCAMS, IMAGE PROCESSING
% TOOLBOX
function varargout = motion(varargin)
% motion M-file for motion.fig
%      motion, by itself, creates a new motion or raises the existing
%      singleton*.
%
%      H = motion returns the handle to a new motion or the handle to
%      the existing singleton*.
%
%      motion('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in motion.M with the given input arguments.
%
%      motion('Property','Value',...) creates a new motion or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before motion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to motion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help motion

% Last Modified by GUIDE v2.5 03-Mar-2015 22:39:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @motion_OpeningFcn, ...
                   'gui_OutputFcn',  @motion_OutputFcn, ...
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


% --- Executes just before motion is made visible.
function motion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to motion (see VARARGIN)

% Choose default command line output for motion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes motion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = motion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in CaptureImage.
function CaptureImage_Callback(hObject, eventdata, handles)
obj=videoinput('winvideo');
A=getsnapshot(obj);
axes(handles.axes1);
imshow(A);
imwrite(A, 'A.jpg')
delete(obj)

% --- Executes on button press in Startmotion.
function Startmotion_Callback(hObject, eventdata, handles)
obj=videoinput('winvideo');
for r=1:30
    tmp = imread('A.jpg');
    i=rgb2gray(tmp);
    pause(0.2);
    B=getsnapshot(obj);
    axes(handles.axes2);
    imshow(B);
    j=rgb2gray(B);
    z=imabsdiff(i,j);
    z=im2bw(z);
    [a b c]=size(z);
    x=0;
    for m=1:a
        for n=1:b
            if z(m,n)==1
                x=x+1;
            end
        end
end  

if x > 1000
    set(handles.text1,'String','Motion Detected')
else
    set(handles.text1,'String','No change')
end

end

function Stopmotion_Callback(hObject, eventdata, handles)
close all;
