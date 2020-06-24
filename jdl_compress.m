function errors = jdl_compress(dictionaries, data, weights)

n = length(dictionaries);
D1 = dictionaries{1};
[m, r] = size(D1);
T = length(data);

errors = zeros(1, n);

for t = 1 : T
    X = data{t};
    C = jdl_code(dictionaries, X, weights);
    
    for j = 1 : n
        c = C(:, j);
        D = dictionaries{j};
        x = X(:, j);
        
        err = norm(x - D * c) / norm(x);
        errors(j) = errors(j) + err;
        
    end
    
end


for j = 1 : n
    
    err = errors(j);
    err = err / T;
    errors(j) = err;
    
end

