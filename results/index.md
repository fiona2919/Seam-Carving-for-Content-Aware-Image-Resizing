# 林佳葳 <span style="color:#FF0070">(102061229)</span>

# Project 3 / Seam Carving for Content-Aware Image Resizing

## Overview
> The project is related to resizing pictures by removing pixels in a judicious manner.

## Implementation
* 壓縮圖片大小的方法有很多種，以要壓縮一半寬度為例，可以保留要的部分其餘直接切掉，也可以每兩行去掉一行。但這些方法都會導致圖片失真，看起來與原本的不一樣。因此我們要選擇去除圖片中較不容易注意到的部分，也就是當鄰近的 pixel 看起來都差不多時，就可以考慮去除掉一些而不影響原本的樣子。
1. energyRGB.m
    * 要能判斷一 pixel 是否可以移除而不影響整體圖片看起來的樣子，我們需要先計算圖片中各 pixel 的 energy 大小並選擇移除 energy 小的。在這邊計算的方式是利用一 [-1 0 1] 矩陣與其轉置矩陣分別對圖片做 2D-convolution 得到該 pixel 水平、垂直相差值後做絕對值相加，再將 R、G、B 的值相加。因此可以得到該張圖片上每個 pixel 的 energy。

2. findOptSeam.m
    * 如果只是將一圖片上 energy 最小的 pixel 移除而不考慮其鄰近關係，將會導致圖片失真，因此我們規定要移除的一行/列上 pixel 間不可相差太遠，只能是同排或隔壁的。因此找出鄰近的最小 energy 再與自己本身相加，如此處理到最後一行/列，即可得到每行/列中能夠移除的pixel。
	```Matlab
	% M 為計算 energy 相加用矩陣
	for i = 2:row % 將鄰近最小的 energy 與自己相加
		for j = 2:column-1
			M(i,j) = energy(i,j-1) + min([M(i-1,j-1),M(i-1,j),M(i-1,j+1)]);
		end
			end
	% 找出最後 energy 最小的 pixel 並往回追溯到第一行/列
	[val, idx] = min(M(row, :));
	for i=row-1:-1:1
		[~,idx2] = min([M(i,idx-1),M(i,idx),M(i,idx+1)]);
		idx = idx+idx2-2;
		optSeamMask(i,idx-1) = 1;
	% optSeamMask 為記錄可移除之 pixel 用矩陣，上面標記的方法是將要移除的標示為1，其餘為0。
	```
3. reduceImageByMask.m
    * 將前面得到的矩陣與圖片做比較，跳過被標記要移除的 pixel，保留剩下的。以移除一直行為例：
        ```Matlab
        for i=1:height
            for j=1:width-1 % seamMask 為前面所得到的紀錄用矩陣
                if seamMask(i,j)==false 
                    break;
                else % imageReduced 為新圖；image 舊圖
                    imageReduced(i,j,:) = image(i,j,:);
                end
            end
            imageReduced(i,j:end,:) = image(i,j+1:end,:);
        end
        ```
    
    * 若要壓縮的範圍較大，則重複上面尋找最小 energy 並去除該行/列的動作直到剩下想要的圖片大小即可。

## Installation
* Other required packages：pictures you want to process.
* How to compile from source?
    * read in your picture by changing this line in seamCarvingTester.m：
	```Matlab
	image = imread('../data/sea.jpg');
	```
    * set a new size for your picture in this line:
	```Matlab
	image_seamCarving = seamCarving(double(image), [NewRow, NewColumn]);
	```
    * run seamCarvingTester.m

### Results

<table border=1>
<tr>
<td>
<span style = "font-size:20px">Original image</span>
<img src="sea.jpg" width="100%"/>
</td>
</tr>
</table>
<table border=1>
<tr>
<td>
<span style = "font-size:20px">(method 1) cropping</span>
<img src="SeamCroppingsea.jpg" width="100%"/>
</td>
<td>
<span style = "font-size:20px">(method 2) scaling</span>
<img src="SeamScalingsea.jpg" width="100%"/>
</td>
<td>
<span style = "font-size:20px">(method 3) seam carving-horizontal</span>
<img src="SeamCarvingsea.jpg" width="100%"/>
</td>
</tr>
</table>
<table border=1>
<tr>
<td>
<span style = "font-size:20px">(method 3) seam carving-vertical</span>
<img src="SeamCarving2.jpg" width="100%"/>
</td>
</tr>
</table>

<table border=1>
<tr>
<td>
<span style = "font-size:20px">My own image</span>
<img src="disney.jpg" width="100%"/>
</td>
</tr>
</table>
<table border=1>
<tr>
<td>
<span style = "font-size:20px">(method 1) cropping</span>
<img src="SeamCropping.jpg" width="100%"/>
</td>
<td>
<span style = "font-size:20px">(method 2) scaling</span>
<img src="SeamScaling.jpg" width="100%"/>
</td>
<td>
<span style = "font-size:20px">(method 3) seam carving-horizontal</span>
<img src="SeamCarving.jpg" width="100%"/>
</td>
</tr>
</table>
<<<<<<< HEAD
=======

>>>>>>> origin/master
