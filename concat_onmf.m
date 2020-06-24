function dictionaries = concat_onmf(data, r)

X1 = data{1};
[m, n] = size(X1);
T = length(data);

dictionaries = cell(1, n);
for j = 1 : n
    D = rand(m, r);
    dictionaries{j} = D;  
end

A = zeros(r);
B = zeros(m * n, r);


for t = 1 : T
    
    disp(t);
    
    %code 
    X = data{t};
    c = concat_code(dictionaries, X);
    x = X(:);
    
    
    %aggregate
    A = (t - 1) * A + c * c';
    A = A / t;
    B = (t - 1) * B + x * c';
    B = B / t;
    
    
    %update dictionary 
    D = zeros(n * m, r);
    for j = 1 : n
        D(1 + (j - 1) * m : j * m, :) = dictionaries{j};
    end
    D = tran_quadprog(A, B, D);
    for j = 1 : n
        dictionaries{j} = D(1 + (j - 1) * m : j * m, :);
    end
    

    
end








