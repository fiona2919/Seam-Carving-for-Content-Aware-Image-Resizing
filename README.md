# Seam Carving for Content-Aware Image Resizing

## Overview
> The project is related to resizing pictures by removing pixels in a judicious manner.

## Implementation
* ���Y�Ϥ��j�p����k���ܦh�ءA�H�n���Y�@�b�e�׬��ҡA�i�H�O�d�n��������l���������A�]�i�H�C���h���@��C���o�Ǥ�k���|�ɭP�Ϥ����u�A�ݰ_�ӻP�쥻�����@�ˡC�]���ڭ̭n��ܥh���Ϥ��������e���`�N�쪺�����A�]�N�O��F�� pixel �ݰ_�ӳ��t���h�ɡA�N�i�H�Ҽ{�h�����@�ǦӤ��v�T�쥻���ˤl�C
1. energyRGB.m
    * �n��P�_�@ pixel �O�_�i�H�����Ӥ��v�T����Ϥ��ݰ_�Ӫ��ˤl�A�ڭ̻ݭn���p��Ϥ����U pixel �� energy �j�p�ÿ�ܲ��� energy �p���C�b�o��p�⪺�覡�O�Q�Τ@ [-1 0 1] �x�}�P����m�x�}���O��Ϥ��� 2D-convolution �o��� pixel �����B�����ۮt�ȫᰵ����Ȭۥ[�A�A�N R�BG�BB ���Ȭۥ[�C�]���i�H�o��ӱi�Ϥ��W�C�� pixel �� energy�C

2. findOptSeam.m
    * �p�G�u�O�N�@�Ϥ��W energy �̤p�� pixel �����Ӥ��Ҽ{��F�����Y�A�N�|�ɭP�Ϥ����u�A�]���ڭ̳W�w�n�������@��/�C�W pixel �����i�ۮt�ӻ��A�u��O�P�Ʃιj�����C�]����X�F�񪺳̤p energy �A�P�ۤv�����ۥ[�A�p���B�z��̫�@��/�C�A�Y�i�o��C��/�C�����������pixel�C
	```Matlab
	% M ���p�� energy �ۥ[�ίx�}
	for i = 2:row % �N�F��̤p�� energy �P�ۤv�ۥ[
		for j = 2:column-1
			M(i,j) = energy(i,j-1) + min([M(i-1,j-1),M(i-1,j),M(i-1,j+1)]);
		end
			end
	% ��X�̫� energy �̤p�� pixel �é��^�l����Ĥ@��/�C
	[val, idx] = min(M(row, :));
	for i=row-1:-1:1
		[~,idx2] = min([M(i,idx-1),M(i,idx),M(i,idx+1)]);
		idx = idx+idx2-2;
		optSeamMask(i,idx-1) = 1;
	% optSeamMask ���O���i������ pixel �ίx�}�A�W���аO����k�O�N�n�������Хܬ�1�A��l��0�C
	```
3. reduceImageByMask.m
    * �N�e���o�쪺�x�}�P�Ϥ�������A���L�Q�аO�n������ pixel�A�O�d�ѤU���C�H�����@���欰�ҡG
        ```Matlab
        for i=1:height
            for j=1:width-1 % seamMask ���e���ұo�쪺�����ίx�}
                if seamMask(i,j)==false 
                    break;
                else % imageReduced ���s�ϡFimage �¹�
                    imageReduced(i,j,:) = image(i,j,:);
                end
            end
            imageReduced(i,j:end,:) = image(i,j+1:end,:);
        end
        ```
    
    * �Y�n���Y���d����j�A�h���ƤW���M��̤p energy �åh���Ӧ�/�C���ʧ@����ѤU�Q�n���Ϥ��j�p�Y�i�C

## Installation
* Other required packages�Gpictures you want to process.
* How to compile from source?
    * read in your picture by changing this line in seamCarvingTester.m�G
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
<img src="results/sea.jpg" width="100%"/>
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
