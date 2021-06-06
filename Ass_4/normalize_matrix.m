function norm = normalize_matrix(R)
for i = 1:3
    R(:, i) = R(:, i)/sum(abs(R(:, i)));
end
norm = R;

