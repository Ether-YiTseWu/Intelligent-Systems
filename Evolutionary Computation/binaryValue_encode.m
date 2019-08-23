function out = binaryValue_encode(decodeGeneration,origindecodeGeneration)      %對解碼後的二元編碼人口(-10:20/1023:10)轉為1~1024的數值

for i =1:10
    
    for j = 1:1024
        if origindecodeGeneration(j) == decodeGeneration(i)     %
            out (i) = j;
        end
    end
    
end

end