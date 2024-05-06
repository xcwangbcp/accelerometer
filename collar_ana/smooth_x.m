function [ o ] = smooth_x( x,span )
%SMOOTH_X Summary of this function goes here
%   Detailed explanation goes here

% x must be a vector
% span must be a odd number
% if meet NaN, output is NaN

len = length(x);
o=zeros(len,1);
if (rem(span,2)~=0)
    warning('span should be odd---smooth_x()');
    return;
end
mid_span=span/2;
end_edge = len-mid_span;
for jj=1:mid_span
    tmp=x(1:jj);
    if(any(isnan(tmp)))
        o(jj)=NaN;
        continue;
    else
        o(jj)=mean(tmp);        
    end    
end

for jj=mid_span+1:end_edge
    tmp=x(jj-mid_span+1:jj+mid_span);    
    if(any(isnan(tmp)))
        o(jj)=NaN;
        continue;
    else
        o(jj)=mean(tmp);        
    end
end

for jj=end_edge:len
    tmp=x(jj:end);
    if(any(isnan(tmp)))
        o(jj)=NaN;
        continue;
    else
        o(jj)=mean(tmp);        
    end
end



end

