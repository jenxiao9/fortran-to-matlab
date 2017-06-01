iteration; 

infile = sprintf('data%d.txt', iteration);
outfile = sprintf('data%d-matlab.txt', iteration);

M = dlmread(infile);

[m, n] = size(M);
N = mean(M, 2);
A = (N(1) + N(2))/2;

for i = 1:2
    for j = 1:n
        M(i, j) = A;
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