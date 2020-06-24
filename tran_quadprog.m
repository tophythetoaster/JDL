function X = tran_quadprog(A, B, X0)

X = X0;
numits = 50;
for j = 1 : numits
    
    X = X .* B ./ (X * A);
    
end