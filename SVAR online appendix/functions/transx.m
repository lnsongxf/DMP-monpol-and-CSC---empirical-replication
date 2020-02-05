function [y] = transx(x,tcode)
% Transform  x
%   Return Series with same dimension and corresponding dates
%   Missing values where not calculated
%   -- Tcodes:
%            1 Level
%            2 First Difference
%            3 Second Difference
%            4 Log-Level
%            5 Log-First-Difference
%            6 Log-Second-Difference
%            7 dif[(x(t)/x(t-1))-1]
% 

small=1.0e-06;

n=size(x,1);
y=NaN(n,1);

 if tcode == 1;
  y=x;

 elseif tcode == 2;
  y(2:n)=x(2:n)-x(1:n-1);

 elseif tcode == 3;
  y(3:n)=x(3:n)-2*x(2:n-1)+x(1:n-2);

 elseif tcode == 4;
  if min(x) < small; 
   y=NaN;
  else;
   x=log(x);
   y=x;
  end;
 
 elseif tcode == 5;
  if min(x) < small;  
   y = NaN;
  else;
   x=log(x);
   y(2:n)=x(2:n)-x(1:n-1);
  end;
 
 elseif tcode == 6;
  if min(x) < small;  
   y = NaN;
  else;
   x=log(x);
   y(3:n)=x(3:n)-2*x(2:n-1)+x(1:n-2);
  end;
  
   
 elseif tcode == 7;
  tmp = NaN(n,1);
  tmp(2:end) = (x(2:end)./x(1:end-1))-ones(n-1,1);
  y = dif(tmp,1);
  
 else;
  y = NaN;
 end;

end