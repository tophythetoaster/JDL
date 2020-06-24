function plot_jds(Ds)

n = length(Ds);
D1 = Ds{1};
[m, R] = size(D1);

l = ceil(sqrt(R));
tiledlayout(l, l);

for r = 1 : R
    nexttile;
    
    Y = zeros(n, m);
    for j = 1 : n
        D = Ds{j};
        y = D(:, r);
        y = y';
        Y(j, :) = y;
    end
    plot(1 : m, Y);
    
    
end