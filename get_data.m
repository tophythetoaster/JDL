function data = get_data(time_series, L)

[n, T] = size(time_series);
data = cell(1, T - L + 1);
for t = 1 : T - L + 1
    
    X = time_series(:, t : t + L - 1);
    X = X';
    data{t} = X;
    
end