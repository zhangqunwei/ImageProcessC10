%%                                             �˲�3

% ���ߣ���Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% ���ڣ�2017��5��10��
%
% 1.������ݣ�
%         �Ը�����ͼ��LBimage3��ͼ������˲���ȥ������Ӱ�죬�ٽ��ж�ֵ�������õ������������ֺͷ��š�
% 2.���Ҫ��
%         �������ã��������֣ã��������Ա�̣��ã���������ʱ������г��˶�д����ʾ��
% ��������ת���Ⱥ��������⣬������Ҫ���ܺ������Լ���д��
%         ���������������Ҫ��һ��������������ʵ�֣��ֲ���ʵ�����Ҫ��
%         ������Ʊ�������Ҫ����Ӱ�����Ķ������ء�

%% ������

%% 1.��ȡ����ʾԭͼ
X_src=imread('LBimage3.bmp');
imshow(X_src);title('\fontsize{20}\color{red}ԭͼ');
%% 2.ģ����ǿ
% ��ͼ�����ȫ��ģ����ǿ
X_fuzzy=myfuzzy(X_src);
% �����֡�0�����оֲ�ģ����ǿ
X_fuzzy(:,1:170)=myfuzzy(X_fuzzy(:,1:170));
imshow(X_fuzzy);title('\fontsize{20}\color{red}ģ����ǿ');

%% 3.��ȡ���ղ���
% ��Сֵ�˲�
X=double(X_fuzzy);     % ����ʱ��תΪdouble��
X_min1=myfilter2('Minimum',X,5);        
imshow(X_min1);title('\fontsize{20}\color{red}��ȡ���ղ���(��Сֵ�˲�)');

%% 4.��������
% ��ͼ��ȫ��ʹ��Prewitt����ȥ��
X_prewitt=myfilter2('Prewitt',X_min1);
% �����֡�0�����оֲ�ȥ��
X_prewitt(:,1:170)=myfilter2('Prewitt',X_min1(:,1:170));
imshow(X_prewitt);title('\fontsize{20}\color{red}��������(Prewitt����)');


%% 5.������
% �޹���ͼ=ģ����ǿͼ-����ͼ
X_sub=X_fuzzy-uint8(X_prewitt);
imshow(uint8(X_sub));title('\fontsize{20}\color{red}��������ȥ�����ղ��֣�');
%% 6.�ٴ���ǿ
% �����֡�0������ģ����ǿ
X_sub(:,1:170)=myfuzzy(X_sub(:,1:170));
% �����֡�0������ȥ��
X_sub(:,1:170)=myfilter2('Medium',X_sub(:,1:170),3);
imshow(uint8(X_sub));title('\fontsize{20}\color{red}�ٴ���ǿ');

%% 7.�Ҷ�����
% ��ȥ�����պ��ͼ��������ԻҶ�����
NX_sub=11*X_sub;
imshow(uint8(NX_sub));title('\fontsize{20}\color{red}�Ҷ�����');

%% ��ֵ��
% ��ͼ����зֶζ�ֵ��
% ��ͼ������ν��в�ͬ��ֵ�Ķ�ֵ��
% �����֡�0�����ж�ֵ��
BW_left=myim2bw(NX_sub(:,1:170),0.99);
% �����֡�0���ұ߽��ж�ֵ��
BW_right=myim2bw(NX_sub(:,170:size(X,2)),0.6);
% �ϳ�����ͼ��
BW=[BW_left BW_right];
imshow(BW);title('\fontsize{20}\color{red}��ֵ��');
% ��ʾԭͼ���Ƚϴ���Ч��
imshow(X_src);title('\fontsize{20}\color{red}ԭͼ');

