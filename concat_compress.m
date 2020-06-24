function errors = concat_compress(dictionaries, data)

n = length(dictionaries);
D1 = dictionaries{1};
[m, r] = size(D1);
T = length(data);

errors = zeros(1, n);

for t = 1 : T
    X = data{t};
    c = concat_code(dictionaries, X);
    
    for j = 1 : n
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
