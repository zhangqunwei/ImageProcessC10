%%                                       �˲�3

% ���ߣ���Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% ���ڣ�2017��5��10��
%
% 1.������ݣ�
%         �Ը�����ͼ��LBimage3��ͼ������˲���ȥ������Ӱ�죬�ٽ��ж�ֵ����
%      ���õ������������ֺͷ��š�
% 2.���Ҫ��
%         �������ã��������֣ã��������Ա�̣��ã���������ʱ��
%      ����г��˶�д����ʾ����������ת���Ⱥ��������⣬������Ҫ���ܺ�������
%      ����д��
%         ���������������Ҫ��һ��������������ʵ�֣��ֲ���ʵ�����Ҫ��
%         ������Ʊ�������Ҫ����Ӱ�����Ķ������ء�
% 3.����

%% 3.1 ��ȡ����ʾԭͼ
X_src=imread('LBimage3.bmp');
imshow(X_src);title('\fontsize{20}\color{red}ԭͼ');

%% 3.2 ��ȡ���ղ���
% ��Сֵ�˲�
X=double(X_src);     % ����ʱ��תΪdouble��
X_min1=myfilter2('Minimum',X,5);        
imshow(X_min1);title('\fontsize{20}\color{red}��ȡ���ղ���(��Сֵ�˲�)');

%% 3.3 ��������
% Prewitt
X_prewitt=myfilter2('Prewitt',X_min1);
imshow(X_prewitt);title('\fontsize{20}\color{red}��������(Prewitt����)');


%% 3.4 ��������ȥ�����ղ��֣�
% �޹���ͼ=ԭͼ-����ͼ
X_sub=X_src-uint8(X_prewitt);
imshow(uint8(X_sub));title('\fontsize{20}\color{red}������');

%% 3.5 �Ҷ�����
% ��ȥ�����պ��ͼ��������ԻҶ�����
NX_sub=13*X_sub;
% ��ͼ���е����֡�0�����оֲ���ֵ�˲�
NX_sub(:,1:80)=myfilter2('Medium',NX_sub(:,1:80),5);
NX_sub(:,80:180)=myfilter2('Medium',NX_sub(:,80:180),5);
imshow(uint8(NX_sub));title('\fontsize{20}\color{red}�Ҷ�����');

%% 3.6 ��ֵ��
% ��ͼ����зֶζ�ֵ��
% ��ͼ���е����֡�0�������ν��в�ͬ��ֵ�Ķ�ֵ��
left1=myim2bw(NX_sub(:,1:80),0.99);
left2=myim2bw(NX_sub(:,80:180),0.3);
% �ϳ����֡�0��
BW_left=[left1 left2];
% �����֡�0���ұ߽��ж�ֵ��
BW_right=myim2bw(NX_sub(:,180:size(X,2)),0.3);
% �ϳ�����ͼ��
BW=[BW_left BW_right];
imshow(BW);title('\fontsize{20}\color{red}��ֵ��');
% ��ʾԭͼ���Ƚϴ���Ч��
imshow(X_src);title('\fontsize{20}\color{red}ԭͼ');
