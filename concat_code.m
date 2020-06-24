function c = concat_code(dictionaries, X)

D1 = dictionaries{1};
[m, r] = size(D1);
n = length(dictionaries);
D = zeros(n * m, r);
for j = 1 : n
    D(1 + (j - 1) * m : j * m, :) = dictionaries{j};
end

x = X(:);
A = D' * D;
B = D' * x;

c = rand(r, 1);
c = quadprog(A, B, c);


