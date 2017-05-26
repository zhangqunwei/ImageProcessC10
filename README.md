<style>
   h1{color:#ff0000;text-align: center;}
   h2{text-align: center;}
</style>
<div>
<a href="https://zhangqunwei.github.io/ImageProcessC10/install/InstallerWeb.zip" title="PC机中需要预先安装Matlab" class="btn btn-github"><span class="icon"></span>网络安装包</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <a href="https://zhangqunwei.github.io/ImageProcessC10/main/main.zip" title="PC机中需要预先安装Matlab" class="btn btn-github"><span class="icon"></span>本地主程序</a>
</div >


# 考试题：C10 滤波3
   对给定的图像LBimage3进行滤波，去除光照影响， 再进行二值化处理，得到较完整的数字和符号。

## GUI界面版 
 [查看源码](https://zhangqunwei.github.io/ImageProcessC10/html/GUI/KaoShiTi.html)
  
  ![UI界面](https://zhangqunwei.github.io/ImageProcessC10/html/GUI/main.bmp)

## 模糊增强版 
 [查看源码](https://zhangqunwei.github.io/ImageProcessC10/html/Fuzzy/main.html)
 
 <p style="">
{% highlight Matlab %}  
 %%                       滤波3
 
 % 作者：张群伟	南昌航空大学信息工程学院自动化系
 % 日期：2017年5月10日
 %
 % 1.设计内容：
 %         对给定的图像LBimage3对图像进行滤波，去除光照影响，再进行二值化处理，得到较完整的数字和符号。
 % 2.设计要求：
 %         １）可用ｍａｔｌａｂ或ＶＣ＋＋等语言编程，用ｍａｔｌａｂ编程时，设计中除了读写、显示、
 % 数据类型转换等函数外以外，其它主要功能函数需自己编写。
 %         ２）所有设计内容要在一个主程序中运行实现，分步骤实现设计要求。
 %         ３）设计报告中需要分析影响结果的多种因素。
 
 %% 主程序：
 
 %% 1.读取并显示原图
   X_src=imread('LBimage3.bmp');
   imshow(X_src);title('\fontsize{20}\color{red}原图');
 %% 2.模糊增强
 % 对图像进行全局模糊增强
   X_fuzzy=myfuzzy(X_src);
 % 对数字‘0’进行局部模糊增强
   X_fuzzy(:,1:170)=myfuzzy(X_fuzzy(:,1:170));
   imshow(X_fuzzy);title('\fontsize{20}\color{red}模糊增强');
 
 %% 3.提取光照部分
 % 最小值滤波
   X=double(X_fuzzy);     % 计算时需转为double型
   X_min1=myfilter2('Minimum',X,5);        
   imshow(X_min1);title('\fontsize{20}\color{red}提取光照部分(最小值滤波)');
 
 %% 4.抑制噪声
 % 对图像全局使用Prewitt算子去噪
   X_prewitt=myfilter2('Prewitt',X_min1);
 % 对数字‘0’进行局部去噪
   X_prewitt(:,1:170)=myfilter2('Prewitt',X_min1(:,1:170));
   imshow(X_prewitt);title('\fontsize{20}\color{red}抑制噪声(Prewitt算子)');
 
 
 %% 5.结果相减
 % 无光照图=模糊增强图-光照图
   X_sub=X_fuzzy-uint8(X_prewitt);
   imshow(uint8(X_sub));title('\fontsize{20}\color{red}结果相减（去除光照部分）');
 %% 6.再次增强
 % 对数字‘0’进行模糊增强
   X_sub(:,1:170)=myfuzzy(X_sub(:,1:170));
 % 对数字‘0’进行去噪
   X_sub(:,1:170)=myfilter2('Medium',X_sub(:,1:170),3);
   imshow(uint8(X_sub));title('\fontsize{20}\color{red}再次增强');
 
 %% 7.灰度拉伸
 % 对去除光照后的图像进行线性灰度拉伸
   NX_sub=11*X_sub;
   imshow(uint8(NX_sub));title('\fontsize{20}\color{red}灰度拉伸');
 
 %% 二值化
 % 对图像进行分段二值化
 % 对图像分两段进行不同阈值的二值化
 % 对数字‘0’进行二值化
   BW_left=myim2bw(NX_sub(:,1:170),0.99);
 % 对数字‘0’右边进行二值化
   BW_right=myim2bw(NX_sub(:,170:size(X,2)),0.6);
 % 合成整幅图像
   BW=[BW_left BW_right];
   imshow(BW);title('\fontsize{20}\color{red}二值化');
 % 显示原图，比较处理效果
   imshow(X_src);title('\fontsize{20}\color{red}原图');
{% endhighlight %}  
 </p>
 
## 实时编辑器版 
 [查看源码](https://zhangqunwei.github.io/ImageProcessC10/html/RealTime/main.html)
<p style="">
{% highlight Matlab %}  
 %%                        滤波3
 
 % 作者：张群伟	南昌航空大学信息工程学院自动化系
 % 日期：2017年5月10日
 %
 % 1.设计内容：
 %         对给定的图像LBimage3对图像进行滤波，去除光照影响，再进行二值化处
 %      理，得到较完整的数字和符号。
 % 2.设计要求：
 %         １）可用ｍａｔｌａｂ或ＶＣ＋＋等语言编程，用ｍａｔｌａｂ编程时，
 %      设计中除了读写、显示、数据类型转换等函数外以外，其它主要功能函数需自
 %      己编写。
 %         ２）所有设计内容要在一个主程序中运行实现，分步骤实现设计要求。
 %         ３）设计报告中需要分析影响结果的多种因素。
 % 3.程序：
 
 %% 3.1 读取并显示原图
   X_src=imread('LBimage3.bmp');
   imshow(X_src);title('\fontsize{20}\color{red}原图');
 
 %% 3.2 提取光照部分
 % 最小值滤波
   X=double(X_src);     % 计算时需转为double型
   X_min1=myfilter2('Minimum',X,5);        
   imshow(X_min1);title('\fontsize{20}\color{red}提取光照部分(最小值滤波)');
 
 %% 3.3 抑制噪声
 % Prewitt
   X_prewitt=myfilter2('Prewitt',X_min1);
   imshow(X_prewitt);title('\fontsize{20}\color{red}抑制噪声(Prewitt算子)');
 
 
 %% 3.4 结果相减（去除光照部分）
 % 无光照图=原图-光照图
   X_sub=X_src-uint8(X_prewitt);
   imshow(uint8(X_sub));title('\fontsize{20}\color{red}结果相减');
 
 %% 3.5 灰度拉伸
 % 对去除光照后的图像进行线性灰度拉伸
   NX_sub=13*X_sub;
 % 对图像中的数字‘0’进行局部中值滤波
   NX_sub(:,1:80)=myfilter2('Medium',NX_sub(:,1:80),5);
   NX_sub(:,80:180)=myfilter2('Medium',NX_sub(:,80:180),5);
   imshow(uint8(NX_sub));title('\fontsize{20}\color{red}灰度拉伸');
 
 %% 3.6 二值化
 % 对图像进行分段二值化
 % 对图像中的数字‘0’分两段进行不同阈值的二值化
   left1=myim2bw(NX_sub(:,1:80),0.99);
   left2=myim2bw(NX_sub(:,80:180),0.3);
 % 合成数字‘0’
   BW_left=[left1 left2];
 % 对数字‘0’右边进行二值化
   BW_right=myim2bw(NX_sub(:,180:size(X,2)),0.3);
 % 合成整幅图像
   BW=[BW_left BW_right];
   imshow(BW);title('\fontsize{20}\color{red}二值化');
 % 显示原图，比较处理效果
   imshow(X_src);title('\fontsize{20}\color{red}原图');
{% endhighlight %}  
</p>
