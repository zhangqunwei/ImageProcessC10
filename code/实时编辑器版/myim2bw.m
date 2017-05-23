%% 图像二值化
% * 概述      ：实现图像的二值化
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[4/5/2017]  
%%

 
%% 函数使用举例
% # I=myim2bw(X);               % 默认阈值为0.5，对X进行二值化
% # I=myim2bw(X,0.7);           % 阈值为 0.7，对X进行二值化
%%
% *注意：阈值取值范围为[0 1]*
%%


%% 主函数
% *实现图像的二值化*
function BW=myim2bw(varargin)
    % 由参数决定如何二值化
    switch nargin
        % 默认以最大值和最小值的平均值进行二值化        
        case 1
            I=varargin{1};
            BW=I;
            MAX=max(max(I));
            MIN=min(min(I));
            MID=(MAX-MIN)/2+MIN;
            BW(I>MID)=255;
            BW(I<MID)=0;
        % 根据阈值进行二值化
        case 2
            I=varargin{1};
            BW=I;
            MAX=max(max(I));
            MIN=min(min(I));
            lev=double(varargin{2});
            LEVEL=(MAX-MIN)*lev+MIN;                       
            BW(I>LEVEL)=255;
            BW(I<LEVEL)=0;
    end
end
    