function [ o ] = period_average( x,span )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
len = length(x);
if(rem(len,span)==0)
    p_len = length(x)/span;
else    
    p_len = ceil(length(x)/span);
end


o=zeros(p_len,1);
for jk=1:p_len-1
    o(jk)=mean(x(1+(jk-1)*span:jk*span));
end

if(rem(len,span)==0)
    o(p_len) = mean(x(1+(p_len-1)*span:jk*span));
else    
    o(p_len) = mean(x(1+(p_len-1)*span:end));
end

end

