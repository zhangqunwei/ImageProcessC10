%% ͼ���ֵ��
% * ����      ��ʵ��ͼ��Ķ�ֵ��
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[4/5/2017]  
%%

 
%% ����ʹ�þ���
% # I=myim2bw(X);               % Ĭ����ֵΪ0.5����X���ж�ֵ��
% # I=myim2bw(X,0.7);           % ��ֵΪ 0.7����X���ж�ֵ��
%%
% *ע�⣺��ֵȡֵ��ΧΪ[0 1]*
%%


%% ������
% *ʵ��ͼ��Ķ�ֵ��*
function BW=myim2bw(varargin)
    % �ɲ���������ζ�ֵ��
    switch nargin
        % Ĭ�������ֵ����Сֵ��ƽ��ֵ���ж�ֵ��        
        case 1
            I=varargin{1};
            BW=I;
            MAX=max(max(I));
            MIN=min(min(I));
            MID=(MAX-MIN)/2+MIN;
            BW(I>MID)=255;
            BW(I<MID)=0;
        % ������ֵ���ж�ֵ��
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
    