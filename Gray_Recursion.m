%% 递归实现格雷码编码
%{
1位格雷码有两个码字
(n+1)位格雷码中的前2n个码字等于n位格雷码的码字，按顺序书写，加前缀0
(n+1)位格雷码中的后2n个码字等于n位格雷码的码字，按逆序书写，加前缀1[3] 
n+1位格雷码的集合 = n位格雷码集合(顺序)加前缀0 + n位格雷码集合(逆序)加前缀1
%}
%   N 为比特数
function [graycode]=Gray_Recursion(N,type)
graycode = zeros(2^N,N);
if N==1
    if type ==0
        graycode(1,:) = 0;
        graycode(2,:) = 1;
    elseif type ==1
        graycode(1,:) = 1;
        graycode(2,:) = 0;
    else
        disp('input error!');
        return;
    end
else
    graycode(1:2^(N-1),2:end)=Gray_Recursion(N-1,type);
    graycode(end:-1:2^(N-1)+1,2:end)=Gray_Recursion(N-1,type);
    graycode(2^(N-1)+1:end,1)=ones(2^(N-1),1);
end
end

