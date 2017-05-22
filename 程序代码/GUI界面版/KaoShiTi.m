%% �����⣺C10 �˲�3
% * ����      ���Ը�����ͼ��LBimage3��ͼ������˲���ȥ������Ӱ�죬
% �ٽ��ж�ֵ�������õ������������ֺͷ��š�
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[4/5/2017]  
%%

%% 
% <<../main.bmp>>

%%
% *1.������*
function varargout = KaoShiTi(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KaoShiTi_OpeningFcn, ...
                   'gui_OutputFcn',  @KaoShiTi_OutputFcn, ...
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

%%
% *2.��ʼ����*
function KaoShiTi_OpeningFcn(hObject, eventdata, handles, varargin)
% ȫ�ֱ���
    handles.img_old=0;                  % Դͼ��
    handles.img=0;                      % ͼ������
    [hight,width]=size(handles.img);    % ����ͼ��ߴ�
    handles.img_width=width;            % ͼ���
    handles.img_hight=hight;            % ͼ���
% ����
    set(handles.Load_img,'enable','on');
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','off');
    set(handles.N_img,'enable','off');     
    set(handles.BW_img,'enable','off');       
% Choose default command line output for KaoShiTi
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes KaoShiTi wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%
% *3.�������*
function KaoShiTi_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;

%%    
% *4.����*
function chongZhi_Callback(hObject, eventdata, handles)
% ����ͼ��
    handles.img=handles.img_old;
    handles.img_AM=handles.img_old;
% ����ʹ��
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','off');
    set(handles.BW_img,'enable','off');    
    set(handles.N_img,'enable','off');
% ��ʾ
    axes(handles.axes2);
    imshow(handles.img);
guidata(hObject,handles);


%%
% *5.����ͼ��*
function Load_img_Callback(hObject, eventdata, handles)
% ����ͼ��
    str='LBimage3.bmp';
    handles.img_old=imread(str);        % Դͼ��
    handles.img=imread(str);            % ͼ������
% ��ʾͼ��
    axes(handles.axes1);
    imshow(handles.img);
    title('\fontsize{20}\color{red}ԭͼ');
% ����ʹ��
    set(handles.Minimum_img,'enable','on');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','off');
    set(handles.BW_img,'enable','off');    
    set(handles.N_img,'enable','off');    
% ��������
    guidata(hObject,handles);


%%
% *6.��ȡ���ղ���*    
function Minimum_img_Callback(hObject, eventdata, handles)
% ��Сֵ�˲�
    handles.img=myfilter2('Minimum',handles.img,5);
% ��ʾ���
    axes(handles.axes2);
    imshow(handles.img);
    title('\fontsize{20}\color{red}��ȡ���ղ���(��Сֵ�˲�)');
% ����ʹ��
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','on');
% ��������
    guidata(hObject,handles);    
    

%%
% *7.��������*
function Prewitt_img_Callback(hObject, eventdata, handles)
% ��������(Prewitt����)
    handles.img=myfilter2('Prewitt',handles.img);
    axes(handles.axes2);
    imshow(handles.img);
    title('\fontsize{20}\color{red}��������(Prewitt����)');
% ����ʹ��
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','on');   
% ��������
    guidata(hObject,handles);
    
    
%%
% *8.������*    
function Sub_img_Callback(hObject, eventdata, handles)
% ��ȥ���շ���
    handles.img=handles.img_old-handles.img;  
% ��ʾ���
    axes(handles.axes2);
    imshow(handles.img);
    title('\fontsize{20}\color{red}������');
% ����ʹ��
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','off');   
    set(handles.N_img,'enable','on');    
% ��������
    guidata(hObject,handles);

    
%%
% *9.�Ҷ�����*    
function N_img_Callback(hObject, eventdata, handles)
% �Ҷ����� 
% ��ȥ�����պ��ͼ��������ԻҶ�����
    handles.img=13*handles.img;
% ��ͼ���е����֡�0�����оֲ���ֵ�˲�
    handles.img(:,1:80)=myfilter2('Medium',handles.img(:,1:80),5);
    handles.img(:,80:180)=myfilter2('Medium',handles.img(:,80:180),5);
% ��ʾ���
    axes(handles.axes2);    
    imshow(uint8(handles.img));
    title('\fontsize{20}\color{red}�Ҷ�����');
% ����ʹ��
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','off');
    set(handles.N_img,'enable','off'); 
    set(handles.BW_img,'enable','on');       
% ��������
    guidata(hObject,handles);
    
    
%%
% *10.��ֵ������*
function BW_img_Callback(hObject, eventdata, handles)
% ��ͼ����зֶζ�ֵ��
% ��ͼ���е����֡�0�������ν��в�ͬ��ֵ�Ķ�ֵ��
    left1=myim2bw(handles.img(:,1:80),0.99);
    left2=myim2bw(handles.img(:,80:180),0.3);
% �ϳ����֡�0��
    BW_left=[left1 left2];
% �����֡�0���ұ߽��ж�ֵ��
    BW_right=myim2bw(handles.img(:,180:size(handles.img,2)),0.3);
% �ϳ�����ͼ��
    BW=[BW_left BW_right];
% ��ʾ���
    axes(handles.axes2);
    imshow(BW);
    title('\fontsize{20}\color{red}��ֵ��');
% ����ʹ��
    set(handles.Minimum_img,'enable','off');
    set(handles.Prewitt_img,'enable','off');
    set(handles.Sub_img,'enable','off');
    set(handles.N_img,'enable','off');     
    set(handles.BW_img,'enable','off');    
% ��������
    handles.img=BW;
    guidata(hObject,handles); 

    
