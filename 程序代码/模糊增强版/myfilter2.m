%% ��ά���������˲���
% * ����      ����ά���������˲���
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[10/5/2017]  
%%


%% �﷨:
%---------------------------------------
%   Y=MYFILTER2(type,X,N)
%   ��typeָ����FIR�˲���(N*N��ģ��)������X�����˲����˲�����ΪY.
%---------------------------------------
%   N       ָ��FIR�˲���ʹ��N*N��ģ����м���
%   type 
%       'Average'   ��ֵ�˲���
%       'Minimum'   ��Сֵ�˲���
%       'Medium'    ��ֵ�˲���
%       'Maximum'   ���ֵ�˲���
%       'Laplace'   ������˹������
%       'Sobel'     sobel����
%       'Prewitt'   prewitt����

%% ����:
%---------------------------------------
%     clear
%     clc
%     %% ���벢��ʾԭͼ
%     figure('name','ԭͼ','NumberTitle','off');
%     I=imread('cameraman.tif');
%     imshow(I);
%     %% ��Ӹ�˹����
%     J=imnoise(I,'gaussian',0,0.02);
%     %% MY��ֵ�˲�
%     figure('name','MY��ֵ�˲�','NumberTitle','off');
%     J1=myfilter2('average',J,3);
%     imshow(J1);
%


%% ������
% *��ά���������˲���*
function Y=myfilter2(type,X,N,varargin)
%��ά���������˲���. 
    X=double(X);
    switch type
        case 'Average'
            Y=Average(N,X);
        case 'Minimum'
            Y=Minimum(N,X);
        case 'Medium'
            Y=Medium(N,X);
        case 'Maximum'
            Y=Maximum(N,X);
        case 'Laplace'
            Y=Laplace(N,X);
        case 'Sobel'
            % ��������
            plateX=[-1 -2 -1;0 0 0;1 2 1];
            plateY=[-1 0  1;-2 0 2;-1 0 1];
            Y=Sobel_Prewitt(plateX,plateY,X);
        case 'Prewitt'
            % ��������
            plateX=[1 0 -1;1 0 -1;1 0 -1];
            plateY=[1 1  1;0 0 0;-1 -1 -1];
            Y=Sobel_Prewitt(plateX,plateY,X);
        otherwise
            Y=X;
    end % /!switch 
end 


%% Average
% ����ƽ���˲���������ƽ���˲�������ģ��ΪNxN
function I=Average(N,X)
    [height,width]=size(X);     % ����ͼ���С
    dX=double(X);               % ���������ͼ��double���ͣ�
    for i=1:height-N+1
        for j=1:width-N+1
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=sum(sum( X(i:i+(N-1),j:j+(N-1)) ))/(N*N);
        end
    end
    I=uint8(dX);
end 


%% Minimum
% ��Сֵ�˲�����ģ��ΪNxN
function I=Minimum(N,X)
    [height,width]=size(X);     % ����ͼ���С
    dX=double(X);               % ���������ͼ��double���ͣ�
    for i=1:height-N+1
        for j=1:width-N+1
            temp=X(i:i+(N-1),j:j+(N-1));    % ȡ��ͼ������ģ���Ӧ������
            s=temp(:);                      % ������ת��Ϊһ��ʸ��
            Min=min(s);                     % ����ʸ������Сֵ
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=Min;% ����Сֵд������λ��
        end
    end
    I=uint8(dX);
end              
 

%% Medium
% ��ֵ�˲�����ģ��ΪNxN
function I=Medium(N,X)
    [height,width]=size(X);     % ����ͼ���С
    dX=double(X);               % ���������ͼ��double���ͣ�
    for i=1:height-N+1
        for j=1:width-N+1
            temp=X(i:i+(N-1),j:j+(N-1));    % ȡ��ͼ������ģ���Ӧ������
            s=temp(:);                      % ������ת��Ϊһ��ʸ��
            Med=median(s);                  % ����ʸ������ֵ
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=Med;% ����ֵд������λ��
        end
    end
    I=uint8(dX);
end             


%% Maximum
% ���ֵ�˲�����ģ��ΪNxN
function I=Maximum(N,X)
    [height,width]=size(X);     % ����ͼ���С
    dX=double(X);               % ���������ͼ��double���ͣ�
    for i=1:height-N+1
        for j=1:width-N+1
            temp=X(i:i+(N-1),j:j+(N-1));            % ȡ��ͼ������ģ���Ӧ������
            s=temp(:);                              % ������ת��Ϊһ��ʸ��
            Max=max(s);                             % ����ʸ�������ֵ
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=Max;        % �����ֵд������λ��
        end
    end
    I=uint8(dX);
end 
            
         
%% Laplace
% ������˹����
function I=Laplace(plate,X)
    [height,width]=size(X);     % ����ͼ���С
    N=size(plate,1);            % ����ģ���С
    dX=double(X);               % ���������ͼ��double���ͣ�
    for i=1:height-2
        for j=1:width-2
            % ģ��������
            temp=plate.*X(i:i+(N-1),j:j+(N-1)); % ģ����ͼ�����ݵ��
            temp=sum(sum(temp));                % ���
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=temp;   % д��ͼ��
        end
    end
    I=uint8(dX);
end            
      

%% Sobel_Prewitt
% Sobel_Prewitt����
function I=Sobel_Prewitt(plateX,plateY,X)
    [height,width]=size(X);     % ����ͼ���С
% ����dX,dY
    dX=double(X);               % ���������ͼ��double���ͣ�
    dY=double(X);               % ���������ͼ��double���ͣ�    
    for i=1:height-2
        for j=1:width-2
            % X����ʹ��ģ��
            tempX=plateX.*X(i:i+2,j:j+2);           % ģ����ͼ�����ݵ��
            tempX=sum(sum(tempX));                  % ���
            dX(i:i+1,j:j+1)=tempX.^2;               % ƽ����д��ͼ��
            % Y����ʹ��ģ��
            tempY=plateY.*X(i:i+2,j:j+2);           % ģ����ͼ�����ݵ��
            tempY=sum(sum(tempY));                  % ���
            dY(i:i+1,j:j+1)=tempY.^2;               % ƽ����д��ͼ��
        end
    end
% ����S
    S=sqrt(dX+dY);
% ����ԭͼ
    I=uint8(X+S);
end            
   
            