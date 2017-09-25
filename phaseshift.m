function [f, M] = phaseshift(I1, I2, I3, I4,I5,I6,I7,I8)
P1_1 = imread(I1);
P2_1 = imread(I2);
P3_1 = imread(I3);

P1 = rgb2gray(P1_1);
P2 = rgb2gray(P2_1);
P3 = rgb2gray(P3_1);

P4 = imread(I4);
P5 = imread(I5);
P6 = imread(I6);
P7 = imread(I7);
P8 = imread(I8);


P4_Gray = rgb2gray(P4);
P5_Gray = rgb2gray(P5);
P6_Gray = rgb2gray(P6);
P7_Gray = rgb2gray(P7);
P8_Gray = rgb2gray(P8);

P4_BW=im2bw(P4_Gray,0.39);    %图像二值化
P5_BW=im2bw(P5_Gray,0.39);    %图像二值化
P6_BW=im2bw(P6_Gray,0.39);    %图像二值化
P7_BW=im2bw(P7_Gray,0.39);    %图像二值化
P8_BW=im2bw(P8_Gray,0.39);    %图像二值化

%imshow(P7_BW);
[height, width] = size(P1);
%f=0;
for i=1:width
    for j=1:height
        f(j, i) = 0;
    end;
end;

for i=1:width
    K2_Last =pi;
    K_Last =80000;
    for j=1:height
        d1 = double(P1(j, i));
        d2 = double(P2(j,i));
        d3 = double(P3(j,i));
        D = sqrt(3)*(d1 - d3);
        E = 2*d2-d1-d3;
        K2 = atan2(D,E);
        while K2<0
            K2 = K2+2*pi;
        end;
        
        F = [0 0 0 0 0 ];
    
        K=0;
        pp = P4_BW(j,i);
       if (double(P4_BW(j,i))==1)
            F(1) = 1;
        end;
        
        if (double(P5_BW(j,i))==1)
             F(2) = 1;
        end;
        
        if (double(P6_BW(j,i))==1)
            F(3) = 1;
        end;
        
        if (double(P7_BW(j,i))==1)
            F(4) = 1;
        end;
        
        if (double(P8_BW(j,i))==1)
            F(5) = 1;
        end;
              
        binary = GrayToBinary(F);
        N = length(binary);
        for m=1:N
            k1(m)= power(2, N-m)*binary(m); 
        end;
        
      K = sum(k1(1:N));
      KM(j,i) = K;
      gray_phase = mod(K,12) / 12;	% [0,1)

      %防止跳变 20170919
%       if (K2+2*K*pi - K2_Last > pi/2.0         )
%           K = K+1;
%       elseif  K2+2*K*pi - K2_Last < pi/2.0
%           K = K-1;
%       end;

       K_Last = K;
       K2_Last = K2+2*K*pi;
       
       f(j,i)=K2 + 2*K*pi;
      %f(j,i)=K2;
      M(j,i) = K2;
    end;
end;
