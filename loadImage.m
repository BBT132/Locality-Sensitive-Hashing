N = 100000;
rowSize = 3072;
%path = 'D:\My Document\University\TimeOfInformation\UNM Courses\CS 521\assignment\Ass4\dataset\';
path = '.\dataset'
%path, rowSize, N should be modified according to actual dataset.
imageMatrix = zeros(N, rowSize);
for i = 1 : N
    fileName = [path, num2str(i), '.bmp'];
    oneImageMatrix = imread(fileName);
    imageMatrix(i, :) = reshape(oneImageMatrix, 1, rowSize);
end
save imageMatrix imageMatrix;
