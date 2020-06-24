function C = jdl_code(dictionaries, X, weights)
%dictionaries is cell of dictionary matrices 
%data sample X is matrix whose columns are e.g. time series segments from
%different time series
%weights are used to remove noise or unimportant time series. 
%lambda is a regularization parameter used to enforce correlation of codes
%with first code (which can be thought of as time series of interest)



lambda = 1;



D1 = dictionaries{1};
r = length(D1(1, :));
[m, n] = size(X);
C = rand(r, n);



numits = 50;
for i = 1 : numits
    
    for j = 1 : n
        
        if j == 1
            
            c = C(:, j);
            D = dictionaries{j};
            x = X(:, j);
            c = c .* (D' * x) ./ (D' * D * c);
            C(:, j) = c;
            
        else
            
            c1 = C(:, 1);
            c = C(:, j);
            D = dictionaries{j};
            x = X(:, j);
            w = weights(j);
            numerator = w * D' * x + lambda * c * norm(c)^(-2);
            denominator = w * (D' * D) * c + lambda * c * (c1' * c)^(-1);
            c = c .* numerator ./ denominator;
            C(:, j) = c;
            
        end
        
        
    end
     
end


















