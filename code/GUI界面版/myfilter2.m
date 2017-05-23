%% 二维线性数字滤波器
% * 概述      ：二维线性数字滤波器
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[10/5/2017]  
%%


%% 语法:
%---------------------------------------
%   Y=MYFILTER2(type,X,N)
%   用type指定的FIR滤波器(N*N的模板)对数据X进行滤波，滤波后结果为Y.
%---------------------------------------
%   N       指定FIR滤波器使用N*N的模板进行计算
%   type 
%       'Average'   均值滤波器
%       'Minimum'   最小值滤波器
%       'Medium'    中值滤波器
%       'Maximum'   最大值滤波器
%       'Laplace'   拉普拉斯算子锐化
%       'Sobel'     sobel算子
%       'Prewitt'   prewitt算子

%% 举例:
%---------------------------------------
%     clear
%     clc
%     %% 读入并显示原图
%     figure('name','原图','NumberTitle','off');
%     I=imread('cameraman.tif');
%     imshow(I);
%     %% 添加高斯噪声
%     J=imnoise(I,'gaussian',0,0.02);
%     %% MY均值滤波
%     figure('name','MY均值滤波','NumberTitle','off');
%     J1=myfilter2('average',J,3);
%     imshow(J1);
%


%% 主函数
% *二维线性数字滤波器*
function Y=myfilter2(type,X,N,varargin)
%二维线性数字滤波器. 
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
            % 设置算子
            plateX=[-1 -2 -1;0 0 0;1 2 1];
            plateY=[-1 0  1;-2 0 2;-1 0 1];
            Y=Sobel_Prewitt(plateX,plateY,X);
        case 'Prewitt'
            % 设置算子
            plateX=[1 0 -1;1 0 -1;1 0 -1];
            plateY=[1 1  1;0 0 0;-1 -1 -1];
            Y=Sobel_Prewitt(plateX,plateY,X);
        otherwise
            Y=X;
    end % /!switch 
end 


%% Average
% 领域平均滤波器（线性平滑滤波器），模版为NxN
function I=Average(N,X)
    [height,width]=size(X);     % 检索图像大小
    dX=double(X);               % 保存计算后的图像（double类型）
    for i=1:height-N+1
        for j=1:width-N+1
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=sum(sum( X(i:i+(N-1),j:j+(N-1)) ))/(N*N);
        end
    end
    I=uint8(dX);
end 


%% Minimum
% 最小值滤波器，模版为NxN
function I=Minimum(N,X)
    [height,width]=size(X);     % 检索图像大小
    dX=double(X);               % 保存计算后的图像（double类型）
    for i=1:height-N+1
        for j=1:width-N+1
            temp=X(i:i+(N-1),j:j+(N-1));    % 取出图像中与模版对应的数据
            s=temp(:);                      % 将矩阵转变为一个矢量
            Min=min(s);                     % 计算矢量的最小值
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=Min;% 将最小值写入中心位置
        end
    end
    I=uint8(dX);
end              
 

%% Medium
% 中值滤波器，模版为NxN
function I=Medium(N,X)
    [height,width]=size(X);     % 检索图像大小
    dX=double(X);               % 保存计算后的图像（double类型）
    for i=1:height-N+1
        for j=1:width-N+1
            temp=X(i:i+(N-1),j:j+(N-1));    % 取出图像中与模版对应的数据
            s=temp(:);                      % 将矩阵转变为一个矢量
            Med=median(s);                  % 计算矢量的中值
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=Med;% 将中值写入中心位置
        end
    end
    I=uint8(dX);
end             


%% Maximum
% 最大值滤波器，模版为NxN
function I=Maximum(N,X)
    [height,width]=size(X);     % 检索图像大小
    dX=double(X);               % 保存计算后的图像（double类型）
    for i=1:height-N+1
        for j=1:width-N+1
            temp=X(i:i+(N-1),j:j+(N-1));            % 取出图像中与模版对应的数据
            s=temp(:);                              % 将矩阵转变为一个矢量
            Max=max(s);                             % 计算矢量的最大值
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=Max;        % 将最大值写入中心位置
        end
    end
    I=uint8(dX);
end 
            
         
%% Laplace
% 拉普拉斯算子
function I=Laplace(plate,X)
    [height,width]=size(X);     % 检索图像大小
    N=size(plate,1);            % 检索模板大小
    dX=double(X);               % 保存计算后的图像（double类型）
    for i=1:height-2
        for j=1:width-2
            % 模板卷积运算
            temp=plate.*X(i:i+(N-1),j:j+(N-1)); % 模板与图像数据点乘
            temp=sum(sum(temp));                % 求和
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=temp;   % 写入图像
        end
    end
    I=uint8(dX);
end            
      

%% Sobel_Prewitt
% Sobel_Prewitt算子
function I=Sobel_Prewitt(plateX,plateY,X)
    [height,width]=size(X);     % 检索图像大小
% 计算dX,dY
    dX=double(X);               % 保存计算后的图像（double类型）
    dY=double(X);               % 保存计算后的图像（double类型）    
    for i=1:height-2
        for j=1:width-2
            % X方向使用模板
            tempX=plateX.*X(i:i+2,j:j+2);           % 模板与图像数据点乘
            tempX=sum(sum(tempX));                  % 求和
            dX(i:i+1,j:j+1)=tempX.^2;               % 平方并写入图像
            % Y方向使用模板
            tempY=plateY.*X(i:i+2,j:j+2);           % 模板与图像数据点乘
            tempY=sum(sum(tempY));                  % 求和
            dY(i:i+1,j:j+1)=tempY.^2;               % 平方并写入图像
        end
    end
% 计算S
    S=sqrt(dX+dY);
% 加上原图
    I=uint8(X+S);
end            
   
            