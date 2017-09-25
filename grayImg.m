function P = grayImg(nWidth, nHeight,n);
for j=1:nHeight
    for i=1:nWidth
        P(j,i)=255;
        if j<=nHeight/128 || j>127*nHeight/128 
             P(j,i)=0;
        end 
        
        for k=0:30
            if j>=(3+4*k)*nHeight/128 && j<= (5+4*k)*nHeight/128
                P(j, i) = 0;
            end;
        end;
        
    end;
end;


