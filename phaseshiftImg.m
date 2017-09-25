function [P1, P2, P3] = phaseshiftImg();
for i=1:1024
    for j=1:768
        P1(j, i) = 0.5+0.5*cos(2*pi*j/24.0 - 2*pi/3.0);
        P2(j, i) = 0.5+0.5*cos(2*pi*j/24.0);
        P3(j, i) = 0.5+0.5*cos(2*pi*j/24.0 + 2*pi/3.0);
    end;
end;
imwrite(P1,'c:/1.bmp','bmp');
imwrite(P2,'c:/2.bmp','bmp');
imwrite(P3,'c:/3.bmp','bmp');