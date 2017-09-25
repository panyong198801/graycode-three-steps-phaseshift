%% 利用异或转换实现格雷码到二进制的转换
%   此方法对应从n位的二进制码字直接到n位格雷码码字
%   二进制码:   b(n-1)  ... b(1)    b(0)    ;格雷码：  g(n-1)  ... g(1)    g(0);
%   b(i) = g(i)+b(i+1)(模二加)
function [binary] = GrayToBinary(gray)
% gray是格雷码
N = length(gray);
binary = gray;
for i = 2:N
    binary(i) = mod(binary(i-1)+gray(i),2);
end
end
