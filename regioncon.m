function [x,k, vg] = regioncon(fname,x)

tol = 1.e-04;
Dmin = 1.e-05;
Dmax = 10;
eta = 1/4;
kmax = 50;
n = length(x);
g = gradiente(fname, x);
vg = norm(g);
k = 0;
D = 1.0;

while ( norm(g) > tol && k < kmax)
    B = hessiana(fname, x);
    v = eig(B); 
    vmin = min(v);
    if (vmin <= 0)
        B = B + (abs(vmin) + 0.5) * eye(n);
    end
    
    p = doblez(B,g,D);
    fx = feval(fname,x);
    fx1 = feval(fname, x + p);
    mp = (1/2)*p'*B*p + g'*p + fx;
    
    rho = (fx - fx1)/(fx - mp);
    
    if(rho < eta)
        D = max(Dmin, (1/4)*norm(p) );
    else
        if ( rho > (1-eta) && D == norm(p))
            D = min(Dmax, 2 * D);
        end
    end
%---------------------------------------
    if ( rho > eta)
        x = x + p;
        g = gradiente(fname,x);
        vg = [vg; norm(g)];
    end
%---------------------------------------
    k = k + 1;
end


end

