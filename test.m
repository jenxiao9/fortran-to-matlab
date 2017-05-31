iteration; 

infile = sprintf('data%d.txt', iteration);
outfile = sprintf('data%d-matlab.txt', iteration);

M = dlmread(infile);

[m, n] = size(M);
N = zeros(n, m);

for i = 1:m
    for j = 1:n
        N(j, i) = M(i, j);
    end
end

fileID = fopen(outfile, 'w');

for i = 1:n
    for j = 1:m
        fprintf(fileID, '   %f    ', N(i, j));
    end
    fprintf(fileID, '\r\n');
end

fclose(fileID);
fprintf('success\n');

quit