function [ Var ] = Variance( I )

[m n] = size(I);
Mmean = mean2(I); % mean of the image;
Total = m*n;
VarI = zeros(1,Total);
for q = 1:m
    for p = 1:n
        VarE = (I(q,p) - Mmean)^2;
        VarI(q*p) = VarE;
    end
end
Varsum = sum(VarI);
Var = Varsum/(Total);

end

