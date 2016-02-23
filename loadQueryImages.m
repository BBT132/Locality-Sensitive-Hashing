N = 10;
rowSize = 3072;
%path = 'D:\My Document\University\TimeOfInformation\UNM Courses\CS 521\assignment\Ass4\Query\';
path = '.\Query\'
%path, rowSize, N should be modified according to actual dataset.
queryImageMatrix = zeros(N, rowSize);
for i = 1 : N
    fileName = [path, num2str(i), '.bmp'];
    oneImageMatrix = imread(fileName);
    queryImageMatrix(i, :) = reshape(oneImageMatrix, 1, rowSize);
end
save queryImageMatrix queryImageMatrix;
