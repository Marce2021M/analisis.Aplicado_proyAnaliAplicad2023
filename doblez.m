function [ps] = doblez(B,g,Delta)

pN = -(B\g);
pC = -((g'*g)/(g'*B*g))*g;
if( norm(pN) <= Delta)
    ps = pN;
elseif (norm(pC) >= Delta)
    ps = -Delta*(g/norm(g));
    
else
    alfa = norm(pN-pC)^2;
    beta = 2*pC'*(pN-pC);
    gamma = norm(pC)^2 - Delta^2;
    r = roots([alfa beta gamma ]);
    ts = max(r);
    ps = pC + ts*(pN-pC);
end

