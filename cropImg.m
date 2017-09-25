function f = cropImg(I)
img = imread(I);
f=imcrop(img,[3663,453,769,400]);
%imwrite(img2,'c:\1.bmp','bmp');

