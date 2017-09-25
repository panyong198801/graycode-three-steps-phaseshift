%% 利用异或转换实现二进制到格雷码的转换
%   此方法对应从n位的二进制码字直接到n位格雷码码字
%   二进制码:   b(n-1)  ... b(1)    b(0)    ;格雷码：  g(n-1)  ... g(1)    g(0);
%   g(i) = b(i)+b(i+1)(模二加)

function [graycode] = BinaryToGray(binary)
% binary 是二进制原码，行向量
% code  =  fliplr(binary);
code = [0 binary];
graycode =mod(code(1,1:length(binary))+binary,2);
end
