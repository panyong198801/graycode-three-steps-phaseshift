function IMA = grating(m,n,varargin)
%   绘制光栅图
%   grating(m,n) 绘制光栅图（灰度图），m为灰度值矩阵的行数，n为列数
%   grating(m,n,'PARAM1',val1, 'PARAM2',val2, ...) 用成对出现的参数名/参数值
%       指定光栅图的显示属性，可用的参数名/参数值如下：
%       'Direction'  --  设定光栅条纹的方向，其参数值为：
%           'horizontal' -- 水平条纹
%           'Vertical'   -- 竖直条纹
%           'circle'     -- 同心圆条纹
%           'radiated'   -- 辐射状条纹
%
%       'Velocity'  --  设定角速度，其参数值为标量
%
%       'Angle'  --  设定初始相位角，其参数值为标量
%
%       'Color'  --  设定光栅条纹的颜色，其参数值为：
%           'Gray' -- 黑白条纹
%           'Rgb'  -- 彩色条纹
%
%   IMA = grating( ... ) 返回光栅图对应的灰度值矩阵
%
%   CopyRight:xiezhh（谢中华）
%   2011.11.26
%   Example：
%       grating(512,512,'direction','rad','Velocity',5000,'color','rgb');
%       grating(512,512,'Velocity',20,'maxgrayval',200)
%       grating(512,512,'direction','ver','Velocity',40)
%       grating(512,512,'Velocity',20,'maxgrayval',200,'direction','cir')

if nargin < 2
    error('输入参数过少');
end
[Direction,Vel,Ang,Col,MaxGrayVal] = parseInputs(varargin{:});

if strncmpi(Direction,'hor',3)
    x = (1:m)';
    Theta = x*pi/Vel;
    Theta = repmat(Theta,[1,n]);
elseif strncmpi(Direction,'ver',3)
    x = 1:n;
    Theta = x*pi/Vel;
    Theta = repmat(Theta,[m,1]);
elseif strncmpi(Direction,'cir',3)
    x = repmat((1:n),[m,1])-n/2;
    y = repmat((1:m)',[1,n])-m/2;
    D = sqrt(x.^2 + y.^2);
    Theta = D*pi/Vel;
elseif strncmpi(Direction,'rad',3)
    x = repmat((1:n),[m,1])-n/2;
    y = repmat((1:m)',[1,n])-m/2;
    Theta = atan2(y,x);
    Theta = Theta*Vel;
else
    error('方向参数只能为Horizontal，Vertical，Circle, Radiated 之一');
end

if strncmpi(Col,'gra',3)
    I = cos(Theta + Ang);
    I = mat2gray(I);
    IM = uint8(MaxGrayVal*I);
elseif strncmpi(Col,'rgb',3)
    I = zeros(m,n);
    IM = uint8(zeros(m,n,3));
    for i = 1:3
        I = cos(Theta + i*Ang);
        IM(:,:,i) = uint8(MaxGrayVal*mat2gray(I));
    end
else
    error('颜色参数只能为Gray, Rgb 之一');
end
if nargout == 0
    figure;
    imshow(IM);
else
    IMA = IM;
end

%--------------------------------------------------------------------------
%  解析输入参数
%--------------------------------------------------------------------------
function [Direction,Vel,Ang,Col,MaxGrayVal] = parseInputs(varargin)

if mod(nargin,2)~=0
    error('输入参数个数不对，应为成对出现');
end
pnames = {'direction','velocity','angle' 'color','maxgrayvalue'};
dflts =  {'horizontal',30,pi/3,'gray',255};
[Direction,Vel,Ang,Col,MaxGrayVal] = ...
    internal.stats.parseArgs(pnames, dflts, varargin{:});

validateattributes(Direction,{'char'},{'nonempty'},mfilename,'direction');
validateattributes(Vel,{'numeric'},{'scalar','nonempty'},mfilename,'velocity');
validateattributes(Ang,{'numeric'},{'scalar','nonempty'},mfilename,'angle');
validateattributes(Col,{'char'},{'nonempty'},mfilename,'color');
validateattributes(MaxGrayVal,{'numeric'},{'scalar','nonempty'},mfilename,'maxgrayvalue');