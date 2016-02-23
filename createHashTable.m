loadImage;
N = 100000;
rowSize = 3072;
M = 700;
k = int8(log(M) /log(2));%k = log(M)
a = 0.4;
%all the parameters above should be changed according to 
%properties of the specific problems.
L = int16(M ^ a);%L = M^a
R = randn(rowSize, k, L);
Q = zeros(N, L);
for tableID = 1 : L
   Q(:, tableID) = sum(imageMatrix(1:N, :) * R( :, :, tableID), 2); 
end
bucketSize = int16(N / M * 3.5);
table = zeros( bucketSize, M, L);
for tableID = 1 : L
  table(1, :, tableID) = norminv(0.000001:1 / M :1-0.00000001, mean(Q(:, tableID)), std(Q(:, tableID), 1));
end
for tableID = 1 : L
    for i = 1 : N
        for j = 1 : M
            if(Q(i, tableID) < table( 1, j,tableID))
                if( j == 1)
                    table(2,j, tableID) = table(2,j,tableID) + 1;
                    table(2 + table(2, j, tableID), j, tableID) = i;
                else
                   table(2,j - 1, tableID) = table(2,j - 1,tableID) + 1;
                   table(2 + table(2, j - 1, tableID), j - 1, tableID) = i;
                end
               break;
            elseif(j == M)
                table(2,M, tableID) = table(2,M, tableID) + 1;
                table(2 + table(2, M, tableID), M, tableID) = i;    
            end
        end
    end
end

