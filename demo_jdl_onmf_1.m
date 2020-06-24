%basic demo comparing jdl_onmf and vanilla onmf for time series prediction
%(vanilla onmf is called concat_onmf here, because the data are
%concatenated)

%the training data consists of short time patches extracted from three
%different time series. The first two are, by design "latently correlated,"
%while the third much less so. Running the first code section yields
%weights and relative errors which agree with this intuition. (note here we
%are interested in learning dictionary for first time series, x2 and x3
%below can be thought of as auxiliary time series)


%% makes data synthetic time series, extracts short time patches

h = .01;
T = 1000;
t = h * (1 : T);
x1 = 1 + sin(t);
x2 = 2 - sin(t);
x3 = 1 + sin(20 * t);
time_series = zeros(3, T);
time_series(1, :) = x1;
time_series(2, :) = x2;
time_series(3, :) = x3;

L = 50;
data = get_data(time_series, L);


%% "robust joint dictionary learning,"   

r = 10;
[Ds, weights] = jdl_onmf(data, r);


%% dictionary learning by vanilla onmf (concat_onmf) 

Ds2 = concat_onmf(data, r);


%% display jdl results

figure;
plot_jds(Ds);

disp('Weights obtained from jdl learning:');
disp(weights);

errors = jdl_compress(Ds, data, weights);
disp('Average relative reconstruction error for each jdl dictionary:');
disp(errors);


%% display concat results

figure;
plot_jds(Ds2);

errors = concat_compress(Ds2, data);
disp('Average relative reconstruction error for each vanilla dictionary:');
disp(errors);

