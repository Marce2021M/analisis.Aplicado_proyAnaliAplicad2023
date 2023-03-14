function [x,k] = migc(A,b)

n = length(b);
x = zeros(n,1);
r = A*x - b;
p = -r;
kmax = n*n;
k = 0;

while ( norm(r)> 1.e-08 && k < kmax)
   alpha = -(r'*p)/(p'*A*p);
   x = x + alpha * p;
   r = A*x - b;
   betha = (r'*A*p)/(p'*A*p);
   p = -r + betha*p;
   k = k + 1;
end

end