loadQueryImages;
N = 10;
%N should be modified according to specific problem.
queryResult = zeros(N, 1);
for i = 1 : N
imageVector = queryImageMatrix(i, :);
minDis = 1e6;
ID = 0;
shiftBucket = 4;
for p = 1 : L
    hashKey = sum(imageVector * R(:, :, p));
  for j = 1 : M
      if(hashKey < table(1, j, p))
          for q = - shiftBucket : shiftBucket
              bucketIndex = j - 1 + q;
              if(bucketIndex < 1 || bucketIndex > M)
                  continue;
              end
              bracketSize = table(2, bucketIndex, p);
              for n = 1 : bracketSize
                imageID = table(2 + n, bucketIndex, p);
                temp = sum(abs(imageMatrix(imageID, :) - imageVector));
                if(temp < minDis)
                    ID = imageID;
                    minDis = temp;
                end
              end
          end     
          break;
      elseif(j == M)
          bracketSize = table(2, j, p);
          minDis = 1e6;   
          for n = 1 : bracketSize
              imageID = table(2 + n, j, p);
              temp = sum(abs(imageMatrix(imageID, :) - imageVector));
              if(temp < minDis)
                  ID = imageID;
                  minDis = temp;
              end
          end
      end
  end
end

queryResult(i) = ID;
end
queryResult
fileName = ['M_', num2str(M), 'a_', num2str(a)];
eval(['save ' fileName ' queryResult ' '-ascii;']);
                  