function [x1]=chaosc2(r,x0 )
%case 1 of new fractional case 
%   Detailed explanation goes here
      if x0<0.5
        x1=mod(20*sin(r*x0*(1-x0))+(80-r)*x0/2,1);  
      elseif x0>=0.5
        x1=mod(20*exp(r*x0*(1-x0))+(80-r)*(1-x0)/2,1); 
      end
end