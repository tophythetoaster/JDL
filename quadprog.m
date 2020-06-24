function X = quadprog(A, B, X0)

numits = 50;
X = X0;
for j = 1 : numits
    X = X .* B ./ (A * X);
end

