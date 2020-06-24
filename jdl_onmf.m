function [dictionaries, weights] = jdl_onmf(data, r)

X1 = data{1};
[m, n] = size(X1);
T = length(data);

weights = ones(1, n);
dictionaries = cell(1, n);
As = cell(1, n);
Bs = cell(1, n);

for j = 1 : n
    D = rand(m, r);
    A = zeros(r);
    B = zeros(m, r);
    dictionaries{j} = D;
    As{j} = A;
    Bs{j} = B;
end



for t = 1 : T
    
    disp(t);
    
    %code
    X = data{t};
    C = jdl_code(dictionaries, X, weights);
    
    
    %aggregate
    for j = 1 : n
        
        x = X(:, j);
        c = C(:, j);
        
        A = As{j};
        B = Bs{j};
        
        A = (t - 1) * A + c * c';
        A = A / t;
        B = (t - 1) * B + x * c';
        B = B / t;
        
        As{j} = A;
        Bs{j} = B;
        
        
        %aggregate weights
        
        w = weights(j);
        cor = (C(:, 1)' * c) / (norm(C(:, 1)) * norm(c));
        
        w = w^(t - 1);
        w = w * cor;
        w = w^(1 / t);
        weights(j) = w;
        
    end
    

    %dictionary update
    
    for j = 1 : n
        
        D = dictionaries{j};
        A = As{j};
        B = Bs{j};
        D = tran_quadprog(A, B, D);
        dictionaries{j} = D;
        
    end
    
    
end






